// C++ imports
#include <stdio.h>
#include <iostream>
#include <stdint.h>
#include <assert.h>
#include <fstream>
#include <string>
#include <vector>
#include <algorithm>
#include <cmath>
#include <math.h>
#include <time.h>
#include <bitset>

// Vitis imports
 #include "ap_int.h"
// #include hls_stream.h
// #include hls_vector.h

// Namespaces
using namespace std;

// Import math keywords
#define _USE_MATH_DEFINES

// Global Constants
#define totalLayers 5 // Each layer corresponds to the set of hits detected by a single sensor, default 5
#define defaultLayersQC totalLayers // Quality Control is written for 5 layers
#define middleLayers 3 // totalLayers-2, default 3
#define anchorLayer 1 // middle of middleLayers, default 1
#define adjacentLayers 2 // Each middle layer has 2 adjacent layers
#define numberOfNodes 16 // Each node corresponds to a "hit" picked up by a sensor; we assume that each layer has 16 hits for the sake of this project
#define adjacentNodes 16 // Each middle layer node has 16 adjacent nodes above and below
#define highestPower 4 // log_2(numberOfNodes)
#define coordinateParticle1 2
#define coordinateParticle2 3
#define acceptLink true 
#define rejectLink false
#define upLink 0
#define downLink 1
#define aboveLayerIndex 0
#define belowLayerIndex 1
#define killLaplacianValue -1
//#define killLaplacianValue 999999
#define indexTYPE std::uint8_t  // data type for array indices
#define fakeIndex 0xFF // initialization value of best found track = 255, since good track will be 0-15 (0-F in hex)
#define structTYPE ap_int<16> // data type for coded structure, laplacian + upLink + downLink
//#define structTYPE int
#define laplacianTYPE int // data type for laplacian and node (hit) coordinates
#define spacepointTYPE ap_int<32> // data type for 2D spacepoint coordinates (packed)
//#define spacepointTYPE int // data type for 2D spacepoint coordinates, separate X and Y
#define nWeightedCoordinates 5 // each coordinate has 3 weighted versions for laplacian calculation and 2 for slope calculation
#define eventPipelineStages 7 // number of events in pipeline
#define numberOfDirections 2 // rows and columns for upward layer and downward layer
#define nPixelDimensions 2 // for 2D pixels, X and Y coordinates of hit
#define nMetrics 2 // number of track quality metrics
#define rowDirection 0
#define columnDirection 1
#define combinedNodeProcessor false
#define inlineModules true
#define useDSPbyDecoding true
#define badMetric 10000
/*
	Returns a random integer between min and max
	@param min The lower bound (inclusive) for the random integer
	@param max The upper bound (inclusive) for the random integer
	@return the random integer
*/
int random(int min, int max) {
   static bool first = true;
   if (first) {  
      srand( time(NULL) ); //seeding for the first time only!
      first = false;
   }
   return min + rand() % (( max + 1 ) - min);
}
/*
	Generate test coordinate inputs based on several possible collision outcomes
	@param layerRadii[totalLayers] The radius of each sensor in centimeters
	@param theta[numberOfNodes] The angle in radians of each hit (only used with outcome param option 0)
	@param fragmentsPerCollision The number of fragments resulting from a particle collision
	@param numberOfCollisionsPerTime The number of collisions every bunch crossing which occurs every 25 ns
	@param pixelWidth The micron width of each pixel in one dimension
	@param numberOfSections The number of sections that the sensor is split into (x sections --> x - 1 vertical planes perpendicar to the z axis)
	@param outcome Calibrates generateCoordinates for a particular collision outcome: 0 for one curved path, 1 for two curved paths, 2 for no curved paths 
    @param curveRadius The radius of curvature corresponding to the equation p = 0.3 Br
*/
// TODO nBits for Laplacian
void generateCoordinates(int layerRadii[totalLayers], int fragmentsPerCollision, int numberOfCollisionsPerTime, double pixelWidth, int numberOfSections, int outcome, int curveRadius,
	    int coordinates[totalLayers][numberOfNodes]) {
    int curvedLine1 = random(1, 12566); // TODO: try to get calculation for the 12566 to make this more general
    int curvedLine2 = random(1, 12566); // TODO: change the pixel values accordingly now that we are using smaller pie slice and doing closer to reality simulations
    ofstream CurvedFile;
    CurvedFile.open ("Curved.txt");
    int flat = random(-9,10);
    int sign;
    if (flat > 0) sign = 1;
    else sign = -1;
	for (int layer = 0; layer < totalLayers; layer++) { // TODO: add in change of direction of curvature randomly
		int numberOfFragmentsPerTime = fragmentsPerCollision*numberOfCollisionsPerTime;
		int fragmentsPerPart = (int) numberOfFragmentsPerTime/numberOfSections;
		double circumferenceLayer = 2*layerRadii[layer]*M_PI;
		double fragmentsDensityLayer = fragmentsPerPart/circumferenceLayer; // fragments per centimeter
		double pixelDensity = 1/pixelWidth; // 1 is 1 cm, pixelDensity is in pixels/centimeter
		double averageNumberOfPixelsPerParticle = pixelDensity/fragmentsDensityLayer; // e.g. every 10th pixel has a particle
		int maxNumPixelsLayer = pixelDensity*circumferenceLayer;

		for (int fragmentIndex = 0; fragmentIndex < fragmentsPerCollision; fragmentIndex++) {
			// hit corresponds to pixel index; previously multiplied by pixelWidth to get and store physical distance in 1 dimension; can multiply*10000 is to go from cm to microns
			// TODO: note that 3500 is the true value of fragmentsPerCollision; we want to look at a slice with 16, not the whole circumference and say that that has 16; having a slice with only 16 is closer to reality; can implement this at some point
			int hit = random(1, maxNumPixelsLayer)/(layer+1); 
			// TODO: need to implement bias for when a particle is closer to one side or the other of a pixel
			coordinates[layer][fragmentIndex] = hit; 
		}
        // Calculate angle at which a fragment travelling along radius of curvature curveRadius intersects layer
        double curveTheta = asin(((double)layerRadii[layer])/((double)curveRadius));
        
		if (outcome == 0) {
            // Calculate the pixel index at which a fragment travelling along radius of curvature curveRadius intersects layer
            coordinates[layer][coordinateParticle1] = curvedLine1 + sign*(int)(10000/25)*((double)curveRadius - abs(((double)curveRadius)*cos(curveTheta)));
            curvedLine1 = coordinates[layer][coordinateParticle1];
            CurvedFile <<  curvedLine1 << "\n";
		} else if (outcome == 1) {
            coordinates[layer][coordinateParticle1] = curvedLine1 + sign*(int)(10000/25)*((double)curveRadius - abs(((double)curveRadius)*cos(curveTheta)));  // TODO: make +- random for curvedLine1 +-
            curvedLine1 = coordinates[layer][coordinateParticle1];
			coordinates[layer][coordinateParticle2] = curvedLine2 - sign*(int)(10000/25)*((double)curveRadius - abs(((double)curveRadius)*cos(curveTheta)));
            curvedLine2 = coordinates[layer][coordinateParticle2];
            CurvedFile <<  curvedLine1 << ", " << curvedLine2 << "\n";
		} 
        // Sort each coordinate in layer spatially by index
		int n = sizeof(coordinates[layer]) / sizeof(coordinates[layer][0]);
		sort(coordinates[layer], coordinates[layer] + n);
	}
    CurvedFile.close();
	return;
}
/*
	Encodes (aboveNodeIndex, belowNodeIndex, Laplacian) as an integer 
	@param aboveNodeIndex The index corresponding to a node in the layer above a particular node
	@param belowNodeIndex The index corresponding to a node in the layer below a particular node
	@param Laplacian The Laplacian value for the path represented by this particular triplet
	@return An integer that stores the aboveNodeIndex, belowNodeIndex, and Laplacian values corresponding to a middleLayer node as fixed bit widths 
*/
structTYPE tripletEncode(indexTYPE aboveNodeIndex, indexTYPE belowNodeIndex, laplacianTYPE Laplacian){
	#pragma HLS INLINE
    return  (((structTYPE) Laplacian )<<8) | ((structTYPE) aboveNodeIndex)  | (((structTYPE) belowNodeIndex)<<4);
}
/*
	Returns the Laplacian value given the bit encoded triplet
	@param triplet An integer that stores the aboveNodeIndex, belowNodeIndex, and Laplacian value corresponding to a middleLayer node
*/
laplacianTYPE decodeLaplacian(structTYPE triplet){
    #pragma HLS INLINE
    return (laplacianTYPE) triplet>>8;
}
/*
	Returns the aboveNodeIndex value given the bit encoded triplet
	@param triplet An integer that stores the aboveNodeIndex, belowNodeIndex, and Laplacian value corresponding to a middleLayer node
*/
indexTYPE decodeAboveNodeIndex(structTYPE triplet){
    #pragma HLS INLINE
    return  (indexTYPE) (triplet & 0xF);
}
/*
	Returns the belowNodeIndex value given the bit encoded triplet
	@param triplet An integer that stores the aboveNodeIndex, belowNodeIndex, and Laplacian value corresponding to a middleLayer node
*/
indexTYPE decodeBelowNodeIndex(structTYPE triplet){
    #pragma HLS INLINE
    return  (indexTYPE) ((triplet & 0xF0)>>4);
}
laplacianTYPE decodeXcoordinate(spacepointTYPE packedCoordinates){
    #pragma HLS INLINE
    return  (laplacianTYPE) ( ((packedCoordinates & 0xFFFF0000)>>16) & 0x0000FFFF);
}
laplacianTYPE decodeYcoordinate(spacepointTYPE packedCoordinates){
    #pragma HLS INLINE
    return  (laplacianTYPE) (packedCoordinates & 0x0000FFFF);
}
/*
	Calculates the Laplacian values for all of the triplets associated with a single node and stores each bit encoded triplet
	in triplet[numberOfNodes][numberOfNodes]
	@param aboveNodeList The list of nodes in the layer above the current node
	@param belowNodeList The list of nodes in the layer below the current node
	@param nodeTriplets A sub-matrix of tripletMatrix corresponding to a single node that stores all of the triplets
						associated with that node
	@param nodeTripletsTranspose A sub-matrix of tripletMatrixTranspose corresponding to a single node that stores all of the triplets
						associated with that node
	@param laplacianWeights The first value is w_(ijk,l) number that weights the Laplacians in the trackTrigger.pdf paper, and the second value is the value corresponding to a + c - laplacianWeights[1]b in the discrete Laplacian calculation
	@param inputNode The coordinates of the node that we are generating the triplets for
*/
#if useDSPbyDecoding == false
void makeAdder(spacepointTYPE thisNode, spacepointTYPE inputNode, laplacianTYPE (& halfLaplacian)[nPixelDimensions]){
#pragma HLS INLINE
		halfLaplacian[0] = decodeXcoordinate(thisNode) + decodeXcoordinate(inputNode);
		halfLaplacian[1] = decodeYcoordinate(thisNode) + decodeYcoordinate(inputNode);
return;
}
#elif useDSPbyDecoding == true
void makeAdder(laplacianTYPE thisNode[nPixelDimensions], laplacianTYPE inputNode[nPixelDimensions], laplacianTYPE (& halfLaplacian)[nPixelDimensions]){
#pragma HLS INLINE
		halfLaplacian[0] = thisNode[0] + inputNode[0];
		halfLaplacian[1] = thisNode[1] + inputNode[1];
return;
}
#endif

#if useDSPbyDecoding == false
void makeHalfLaplacian(spacepointTYPE nodeList[adjacentNodes], laplacianTYPE inputNode[nPixelDimensions], laplacianTYPE (& halfLaplacian)[adjacentNodes][nPixelDimensions])
#elif useDSPbyDecoding == true
void makeHalfLaplacian(laplacianTYPE nodeList[adjacentNodes][nPixelDimensions], laplacianTYPE inputNode[nPixelDimensions], laplacianTYPE (& halfLaplacian)[adjacentNodes][nPixelDimensions])
#endif
{
#pragma HLS INLINE OFF
makeHalfLaplacianLoop: for (indexTYPE nodeIndex=0; nodeIndex<adjacentNodes; nodeIndex++) {
	         	       #pragma HLS UNROLL
#if useDSPbyDecoding == false
                          halfLaplacian[nodeIndex][0] = decodeXcoordinate(nodeList[nodeIndex]) + inputNode[0];  halfLaplacian[nodeIndex][1] = decodeYcoordinate(nodeList[nodeIndex]) + inputNode[1];
#elif useDSPbyDecoding == true
                          halfLaplacian[nodeIndex][0] = nodeList[nodeIndex][0] + inputNode[0]; halfLaplacian[nodeIndex][1] = nodeList[nodeIndex][1] + inputNode[1];
#endif
					   }
return;
}
void makeAbs(laplacianTYPE laplacian[adjacentNodes][nPixelDimensions],  laplacianTYPE (& absLaplacian) [adjacentNodes]) {
#pragma HLS INLINE
makeAbsLoop: for (indexTYPE nodeIndex=0; nodeIndex<adjacentNodes; nodeIndex++) {
			 #pragma HLS UNROLL
            	absLaplacian[nodeIndex] = std::abs(laplacian[nodeIndex][0]) + std::abs(laplacian[nodeIndex][1]);
             }
return;
}
#if useDSPbyDecoding == false
void singleNodeLaplacianCalculator(spacepointTYPE aboveNodeList[adjacentNodes], spacepointTYPE belowNodeList[adjacentNodes], spacepointTYPE inputNode, structTYPE (&nodeTriplets)[adjacentNodes][adjacentNodes]) {
#elif useDSPbyDecoding == true
void singleNodeLaplacianCalculator(laplacianTYPE aboveNodeList[adjacentNodes][nPixelDimensions], laplacianTYPE belowNodeList[adjacentNodes][nPixelDimensions], laplacianTYPE inputNode[nPixelDimensions], structTYPE (&nodeTriplets)[adjacentNodes][adjacentNodes]) {
#endif
	#pragma HLS INLINE OFF
	laplacianTYPE halfLaplacian[adjacentNodes][nPixelDimensions];
    #pragma HLS array_partition variable=halfLaplacian complete dim=0
	laplacianTYPE laplacian[adjacentNodes][nPixelDimensions];
    #pragma HLS array_partition variable=laplacian complete dim=0
	laplacianTYPE absLaplacian[adjacentNodes][adjacentNodes];
    #pragma HLS array_partition variable=absLaplacian complete dim=0

SNLCaboveNodeLoop: for (indexTYPE aboveNodeIndex=0; aboveNodeIndex<adjacentNodes; aboveNodeIndex++) {
				   #pragma HLS PIPELINE
     				 makeAdder(aboveNodeList[aboveNodeIndex], inputNode, halfLaplacian[aboveNodeIndex]);
                     makeHalfLaplacian(belowNodeList, halfLaplacian[aboveNodeIndex], laplacian);
                     makeAbs(laplacian, absLaplacian[aboveNodeIndex]);
			       }
SNLCaboveLoopEncode: for (indexTYPE aboveNodeIndex=0; aboveNodeIndex<adjacentNodes; aboveNodeIndex++) {
				   #pragma HLS UNROLL
SNLCbelowLoopEncode:  for (indexTYPE belowNodeIndex=0; belowNodeIndex<adjacentNodes; belowNodeIndex++) {
						  #pragma HLS UNROLL
     				      nodeTriplets[aboveNodeIndex][belowNodeIndex] = tripletEncode(aboveNodeIndex, belowNodeIndex, absLaplacian[aboveNodeIndex][belowNodeIndex]); // Bit encode the node indices and Laplacian into a structTYPE that represents the triplet, Store the triplet in the corresponding array position
			          }
			       }
    return;
}
template<std::size_t weightsToUnpack>
void decodeCoordinates(spacepointTYPE coordinatesIn[totalLayers][nWeightedCoordinates][numberOfNodes], laplacianTYPE (& coordinatesOut)[totalLayers][weightsToUnpack][numberOfNodes][nPixelDimensions]) {
#pragma HLS INLINE OFF
dCLayerLoop: for (indexTYPE layer=0; layer<totalLayers; layer++) {
	         #pragma HLS UNROLL
dCweightLoop:		for (indexTYPE weightIndex=0; weightIndex<weightsToUnpack; weightIndex++) {
					#pragma HLS UNROLL
dCNodeLoop:	   			 for (indexTYPE nodeIndex=0; nodeIndex<numberOfNodes; nodeIndex++) {
						 #pragma HLS UNROLL
							coordinatesOut[layer][weightIndex][nodeIndex][0] = decodeXcoordinate(coordinatesIn[layer][weightIndex][nodeIndex]);
							coordinatesOut[layer][weightIndex][nodeIndex][1] = decodeYcoordinate(coordinatesIn[layer][weightIndex][nodeIndex]);
						 } // end nodeLoop
                    } // end weightLoop
	         } // end layerLoop
}
void laplacianCalculator(spacepointTYPE coordinates[totalLayers][nWeightedCoordinates][numberOfNodes], structTYPE (& tripletMatrix)[middleLayers][numberOfNodes][adjacentNodes][adjacentNodes]) {
#pragma HLS INLINE OFF
#if useDSPbyDecoding == true
	laplacianTYPE decodedCoordinates[totalLayers][nWeightedCoordinates-2][numberOfNodes][nPixelDimensions];
	#pragma HLS ARRAY_PARTITION variable=decodedCoordinates dim=0 complete
    decodeCoordinates<nWeightedCoordinates-2>(coordinates, decodedCoordinates); // do not need the weighted coordinates for first derivatives, only need those for 2nd derivatives
#endif
	// Loop through only the middle layers because the uppermost and lowermost layers are not associated with triplets
LaplacianLayerLoop: for (indexTYPE middleLayer=0; middleLayer<middleLayers; middleLayer++) {
                	#pragma HLS UNROLL
LaplacianNodeLoop:	    for (indexTYPE nodeIndex=0; nodeIndex<numberOfNodes; nodeIndex++) {
	       				#pragma HLS UNROLL
#if useDSPbyDecoding == false
							   singleNodeLaplacianCalculator(coordinates[middleLayer+2][2], coordinates[middleLayer][0], coordinates[middleLayer+1][1][nodeIndex], tripletMatrix[middleLayer][nodeIndex]);
#elif useDSPbyDecoding == true
							   singleNodeLaplacianCalculator(decodedCoordinates[middleLayer+2][2], decodedCoordinates[middleLayer][0], decodedCoordinates[middleLayer+1][1][nodeIndex], tripletMatrix[middleLayer][nodeIndex]);
#endif
        	     		} // end nodeLoop
                    } // end layerLoop
}
void compareAndExchange(structTYPE a[], indexTYPE i, indexTYPE j, bool upOrDown) {
   #pragma HLS INLINE
   // true is down sort
   if (upOrDown == false) {
	   // i and j (which are indices) get swapped
	   indexTYPE t = i;
	   i = j;
	   j = t;
   } 
//   if(decodeLaplacian(a[i]) > decodeLaplacian(a[j])) {
   if (a[i] > a[j]) {
        structTYPE t = a[i];
    	a[i] = a[j];
    	a[j] = t;
    }
}
void compareAndExchangeFS(laplacianTYPE a[], indexTYPE i, indexTYPE j, bool upOrDown) {
   #pragma HLS INLINE
   // true is down sort
   if (upOrDown == false) {
	   // i and j (which are indices) get swapped
	   indexTYPE t = i;
	   i = j;
	   j = t;
   }
//   if(decodeLaplacian(a[i]) > decodeLaplacian(a[j])) {
   if (a[i] > a[j]) {
        laplacianTYPE t = a[i];
    	a[i] = a[j];
    	a[j] = t;
    }
}
void compareAndMinimize(structTYPE a[], indexTYPE i, indexTYPE j) {
   #pragma HLS INLINE
//   if(decodeLaplacian(a[i]) > decodeLaplacian(a[j])) {
   if (a[i] > a[j]) a[i] = a[j];
}
void compareAndMinimizePipeline(structTYPE a[], indexTYPE i, indexTYPE j, structTYPE aOut[]) {
   #pragma HLS INLINE
//   if(decodeLaplacian(a[i]) > decodeLaplacian(a[j])) {
   if (a[i] > a[j])
	   aOut[i] = a[j];
   else
	   aOut[i] = a[i];
}
//Bitonic sort from existing codes
template<std::size_t power>
void elementLoop(structTYPE a[], indexTYPE j, indexTYPE mask) {
    #pragma HLS INLINE

    LOOP_OVER_ELEMENTS: for (indexTYPE i=0; i<(1<<power); i++) {
		#pragma HLS unroll
    	indexTYPE ij=i^j;
        if (ij >i) {
        	compareAndExchange(a, i, ij, (i&mask)==0);
        }
    }
}
//Bitonic sort from existing codes
template<std::size_t power>
void elementLoopFS(laplacianTYPE a[], indexTYPE j, indexTYPE mask) {
    #pragma HLS INLINE

    LOOP_OVER_ELEMENTS: for (indexTYPE i=0; i<(1<<power); i++) {
		#pragma HLS unroll
    	indexTYPE ij=i^j;
        if (ij >i) {
        	compareAndExchangeFS(a, i, ij, (i&mask)==0);
        }
    }
}
template<std::size_t powerLength, indexTYPE j, indexTYPE mask>
void elementLoopPipeline(structTYPE a[powerLength], structTYPE (& arrayOut)[powerLength]) {
    #pragma HLS INLINE OFF

    LOOP_OVER_ELEMENTS: for (indexTYPE i=0; i<powerLength; i++) {
		#pragma HLS unroll
    	indexTYPE ij=i^j;
        if (ij >i) {
        	compareAndExchange(a, i, ij, (i&mask)==0);
        }
    }
    copyElementLoop: for (indexTYPE i=0; i<powerLength; i++) {
		#pragma HLS unroll
    	arrayOut[i] = a[i];
    }
}
/*
	Modifies an array of length pow(2, power) such that the smallest value of the array is put in its 0th index
	@param array[(int)pow(2, power)] The array to be sorted
	@param power The power of two that determines how many elements are the the array
*/
template<std::size_t power>
structTYPE MinFinder(structTYPE array[]){
#pragma HLS INLINE OFF
// #pragma HLS PIPELINE II=4   this increases total FF from 4.1M to 5.1M with no benefits in LUT or timing, so do not do this
#pragma HLS ARRAY_PARTITION variable=array complete
		const indexTYPE length = 1<<power;		// length is 2^power. This is the length of array
	    if (power >= 1) {
mfLoop22:   for (indexTYPE j=0; j<length; j+= 2){
				#pragma HLS unroll
            	compareAndMinimize(array, j, j+1);
        	}
	    }
	    if (power >= 2) {
mfLoop44:   for (indexTYPE j=0; j<length; j+= 4){
				#pragma HLS unroll
            	compareAndMinimize(array, j, j+2);
        	}
	    }
	    if (power >= 3) {
mfLoop88:   for (indexTYPE j=0; j<length; j+= 8){
				#pragma HLS unroll
            	compareAndMinimize(array, j, j+4);
        	}
	    }
	    if (power == 4) {
mfLoop1616:  for (indexTYPE j=0; j<length; j+= 16){
				#pragma HLS unroll
            	compareAndMinimize(array, j, j+8);
        	}

	    }
        return (structTYPE) array[0];
}
template<std::size_t powerLength, std::size_t stage>
void MinFinderPipelineStage(structTYPE array[powerLength], structTYPE (& arrayOut)[powerLength]){
#pragma HLS INLINE OFF

// #pragma HLS PIPELINE II=4   this increases total FF from 4.1M to 5.1M with no benefits in LUT or timing, so do not do this
#pragma HLS ARRAY_PARTITION variable=array complete
	const indexTYPE increment = 1<<stage; // stage 0 is eg. 16->8, stage 1 is 8->4 etc when power=4
	const indexTYPE incrementDouble = increment<<1;
mfPLoop:   for (indexTYPE j=0; j<powerLength; j+= incrementDouble ){
				#pragma HLS unroll
            	compareAndMinimize(array, j, j+increment);
        	}
mfPLoop1:   for (indexTYPE j=0; j<powerLength; j+= incrementDouble ){
				#pragma HLS unroll
            	arrayOut[j] = array[j];
        	}
}
/*
	Given an array of length pow(2, power), put the pow(2, power)/2 greatest elements in the last pow(2, power)/2 slots
	in the array
	@param array[(int)pow(2, power)] The array to be sorted
	@param power The power of two that determines how many elements are the the array
*/
template<std::size_t power, std::size_t powerLength>
void MSS(structTYPE work_array[powerLength]) {
#pragma HLS INLINE OFF

	#pragma HLS PIPELINE II=10
    #pragma HLS ARRAY_PARTITION variable=work_array complete
    
    if (power >= 2) {
        LOOP2: for (indexTYPE j=1; j>0; j=j>>1) {
            elementLoop<power>(work_array,j,2);
        }
    } 
    if (power >= 3) {
        LOOP4: for (indexTYPE j=2; j>0; j=j>>1) {
            elementLoop<power>(work_array,j,4);
        }
    } 
    if (power >= 4) {
        LOOP8: for (indexTYPE j=4; j>0; j=j>>1) {
            elementLoop<power>(work_array,j,8);
        }
    }
    elementLoop<power-1>(work_array, 1<<(power-1), 0);
return;
}
template<std::size_t power, std::size_t powerLength>
void fullSort(laplacianTYPE work_array[powerLength]) {
#pragma HLS INLINE OFF

	#pragma HLS PIPELINE II=10
    #pragma HLS ARRAY_PARTITION variable=work_array complete

    const std::size_t halfPowerLength = 1<<(power-1);
    const std::size_t quarterPowerLength = 1<<(power-2);

    if (power >= 2) {
        LOOP2: for (indexTYPE j=1; j>0; j=j>>1) {
            elementLoopFS<power>(work_array,j,2);
        }
    }
    if (power >= 3) {
        LOOP4: for (indexTYPE j=2; j>0; j=j>>1) {
            elementLoopFS<power>(work_array,j,4);
        }
    }
    if (power >= 4) {
        LOOP8: for (indexTYPE j=4; j>0; j=j>>1) {
            elementLoopFS<power>(work_array,j,8);
        }
    }
    elementLoopFS<power-1>(work_array, halfPowerLength, 0);

    if (power > 1) {
        LOOP8FS: for (indexTYPE j=quarterPowerLength; j>0; j=j>>1) {
            elementLoopFS<power>(work_array,j,0);
        }
    }
return;
}
template<std::size_t power, std::size_t powerLength>
void MSSPipelined(structTYPE arrayIn[powerLength], structTYPE (& arrayOut)[powerLength]) {
#pragma HLS INLINE

//	#pragma HLS PIPELINE II=10
    #pragma HLS ARRAY_PARTITION variable=arrayIn complete

	const std::size_t tempArrayLength = 1 + (power-1)*power/2;
	structTYPE tempArray[tempArrayLength][powerLength];
 	#pragma HLS ARRAY_PARTITION variable=tempArray complete dim=0

mssCopy: for (indexTYPE j=0; j<powerLength; j++){
			#pragma HLS unroll
           	tempArray[0][j] = arrayIn[j];
     	 }

    if (power >= 2) {
        elementLoopPipeline<powerLength,1,2>(tempArray[0],tempArray[1]);
    }
    if (power >= 3) {
    	elementLoopPipeline<powerLength,2,4>(tempArray[1],tempArray[2]);
    	elementLoopPipeline<powerLength,1,4>(tempArray[2],tempArray[3]);
    }
    if (power >= 4) {
    	elementLoopPipeline<powerLength,4,8>(tempArray[3],tempArray[4]);
    	elementLoopPipeline<powerLength,2,8>(tempArray[4],tempArray[5]);
    	elementLoopPipeline<powerLength,1,8>(tempArray[5],tempArray[6]);
    }
    elementLoopPipeline<powerLength,powerLength/2,0>(tempArray[tempArrayLength-1],arrayOut);
return;
}
/*
	Sets link corresponding to a single triplet's upLink to acceptLink in allNodesGoodLinks
	@param tripletMatrixMaximum A triplet with a Laplacian value smaller than the first half of triplets in laplacianMinimums after it is sorted by MSS
    @param nodeIndex The index of the node in the layer that the triplet corresponds to
*/
void updateUpLink(structTYPE tripletMatrixMinimum, bool nodeLinks[numberOfNodes],  indexTYPE bestIndex) {
	indexTYPE aboveNodeIndex = decodeAboveNodeIndex(tripletMatrixMinimum);
	nodeLinks[aboveNodeIndex] = acceptLink;
	bestIndex = aboveNodeIndex;
}
/*
	Sets link corresponding to a single triplet's downLink to acceptLink in allNodesGoodLinks
	@param tripletMatrixMaximum A triplet with a Laplacian value smaller than the first half of triplets in laplacianMinimumsTranspose after it is sorted by MSS
    @param nodeIndex The index of the node in the layer that the triplet corresponds to
*/
void updateDownLink(structTYPE tripletMatrixMinimumTranspose, bool nodeLinks[numberOfNodes], indexTYPE bestIndex) {
	indexTYPE belowNodeIndex = decodeBelowNodeIndex(tripletMatrixMinimumTranspose);
	nodeLinks[belowNodeIndex] = acceptLink;
	bestIndex = belowNodeIndex;
}
/*
	Given the allNodesGoodLinks global data structure, run the consensus algorithm between up links and down links:
		Between two nodes there is an up link and down link. Set the value of both links to the AND of the two links
	@Param allNodeGoodLinks The global data structure that encodes the "accepted links" (most likely path taken by a particle fragment between hits)
*/
void pruneGlobalMatrix(bool allNodesGoodLinks[middleLayers][numberOfNodes][adjacentLayers][numberOfNodes], bool tempMM[middleLayers][numberOfNodes][numberOfNodes]){
#pragma HLS INLINE OFF
    // compare middlelayer 0 and 1, then 1 and 2
pruneGMlayer: for (indexTYPE middleLayer=0; middleLayer<middleLayers-1; middleLayer++) {
				#pragma HLS unroll
pruneGMnode:	for (indexTYPE nodeIndex=0; nodeIndex<numberOfNodes; nodeIndex++) {
					#pragma HLS unroll
pruneGMcorr:		for (indexTYPE correspondingNodeIndex=0; correspondingNodeIndex<numberOfNodes; correspondingNodeIndex++) {
						#pragma HLS unroll
						tempMM[middleLayer][nodeIndex][correspondingNodeIndex] = allNodesGoodLinks[middleLayer+1][correspondingNodeIndex][belowLayerIndex][nodeIndex] && allNodesGoodLinks[middleLayer][nodeIndex][aboveLayerIndex][correspondingNodeIndex];
					}
				}
			  }
}
void updateGlobalMatrix(bool allNodesGoodLinks[middleLayers][numberOfNodes][adjacentLayers][numberOfNodes], bool tempMM[middleLayers][numberOfNodes][numberOfNodes]){
#pragma HLS INLINE OFF
updateGMlayer: for (indexTYPE middleLayer=0; middleLayer<middleLayers-1; middleLayer++) {
				#pragma HLS unroll
updateGMnode:	for (indexTYPE nodeIndex=0; nodeIndex<numberOfNodes; nodeIndex++) {
					#pragma HLS unroll
updateGMcorr:		for (indexTYPE correspondingNodeIndex=0; correspondingNodeIndex<numberOfNodes; correspondingNodeIndex++) {
						#pragma HLS unroll
						allNodesGoodLinks[middleLayer][nodeIndex][aboveLayerIndex][correspondingNodeIndex] = tempMM[middleLayer][nodeIndex][correspondingNodeIndex];
						allNodesGoodLinks[middleLayer+1][correspondingNodeIndex][belowLayerIndex][nodeIndex] = tempMM[middleLayer][nodeIndex][correspondingNodeIndex];
					}
				}
			  }
}
void consensusProtocol(bool allNodesGoodLinks[middleLayers][numberOfNodes][adjacentLayers][numberOfNodes]){
#pragma HLS INLINE
	  bool tempMM[middleLayers][numberOfNodes][numberOfNodes];
      #pragma HLS array_partition variable=tempMM complete dim=0
	  pruneGlobalMatrix(allNodesGoodLinks,tempMM);
	  updateGlobalMatrix(allNodesGoodLinks,tempMM);
}
void initializeNodeGlobalMatrix(bool nodeGoodLinks[adjacentLayers][numberOfNodes]){
#pragma HLS INLINE OFF
initMMcorrNode: for (indexTYPE correspondingNodeIndex=0; correspondingNodeIndex<numberOfNodes; correspondingNodeIndex++) {
						#pragma HLS unroll
	                    nodeGoodLinks[aboveLayerIndex][correspondingNodeIndex] = rejectLink;
	                    nodeGoodLinks[belowLayerIndex][correspondingNodeIndex] = rejectLink;
                }
}
void buildNodeTripletsforPruning(bool nodeGoodLinks[adjacentLayers][numberOfNodes], bool nodeBadTriplets[numberOfNodes][numberOfNodes]){
#pragma HLS INLINE OFF
	// Iterate through nodeGoodLinks, if the link is accept, save this decision
buildTripletsNodesAbove: for (indexTYPE aboveNodeIndex=0; aboveNodeIndex<numberOfNodes; aboveNodeIndex++) {
				         #pragma HLS unroll
buildTripletsNodesBelow:     for (indexTYPE belowNodeIndex=0; belowNodeIndex<numberOfNodes; belowNodeIndex++) {
						   	 #pragma HLS unroll
								nodeBadTriplets[aboveNodeIndex][belowNodeIndex] =
								!(nodeGoodLinks[belowLayerIndex][belowNodeIndex] == acceptLink && nodeGoodLinks[aboveLayerIndex][aboveNodeIndex] == acceptLink);
						     }
					     }
}
template<std::size_t powerLength>
void buildOnePrunedMatrix(
		indexTYPE thisNodeBestIndices[adjacentLayers][numberOfNodes],
		bool thisNodeBadTriplet[numberOfNodes][numberOfNodes],
		structTYPE tM[adjacentNodes][adjacentNodes],
		structTYPE (& tMP)[powerLength][powerLength],
		bool (& thisNodeBadTripletPruned)[powerLength][powerLength]){
#pragma HLS INLINE OFF
buildTMPnodesAbove: for (indexTYPE aboveNodeIndex=0; aboveNodeIndex<powerLength; aboveNodeIndex++) {
//                       do not unroll
						indexTYPE originalAbove = thisNodeBestIndices[aboveLayerIndex][aboveNodeIndex];
buildTMPnodesBelow:     for (indexTYPE belowNodeIndex=0; belowNodeIndex<powerLength; belowNodeIndex++) {
//							do not unroll
							indexTYPE originalBelow = thisNodeBestIndices[belowLayerIndex][belowNodeIndex];
							tMP[aboveNodeIndex][belowNodeIndex] = tM[originalAbove][originalBelow];
							thisNodeBadTripletPruned[aboveNodeIndex][belowNodeIndex] = thisNodeBadTriplet[originalAbove][originalBelow];
                        }
					}
}
template<std::size_t powerLength>
void killPrunedNodes(structTYPE (&tMP)[powerLength][powerLength], bool thisNodeBadTripletPruned[powerLength][powerLength]){
#pragma HLS INLINE OFF
killTMPnodesAbove: for (indexTYPE aboveNodeIndex=0; aboveNodeIndex<powerLength; aboveNodeIndex++) {
                        #pragma HLS unroll
killTMPnodesBelow:     for (indexTYPE belowNodeIndex=0; belowNodeIndex<powerLength; belowNodeIndex++) {
							#pragma HLS unroll
							if (thisNodeBadTripletPruned[aboveNodeIndex][belowNodeIndex]) tMP[aboveNodeIndex][belowNodeIndex] = killLaplacianValue;
//							if (thisNodeBadTripletPruned[aboveNodeIndex][belowNodeIndex]) tMP[aboveNodeIndex][belowNodeIndex] = tripletEncode(aboveNodeIndex,belowNodeIndex,killLaplacianValue);
                        }
					}
}
template<std::size_t powerLength>
void buildPrunedMatrices(bool nodeGoodLinks[adjacentLayers][numberOfNodes],indexTYPE bestIndices[adjacentLayers][numberOfNodes],
		structTYPE tM[adjacentNodes][adjacentNodes],structTYPE (&tMP)[powerLength][powerLength]){
#pragma HLS INLINE
		bool nodeBadTriplet[numberOfNodes][numberOfNodes];
		#pragma HLS ARRAY_RESHAPE variable=nodeBadTriplet dim=0 complete
		bool nodeBadTripletPruned[powerLength][powerLength];
		#pragma HLS array_partition variable=nodeBadTripletPruned complete dim=0
	// Iterate through nodeGoodLinks, if the link is accept, insert the corresponding triplet from tripletMatrix into tripletMatrixPruned
		buildNodeTripletsforPruning(nodeGoodLinks, nodeBadTriplet);
		buildOnePrunedMatrix<powerLength>(bestIndices,nodeBadTriplet,tM,tMP,nodeBadTripletPruned);
		killPrunedNodes<powerLength>(tMP,nodeBadTripletPruned);
}
template<std::size_t power, std::size_t powerLength>
void nodeMinFinderEngine(structTYPE TMr[powerLength][powerLength], structTYPE laplacianMinimumsOfNode[numberOfDirections][powerLength]) {
#pragma HLS INLINE
	structTYPE TMslice[powerLength];
 	#pragma HLS ARRAY_PARTITION variable=TMslice complete dim=0
	structTYPE TMTslice[powerLength];
 	#pragma HLS ARRAY_PARTITION variable=TMTslice complete dim=0
	structTYPE TMintermed[power][powerLength];
 	#pragma HLS ARRAY_PARTITION variable=TMintermed complete dim=0
	structTYPE TMTintermed[power][powerLength];
 	#pragma HLS ARRAY_PARTITION variable=TMTintermed complete dim=0
/*
// make transpose of TM
transposeTMnodesAbove: for (indexTYPE aboveNodeIndex=0; aboveNodeIndex<powerLength; aboveNodeIndex++) {
                           #pragma HLS unroll
transposeTMnodesBelow:     for (indexTYPE belowNodeIndex=0; belowNodeIndex<powerLength; belowNodeIndex++) {
    							#pragma HLS unroll
								TM[aboveNodeIndex][belowNodeIndex] = TMr[aboveNodeIndex][belowNodeIndex];
								TMT[belowNodeIndex][aboveNodeIndex] = TMr[aboveNodeIndex][belowNodeIndex];
                           }
    			       }
// Store the triplets with the smallest Laplacian values per adjacent node to nodeIndex in laplacianMinimums (above nodes)
// or laplacianMinimumsTranspose (below nodes). laplacianMinimums is an array of size 2^power, which corresponds to the greatest
// possible number of triplets that were accepted the last time updateUpLink and updateDownLink were run

runMinFinders:	for (indexTYPE adjacentNodeIndex=0; adjacentNodeIndex<powerLength; adjacentNodeIndex++) {
					#pragma HLS unroll
					laplacianMinimumsOfNode[adjacentNodeIndex] = MinFinder<power>(TM[adjacentNodeIndex]);
    				laplacianMinimumsOfNodeTranspose[adjacentNodeIndex] = MinFinder<power>(TMT[adjacentNodeIndex]);
				}
*/
runMinFinders:	for (indexTYPE adjacentNodeIndex=0; adjacentNodeIndex<powerLength; adjacentNodeIndex++) {
					#pragma HLS pipeline

makeTMslice:        for (indexTYPE nodeIndex=0; nodeIndex<powerLength; nodeIndex++) {
	    				#pragma HLS unroll
						TMslice[nodeIndex] = TMr[adjacentNodeIndex][nodeIndex];
						TMTslice[nodeIndex] = TMr[nodeIndex][adjacentNodeIndex];
                    }
					MinFinderPipelineStage<powerLength,0>(TMslice,TMintermed[0]);
					MinFinderPipelineStage<powerLength,0>(TMTslice,TMTintermed[0]);
				    if (power >= 2) {
				    	MinFinderPipelineStage<powerLength,1>(TMintermed[0],TMintermed[1]);
				    	MinFinderPipelineStage<powerLength,1>(TMTintermed[0],TMTintermed[1]);
				    }
				    if (power >= 3) {
				    	MinFinderPipelineStage<powerLength,2>(TMintermed[1],TMintermed[2]);
				    	MinFinderPipelineStage<powerLength,2>(TMTintermed[1],TMTintermed[2]);
				    }
				    if (power == 4) {
				    	MinFinderPipelineStage<powerLength,3>(TMintermed[2],TMintermed[3]);
				    	MinFinderPipelineStage<powerLength,3>(TMTintermed[2],TMTintermed[3]);
				    }
					laplacianMinimumsOfNode[rowDirection][adjacentNodeIndex] = TMintermed[power-1][0];
					laplacianMinimumsOfNode[columnDirection][adjacentNodeIndex] = TMTintermed[power-1][0];
				}
}
template<std::size_t power, std::size_t powerLength>
void nodeMSSEngine(structTYPE laplacianMinimumsOfNode[numberOfDirections][powerLength],
		bool nodeLinks[adjacentLayers][numberOfNodes], indexTYPE bestIndices[adjacentLayers][numberOfNodes]) {
#pragma HLS INLINE OFF
		structTYPE laplacianMinimumsOutput[numberOfDirections][powerLength];
		#pragma HLS ARRAY_PARTITION variable=laplacianMinimumsOutput complete dim=0
		structTYPE lapMinSlice[powerLength];
		#pragma HLS ARRAY_PARTITION variable=lapMinSlice complete dim=0
		structTYPE lapMinSorted[powerLength];
		#pragma HLS ARRAY_PARTITION variable=lapMinSorted complete dim=0

		const std::size_t tempArrayLength = (power-1)*power/2;
		structTYPE tempArray[tempArrayLength][powerLength];
		#pragma HLS ARRAY_PARTITION variable=tempArray complete dim=0

                // TODO: see if we can pass in the triplets and do comparisons on the triplets (not the laplacians) for MSS and Minfinder
//				MSS<power,powerLength>(laplacianMinimumsOfNode[rowDirection]);
//				MSS<power,powerLength>(laplacianMinimumsOfNode[columnDirection]);
runMSS:	for (indexTYPE direction=0; direction<numberOfDirections; direction++) {
				#pragma HLS pipeline
makeLapMinSlice:        for (indexTYPE nodeIndex=0; nodeIndex<powerLength; nodeIndex++) {
		    				#pragma HLS unroll
							lapMinSlice[nodeIndex] = laplacianMinimumsOfNode[direction][nodeIndex];
	                    }
						MSSPipelined<power,powerLength>(lapMinSlice,lapMinSorted);

saveLapMinSorted:       for (indexTYPE nodeIndex=0; nodeIndex<powerLength; nodeIndex++) {
		    				#pragma HLS unroll
							laplacianMinimumsOutput[direction][nodeIndex] = lapMinSorted[nodeIndex];
	                    }

		}
				// Set allNodesGoodLinks to all rejectLinks. Since we already stored all possible triplets corresponding to acceptLinks in tripletMatrixPruned, we no longer need to keep the record in allNodesGoodLinks.
				// Refreshing allNodesGoodLinks allows us to further decrease the possible triplet solutions and update allNodesGoodLinks with updateLink again with a fewer number of triplets, then repeat the process until
				// there is at most one triplet per node.
			   initializeNodeGlobalMatrix(nodeLinks);

			// Accept the links corresponding to the smallest half of the triplets stored in the Minimums lists
updateLinks:	for (indexTYPE largestTripletIndex=0; largestTripletIndex < (1<<(power-1)); largestTripletIndex++) {
// unrolling this loop increases LUT from 85K to 97K for nodeMSSEngine, and only saves 3 cycles at 1.5 ns, so we do not unroll
					updateUpLink(laplacianMinimumsOutput[rowDirection][largestTripletIndex], nodeLinks[aboveLayerIndex], bestIndices[aboveLayerIndex][largestTripletIndex]);
					updateDownLink(laplacianMinimumsOutput[columnDirection][largestTripletIndex], nodeLinks[belowLayerIndex], bestIndices[belowLayerIndex][largestTripletIndex]);
                }
}
template<std::size_t power>
void nodeProcessor(bool nodeGoodLinks[adjacentLayers][numberOfNodes], indexTYPE bestIndices[adjacentLayers][numberOfNodes], structTYPE tM[adjacentNodes][adjacentNodes]) {
#pragma HLS INLINE OFF
	const std::size_t localPowerLength = 1<<power;

    // MinFinder and MSS modify the array passed in. To create tripletMatrixPruned in the power loop, we must maintain the index correspondence between tripletMatrix and allNodesGoodLinks. Therefore, MinFinder
	// and MSS must modify copies of tripletMatrix rather than tripletMatrix itself
	structTYPE tripletMatrixPruned[localPowerLength][localPowerLength];
    #pragma HLS ARRAY_PARTITION variable=tripletMatrixPruned complete dim=0
	structTYPE laplacianMinimumsOfNode[localPowerLength];
	#pragma HLS ARRAY_PARTITION variable=laplacianMinimumsOfNode complete dim=0
	structTYPE laplacianMinimumsOfNodeTranspose[localPowerLength];
	#pragma HLS ARRAY_PARTITION variable=laplacianMinimumsOfNodeTranspose complete dim=0

        if (power != highestPower) {
						buildPrunedMatrices<localPowerLength>(nodeGoodLinks,bestIndices,tM,tripletMatrixPruned);
        } else {
laplacianAboveNodeCopy: 	for (indexTYPE aboveNodeIndex=0; aboveNodeIndex<adjacentNodes; aboveNodeIndex++) {
								#pragma HLS UNROLL
laplacianBelowNodeCopy:  		for (indexTYPE belowNodeIndex=0; belowNodeIndex<adjacentNodes; belowNodeIndex++) {
									#pragma HLS UNROLL
	 	 	 	 	 	 	 	 	tripletMatrixPruned[aboveNodeIndex][belowNodeIndex] = tM[aboveNodeIndex][belowNodeIndex];
								}
							}
	   }

	   nodeMinFinderEngine<power,localPowerLength>(tripletMatrixPruned,laplacianMinimumsOfNode,laplacianMinimumsOfNodeTranspose);
	   nodeMSSEngine<power,localPowerLength>(laplacianMinimumsOfNode,laplacianMinimumsOfNodeTranspose,nodeGoodLinks,bestIndices);
}
void copyTripletMatrix(structTYPE tripletMatrixIn[middleLayers][numberOfNodes][adjacentNodes][adjacentNodes], structTYPE (& tripletMatrixOut)[middleLayers][numberOfNodes][adjacentNodes][adjacentNodes]) {
#pragma HLS INLINE OFF
	// Loop through only the middle layers because the uppermost and lowermost layers are not associated with triplets
cTMLayerLoop: for (indexTYPE middleLayer=0; middleLayer<middleLayers; middleLayer++) {
                	#pragma HLS UNROLL
cTMNodeLoop:	    for (indexTYPE nodeIndex=0; nodeIndex<numberOfNodes; nodeIndex++) {
	       				#pragma HLS UNROLL
cTMAboveNodeLoop: 		for (indexTYPE aboveNodeIndex=0; aboveNodeIndex<adjacentNodes; aboveNodeIndex++) {
							#pragma HLS UNROLL
cTMBelowNodeLoop:  			for (indexTYPE belowNodeIndex=0; belowNodeIndex<adjacentNodes; belowNodeIndex++) {
									#pragma HLS UNROLL
		 	 	 	 	 	 	 	tripletMatrixOut[middleLayer][nodeIndex][aboveNodeIndex][belowNodeIndex] = tripletMatrixIn[middleLayer][nodeIndex][aboveNodeIndex][belowNodeIndex];
							}
						}
        	     	} // end nodeLoop
              } // end layerLoop
}
void copyCoordinates(spacepointTYPE coordinatesIn[totalLayers][nWeightedCoordinates][numberOfNodes], spacepointTYPE (& coordinatesOut)[totalLayers][nWeightedCoordinates][numberOfNodes]) {
#pragma HLS INLINE OFF
cCLayerLoop: for (indexTYPE layer=0; layer<totalLayers; layer++) {
	         #pragma HLS UNROLL
cCweightLoop:		for (indexTYPE weightIndex=0; weightIndex<nWeightedCoordinates; weightIndex++) {
					#pragma HLS UNROLL
cCNodeLoop:	   			 for (indexTYPE nodeIndex=0; nodeIndex<numberOfNodes; nodeIndex++) {
						 #pragma HLS UNROLL
							coordinatesOut[layer][weightIndex][nodeIndex] = coordinatesIn[layer][weightIndex][nodeIndex];
						 } // end nodeLoop
                    } // end weightLoop
	         } // end layerLoop
}
template<std::size_t power>
void allNodeProcessors(bool allNodesGoodLinks[middleLayers][numberOfNodes][adjacentLayers][numberOfNodes],
                	   indexTYPE bestIndices[middleLayers][numberOfNodes][adjacentLayers][numberOfNodes],
					   structTYPE tripletMatrix[middleLayers][numberOfNodes][adjacentNodes][adjacentNodes]
					   ) {
#pragma HLS INLINE OFF
aNPlayerLoop: for (indexTYPE middleLayer=0; middleLayer<middleLayers; middleLayer++) {
	      	  #pragma HLS unroll
aNPnodeLoop:	  for (indexTYPE nodeIndex=0; nodeIndex<numberOfNodes; nodeIndex++) {
	    		  #pragma HLS UNROLL
						nodeProcessor<power>(allNodesGoodLinks[middleLayer][nodeIndex],bestIndices[middleLayer][nodeIndex],tripletMatrix[middleLayer][nodeIndex]);
			      } // end nodeLoop
              } // end layerLoop
	     consensusProtocol(allNodesGoodLinks);
}
template<std::size_t power, std::size_t powerLength>
void allNodeMSS(structTYPE laplacianMinimumsOfNode[middleLayers][numberOfNodes][numberOfDirections][powerLength],
				bool (& allNodesGoodLinks)[middleLayers][numberOfNodes][adjacentLayers][numberOfNodes],
                indexTYPE (& bestIndices)[middleLayers][numberOfNodes][adjacentLayers][numberOfNodes]
					   ) {
#pragma HLS INLINE OFF
aNMSSlayerLoop: for (indexTYPE middleLayer=0; middleLayer<middleLayers; middleLayer++) {
	      	  #pragma HLS unroll
aNMSSnodeLoop:	  for (indexTYPE nodeIndex=0; nodeIndex<numberOfNodes; nodeIndex++) {
	    		  #pragma HLS UNROLL
						nodeMSSEngine<power,powerLength>(laplacianMinimumsOfNode[middleLayer][nodeIndex],
								allNodesGoodLinks[middleLayer][nodeIndex],bestIndices[middleLayer][nodeIndex]);
			      } // end nodeLoop
              } // end layerLoop
	     consensusProtocol(allNodesGoodLinks);
}
template<std::size_t power, std::size_t localPowerLength>
void nodeMinFinder(bool nodeGoodLinks[adjacentLayers][numberOfNodes], indexTYPE bestIndices[adjacentLayers][numberOfNodes], structTYPE tM[adjacentNodes][adjacentNodes],
	structTYPE (& laplacianMinimumsOfNode)[numberOfDirections][localPowerLength]) {
	#pragma HLS INLINE OFF

    // MinFinder and MSS modify the array passed in. To create tripletMatrixPruned in the power loop, we must maintain the index correspondence between tripletMatrix and allNodesGoodLinks. Therefore, MinFinder
	// and MSS must modify copies of tripletMatrix rather than tripletMatrix itself
	structTYPE tripletMatrixPruned[localPowerLength][localPowerLength];
    #pragma HLS ARRAY_PARTITION variable=tripletMatrixPruned complete dim=0

        if (power != highestPower) {
						buildPrunedMatrices<localPowerLength>(nodeGoodLinks,bestIndices,tM,tripletMatrixPruned);
        } else {
nMFlaplacianAboveNodeCopy: 	for (indexTYPE aboveNodeIndex=0; aboveNodeIndex<adjacentNodes; aboveNodeIndex++) {
								#pragma HLS UNROLL
nMFlaplacianBelowNodeCopy:  		for (indexTYPE belowNodeIndex=0; belowNodeIndex<adjacentNodes; belowNodeIndex++) {
									#pragma HLS UNROLL
	 	 	 	 	 	 	 	 	tripletMatrixPruned[aboveNodeIndex][belowNodeIndex] = tM[aboveNodeIndex][belowNodeIndex];
								}
							}
	   }
	   nodeMinFinderEngine<power,localPowerLength>(tripletMatrixPruned,laplacianMinimumsOfNode);
}
template<std::size_t power, std::size_t powerLength>
void allNodeMinFindersV2(bool allNodesGoodLinks[middleLayers][numberOfNodes][adjacentLayers][numberOfNodes],
                	   indexTYPE bestIndices[middleLayers][numberOfNodes][adjacentLayers][numberOfNodes],
					   structTYPE tripletMatrix[middleLayers][numberOfNodes][adjacentNodes][adjacentNodes],
					   structTYPE (& tripletMatrixCopy)[middleLayers][numberOfNodes][adjacentNodes][adjacentNodes],
					   structTYPE (& laplacianMinimumsOfNode)[middleLayers][numberOfNodes][numberOfDirections][powerLength]) {
#pragma HLS INLINE OFF

aNMF2layerLoop: for (indexTYPE middleLayer=0; middleLayer<middleLayers; middleLayer++) {
	      	  #pragma HLS unroll
aNMF2nodeLoop:	  for (indexTYPE nodeIndex=0; nodeIndex<numberOfNodes; nodeIndex++) {
	    		  #pragma HLS UNROLL
						nodeMinFinder<power,powerLength>(allNodesGoodLinks[middleLayer][nodeIndex],bestIndices[middleLayer][nodeIndex],tripletMatrix[middleLayer][nodeIndex],
								laplacianMinimumsOfNode[middleLayer][nodeIndex]);
			      } // end nodeLoop
              } // end layerLoop
	          if (power > 1) copyTripletMatrix(tripletMatrix,tripletMatrixCopy);
	          return;
}
template<std::size_t power, std::size_t powerLength>
void allNodeMinFinders(structTYPE tripletMatrixPruned[middleLayers][numberOfNodes][powerLength][powerLength],
					   structTYPE (& laplacianMinimumsOfNode)[middleLayers][numberOfNodes][powerLength],
					   structTYPE (& laplacianMinimumsOfNodeTranspose)[middleLayers][numberOfNodes][powerLength]) {
#pragma HLS INLINE OFF
	structTYPE tripletMatrixLocal[middleLayers][numberOfNodes][adjacentNodes][adjacentNodes];
 	#pragma HLS ARRAY_PARTITION variable=tripletMatrixLocal dim=0 complete

aNMFlayerLoop: for (indexTYPE middleLayer=0; middleLayer<middleLayers; middleLayer++) {
	      	  #pragma HLS unroll
aNMFnodeLoop:	  for (indexTYPE nodeIndex=0; nodeIndex<numberOfNodes; nodeIndex++) {
	    		  #pragma HLS UNROLL

	                 if (power == highestPower) {
TMPHPAboveNodeCopy: 	for (indexTYPE aboveNodeIndex=0; aboveNodeIndex<adjacentNodes; aboveNodeIndex++) {
					        #pragma HLS UNROLL
TMPHPlowNodeCopy:  		   for (indexTYPE belowNodeIndex=0; belowNodeIndex<adjacentNodes; belowNodeIndex++) {
						       #pragma HLS UNROLL
		 	 	 	 			   tripletMatrixLocal[middleLayer][nodeIndex][aboveNodeIndex][belowNodeIndex] = tripletMatrixPruned[middleLayer][nodeIndex][aboveNodeIndex][belowNodeIndex];
						   }
					    }
						nodeMinFinderEngine<power,powerLength>(tripletMatrixLocal[middleLayer][nodeIndex],
								laplacianMinimumsOfNode[middleLayer][nodeIndex],
								laplacianMinimumsOfNodeTranspose[middleLayer][nodeIndex]);
	                 } else {
	                	nodeMinFinderEngine<power,powerLength>(tripletMatrixPruned[middleLayer][nodeIndex],
                    			laplacianMinimumsOfNode[middleLayer][nodeIndex],
								laplacianMinimumsOfNodeTranspose[middleLayer][nodeIndex]);
	                 }
			      } // end nodeLoop
              } // end layerLoop
}
#if totalLayers == defaultLayersQC
void findAllTracks(bool allNodesGoodLinks[middleLayers][numberOfNodes][adjacentLayers][numberOfNodes],
                	   indexTYPE bestIndices[middleLayers][numberOfNodes][adjacentLayers][numberOfNodes],
      			       indexTYPE track[numberOfNodes][totalLayers], bool trackCandidate[numberOfNodes]) {
#pragma HLS INLINE OFF

fATnodeLoop:	  for (indexTYPE nodeIndex=0; nodeIndex<numberOfNodes; nodeIndex++) {
	    		  #pragma HLS UNROLL
						track[nodeIndex][3] = bestIndices[anchorLayer][nodeIndex][aboveLayerIndex][0];
						track[nodeIndex][1] = bestIndices[anchorLayer][nodeIndex][belowLayerIndex][0];
						track[nodeIndex][2] = nodeIndex;
						track[nodeIndex][4] = bestIndices[anchorLayer+1][track[nodeIndex][3]][aboveLayerIndex][0];
						track[nodeIndex][0] = bestIndices[anchorLayer-1][track[nodeIndex][1]][belowLayerIndex][0];

						trackCandidate[nodeIndex] = (allNodesGoodLinks[anchorLayer][nodeIndex][aboveLayerIndex][track[nodeIndex][3]] &&
													 allNodesGoodLinks[anchorLayer][nodeIndex][belowLayerIndex][track[nodeIndex][1]] &&
							                         allNodesGoodLinks[anchorLayer+1][track[nodeIndex][3]][aboveLayerIndex][track[nodeIndex][4]] &&
													 allNodesGoodLinks[anchorLayer-1][track[nodeIndex][1]][belowLayerIndex][track[nodeIndex][0]]);
			      } // end nodeLoop
}
void makeTrackCrookedness(laplacianTYPE localCoord[totalLayers][nWeightedCoordinates][nPixelDimensions], laplacianTYPE crookedness[nMetrics+1][nPixelDimensions]) {
#pragma HLS INLINE OFF
    laplacianTYPE oneTrackMetric[nMetrics][nPixelDimensions][middleLayers+1];
	#pragma HLS ARRAY_PARTITION variable=oneTrackMetric dim=0 complete

mTCdimLoop:	for (indexTYPE dir=0; dir<nPixelDimensions; dir++) {
			#pragma HLS UNROLL
				// following four are laplacians
				  oneTrackMetric[0][dir][anchorLayer+2] = 0;
mTClaplacianLoop: for (indexTYPE ml=0; ml<middleLayers; ml++) {
     			  #pragma HLS UNROLL
					oneTrackMetric[0][dir][ml] = localCoord[ml+2][2][dir] + localCoord[ml][0][dir] + localCoord[ml+1][1][dir];
			      }
				  fullSort<2,4>(oneTrackMetric[0][dir]);
       			  crookedness[0][dir] = oneTrackMetric[0][dir][middleLayers] - oneTrackMetric[0][dir][0]; // this is positive by construction of MSS

       			// following four are slopes
mTCslopeLoop:   for (indexTYPE ml=0; ml<middleLayers+1; ml++) {
       	        #pragma HLS UNROLL
       		     	oneTrackMetric[1][dir][ml] = localCoord[ml+1][3][dir] + localCoord[ml][4][dir];
       		    }
       			fullSort<2,4>(oneTrackMetric[1][dir]);
       			crookedness[1][dir] = oneTrackMetric[1][dir][middleLayers] - oneTrackMetric[1][dir][0]; // this is positive by construction of MSS
       			// following two store the median of slopes, serving as measurements of phiPrime = pT and zPrime = cotTheta
       			crookedness[2][dir] = oneTrackMetric[1][dir][1] + oneTrackMetric[1][dir][2]; // median is the average of the two central value, we do not divide by 2 to save on hardware, since both measurements have scale factors anyway
            }
}
void makeLocalCoord(laplacianTYPE decodedCoordinates[totalLayers][nWeightedCoordinates][numberOfNodes][nPixelDimensions],
		indexTYPE track[numberOfNodes][totalLayers],
		laplacianTYPE (& localCoord)[numberOfNodes][totalLayers][nWeightedCoordinates][nPixelDimensions]){
#pragma HLS INLINE OFF
fBTnodeLoop1:	  for (indexTYPE nodeIndex=0; nodeIndex<numberOfNodes; nodeIndex++) { // extract coordinates indexed by node in anchorLayer
	    		  #pragma HLS UNROLL
getWeightedCoordLayerLoop:	for (indexTYPE layer=0; layer<totalLayers; layer++) {
	                        #pragma HLS UNROLL
getWeightedCoordLoop:			 for (indexTYPE weightIndex=0; weightIndex<nWeightedCoordinates; weightIndex++) {
								 #pragma HLS UNROLL
										localCoord[nodeIndex][layer][weightIndex][0] = decodedCoordinates[layer][weightIndex][track[nodeIndex][layer]][0];
										localCoord[nodeIndex][layer][weightIndex][1] = decodedCoordinates[layer][weightIndex][track[nodeIndex][layer]][1];
								 }
							}
			      } // end nodeLoop1
}
indexTYPE findBestTrack(indexTYPE track[numberOfNodes][totalLayers], bool trackCandidate[numberOfNodes],
            	   spacepointTYPE coordinates[totalLayers][nWeightedCoordinates][numberOfNodes], laplacianTYPE trackParameters[nMetrics+1][nPixelDimensions]){
#pragma HLS INLINE OFF
        structTYPE trackCrookedness[nMetrics][nPixelDimensions][numberOfNodes];
		#pragma HLS ARRAY_PARTITION variable=trackCrookedness dim=0 complete
        laplacianTYPE crookedness[numberOfNodes][nMetrics+1][nPixelDimensions];
		#pragma HLS ARRAY_PARTITION variable=crookedness dim=1 complete
		#pragma HLS ARRAY_RESHAPE variable=crookedness dim=2 complete
		#pragma HLS ARRAY_RESHAPE variable=crookedness dim=3 complete
        laplacianTYPE localCoord[numberOfNodes][totalLayers][nWeightedCoordinates][nPixelDimensions];
    	#pragma HLS ARRAY_PARTITION variable=localCoord dim=1 complete
		#pragma HLS ARRAY_RESHAPE variable=localCoord dim=2 complete
		#pragma HLS ARRAY_RESHAPE variable=localCoord dim=3 complete
		#pragma HLS ARRAY_RESHAPE variable=localCoord dim=4 complete
        laplacianTYPE decodedCoordinates[totalLayers][nWeightedCoordinates][numberOfNodes][nPixelDimensions];
    	#pragma HLS ARRAY_PARTITION variable=decodedCoordinates dim=1 complete
        #pragma HLS ARRAY_RESHAPE variable=decodedCoordinates dim=2 complete
		#pragma HLS ARRAY_PARTITION variable=decodedCoordinates dim=3 complete
		#pragma HLS ARRAY_RESHAPE variable=decodedCoordinates dim=4 complete

        decodeCoordinates<nWeightedCoordinates>(coordinates, decodedCoordinates);
        makeLocalCoord(decodedCoordinates, track, localCoord);

fBTnodeLoop2:	  for (indexTYPE nodeIndex=0; nodeIndex<numberOfNodes; nodeIndex++) { // compute crookedness for all tracks, one per node
	    		  #pragma HLS UNROLL
						makeTrackCrookedness(localCoord[nodeIndex],crookedness[nodeIndex]);
			      } // end nodeLoop2

fBTnodeLoop3:	  for (indexTYPE nodeIndex=0; nodeIndex<numberOfNodes; nodeIndex++) {
	    		  #pragma HLS UNROLL
                        if (!trackCandidate[nodeIndex]) { // remove non-existent tracks
                        	crookedness[nodeIndex][0][0] = killLaplacianValue;
                        	crookedness[nodeIndex][0][1] = killLaplacianValue;
                        	crookedness[nodeIndex][1][0] = killLaplacianValue;
                        	crookedness[nodeIndex][1][1] = killLaplacianValue;
                        }
			      } // end nodeLoop3

fBTnodeLoop4:	  for (indexTYPE nodeIndex=0; nodeIndex<numberOfNodes; nodeIndex++) { // save crookedness for all tracks, existent and non-existent
	    		  #pragma HLS UNROLL
                   	trackCrookedness[0][0][nodeIndex] = tripletEncode(0,nodeIndex,crookedness[nodeIndex][0][0]);
                   	trackCrookedness[0][1][nodeIndex] = tripletEncode(0,nodeIndex,crookedness[nodeIndex][0][1]);
                   	trackCrookedness[1][0][nodeIndex] = tripletEncode(0,nodeIndex,crookedness[nodeIndex][1][0]);
                   	trackCrookedness[1][1][nodeIndex] = tripletEncode(0,nodeIndex,crookedness[nodeIndex][1][1]);
			      } // end nodeLoop4

				  MinFinder<4>(trackCrookedness[0][0]); // find best track in phi dimension for laplacian metric
				  MinFinder<4>(trackCrookedness[0][1]); // find best track in z dimension for laplacian metric
				  MinFinder<4>(trackCrookedness[1][0]); // find best track in phi dimension for slope metric
				  MinFinder<4>(trackCrookedness[1][1]); // find best track in z dimension for slope metric
				  indexTYPE bestTrackXLaplacian = decodeBelowNodeIndex(trackCrookedness[0][0][0]);
				  indexTYPE bestTrackYLaplacian = decodeBelowNodeIndex(trackCrookedness[0][1][0]);
				  indexTYPE bestTrackXSlope = decodeBelowNodeIndex(trackCrookedness[1][0][0]);
				  indexTYPE bestTrackYSlope = decodeBelowNodeIndex(trackCrookedness[1][1][0]);
				  indexTYPE bestTrack = fakeIndex;
				  if (bestTrackXLaplacian == bestTrackYLaplacian && bestTrackXSlope == bestTrackYSlope && bestTrackXLaplacian == bestTrackXSlope) bestTrack = bestTrackYLaplacian; // best track is coincidence of both dimensions

fBTnodeLoop5:	  for (indexTYPE metric=0; metric<=nMetrics; metric++) { // save crookedness metrics and parameter value for each dimension
	    		  #pragma HLS UNROLL
						trackParameters[metric][0] = crookedness[bestTrack][metric][0]; // save phiPrime = curvature and its crookedness metrics
						trackParameters[metric][1] = crookedness[bestTrack][metric][1]; // save zPrime = cotTheta and its crookedness metrics
						if (bestTrack == fakeIndex) {
							trackParameters[metric][0] = badMetric; // default to bad for no best track
							trackParameters[metric][1] = badMetric; // default to bad for no best track
						}
				  }

return (indexTYPE) bestTrack;
}
void removeGhostTracks(indexTYPE bestTrack, indexTYPE track[numberOfNodes][totalLayers], bool allNodesGoodLinks[middleLayers][numberOfNodes][adjacentLayers][numberOfNodes]){
#pragma HLS INLINE OFF
//        structTYPE trackCrookedness[nPixelDimensions][numberOfNodes];
//		#pragma HLS ARRAY_PARTITION variable=trackCrookedness dim=0 complete
//        laplacianTYPE crookedness[numberOfNodes][nPixelDimensions];
//		#pragma HLS ARRAY_PARTITION variable=crookedness dim=0 complete

rGTnodeClean:	  for (indexTYPE nodeIndex=0; nodeIndex<numberOfNodes; nodeIndex++) { // remove all tracks at anchorLayer
				  #pragma HLS UNROLL
	 				  allNodesGoodLinks[anchorLayer][nodeIndex][aboveLayerIndex][track[nodeIndex][3]] = rejectLink;
   					  allNodesGoodLinks[anchorLayer][nodeIndex][belowLayerIndex][track[nodeIndex][1]] = rejectLink;
				  }
				  allNodesGoodLinks[anchorLayer][bestTrack][aboveLayerIndex][track[bestTrack][3]] = acceptLink; // recover best track at anchorLayer
				  allNodesGoodLinks[anchorLayer][bestTrack][belowLayerIndex][track[bestTrack][1]] = acceptLink;
				  consensusProtocol(allNodesGoodLinks); // remove all links of rejected tracks
}
#endif
/*
	fullSystem: Determines the most likely paths taken by particle fragments resulting from a collision in the Large Hadron Collider
	@param nodeCoordinates A totalLayers x numberOfNodes Matrix that contains the physical coordinate points for each hit. Each coordinate has 5 weighted copies to account for the distances between layers (3 copies for second derivative and 2 for first derivative)
	@param ans Necessary for Vivado synthesis
*/
//TODO: Move the testing part (generateCoordinates and *maybe also* main) into the test bench
void fullSystem(spacepointTYPE coordinates[totalLayers][nWeightedCoordinates][numberOfNodes], bool * fullSystemReturnCode) {
	#pragma HLS DATAFLOW
	#pragma HLS ARRAY_PARTITION variable=coordinates complete dim=0

	// tripletMatrix contains the set of all possible triplets per node
	structTYPE tripletMatrix[eventPipelineStages][middleLayers][numberOfNodes][adjacentNodes][adjacentNodes];
	#pragma HLS ARRAY_PARTITION variable=tripletMatrix dim=1 complete
	#pragma HLS ARRAY_PARTITION variable=tripletMatrix dim=2 complete
	#pragma HLS ARRAY_PARTITION variable=tripletMatrix dim=3 complete
	#pragma HLS ARRAY_RESHAPE variable=tripletMatrix dim=4 complete
	#pragma HLS ARRAY_RESHAPE variable=tripletMatrix dim=5 complete
	// allNodesGoodLinks is the global data structure that encodes the "accepted links" (most likely path taken by particle fragment between hits). Initialize allNodeGoodLinks so all links are reject links
	bool allNodesGoodLinks[highestPower][middleLayers][numberOfNodes][adjacentLayers][numberOfNodes];
	#pragma HLS ARRAY_PARTITION variable=allNodesGoodLinks complete dim=0
    // we save the best indices for each node's links up and down, coming out of nodeMSSEngine
    indexTYPE bestIndices[highestPower][middleLayers][numberOfNodes][adjacentLayers][numberOfNodes];
	#pragma HLS ARRAY_PARTITION variable=bestIndices complete dim=0
    // track contains linked lists of all tracks at anchorLayer
    indexTYPE track[numberOfNodes][totalLayers];
    #pragma HLS ARRAY_PARTITION variable=track dim=1 complete
	#pragma HLS ARRAY_RESHAPE variable=track dim=2 complete
    // trackCandidate tells which track has complete linked list
    bool trackCandidate[numberOfNodes];
    #pragma HLS ARRAY_PARTITION variable=trackCandidate dim=0 complete
    laplacianTYPE trackParameters[nMetrics+1][nPixelDimensions]; // contain best track's curvature and cotTheta, and the corresponding crookedness metrics
	#pragma HLS ARRAY_PARTITION variable=trackParameters dim=0 complete
    spacepointTYPE coordinatesPipeline[eventPipelineStages+1][totalLayers][nWeightedCoordinates][numberOfNodes];
	#pragma HLS ARRAY_PARTITION variable=coordinatesPipeline dim=1 complete
	#pragma HLS ARRAY_PARTITION variable=coordinatesPipeline dim=2 complete
	#pragma HLS ARRAY_RESHAPE variable=coordinatesPipeline dim=3 complete
	#pragma HLS ARRAY_RESHAPE variable=coordinatesPipeline dim=4 complete

#if combinedNodeProcessor == false
    const std::size_t highestPowerLength = 1<<highestPower;
    const std::size_t NHPowerLength = 1<<(highestPower-1);
    const std::size_t NNHPowerLength = 1<<(highestPower-2);
    const std::size_t NNNHPowerLength = 1<<(highestPower-3);

    structTYPE laplacianMinimumsOfNodeHP[middleLayers][numberOfNodes][numberOfDirections][highestPowerLength];
    #pragma HLS ARRAY_PARTITION variable=laplacianMinimumsOfNodeHP complete dim=1
	#pragma HLS ARRAY_PARTITION variable=laplacianMinimumsOfNodeHP complete dim=2
	#pragma HLS ARRAY_PARTITION variable=laplacianMinimumsOfNodeHP complete dim=3
	#pragma HLS ARRAY_PARTITION variable=laplacianMinimumsOfNodeHP complete dim=4
    structTYPE laplacianMinimumsOfNodeNHP[middleLayers][numberOfNodes][numberOfDirections][NHPowerLength];
	#pragma HLS ARRAY_PARTITION variable=laplacianMinimumsOfNodeNHP complete dim=1
	#pragma HLS ARRAY_PARTITION variable=laplacianMinimumsOfNodeNHP complete dim=2
	#pragma HLS ARRAY_PARTITION variable=laplacianMinimumsOfNodeNHP complete dim=3
	#pragma HLS ARRAY_PARTITION variable=laplacianMinimumsOfNodeNHP complete dim=4
    structTYPE laplacianMinimumsOfNodeNNHP[middleLayers][numberOfNodes][numberOfDirections][NNHPowerLength];
	#pragma HLS ARRAY_PARTITION variable=laplacianMinimumsOfNodeNNHP complete dim=1
	#pragma HLS ARRAY_PARTITION variable=laplacianMinimumsOfNodeNNHP complete dim=2
	#pragma HLS ARRAY_PARTITION variable=laplacianMinimumsOfNodeNNHP complete dim=3
	#pragma HLS ARRAY_PARTITION variable=laplacianMinimumsOfNodeNNHP complete dim=4
    structTYPE laplacianMinimumsOfNodeNNNHP[middleLayers][numberOfNodes][numberOfDirections][NNNHPowerLength];
	#pragma HLS ARRAY_PARTITION variable=laplacianMinimumsOfNodeNNNHP complete dim=1
	#pragma HLS ARRAY_PARTITION variable=laplacianMinimumsOfNodeNNNHP complete dim=2
	#pragma HLS ARRAY_PARTITION variable=laplacianMinimumsOfNodeNNNHP complete dim=3
	#pragma HLS ARRAY_PARTITION variable=laplacianMinimumsOfNodeNNNHP complete dim=4
#endif

    laplacianCalculator(coordinates, tripletMatrix[0]);

//  //  allNodeProcessors<highestPower>(allNodesGoodLinks[0], bestIndices[0], tripletMatrix[0]);

#if combinedNodeProcessor == false

// //   allNodeMinFinders<highestPower,highestPowerLength>(tripletMatrix[0], laplacianMinimumsOfNodeHP, laplacianMinimumsOfNodeTransposeHP);

	copyCoordinates(coordinates,coordinatesPipeline[0]);
	allNodeMinFindersV2<highestPower,highestPowerLength>(allNodesGoodLinks[0], bestIndices[0], tripletMatrix[0], tripletMatrix[1], laplacianMinimumsOfNodeHP);

	copyCoordinates(coordinatesPipeline[0],coordinatesPipeline[1]);
	allNodeMSS<highestPower,highestPowerLength>(laplacianMinimumsOfNodeHP, allNodesGoodLinks[0], bestIndices[0]);
    copyTripletMatrix(tripletMatrix[1],tripletMatrix[2]);

	copyCoordinates(coordinatesPipeline[1],coordinatesPipeline[2]);
	allNodeMinFindersV2<highestPower-1,NHPowerLength>(allNodesGoodLinks[0], bestIndices[0], tripletMatrix[2], tripletMatrix[3], laplacianMinimumsOfNodeNHP);

	copyCoordinates(coordinatesPipeline[2],coordinatesPipeline[3]);
	allNodeMSS<highestPower-1,NHPowerLength>(laplacianMinimumsOfNodeNHP, allNodesGoodLinks[1], bestIndices[1]);
    copyTripletMatrix(tripletMatrix[3],tripletMatrix[4]);

	copyCoordinates(coordinatesPipeline[3],coordinatesPipeline[4]);
	allNodeMinFindersV2<highestPower-2,NNHPowerLength>(allNodesGoodLinks[1], bestIndices[1], tripletMatrix[4], tripletMatrix[5], laplacianMinimumsOfNodeNNHP);

	copyCoordinates(coordinatesPipeline[4],coordinatesPipeline[5]);
	allNodeMSS<highestPower-2,NNHPowerLength>(laplacianMinimumsOfNodeNNHP, allNodesGoodLinks[2], bestIndices[2]);
    copyTripletMatrix(tripletMatrix[5],tripletMatrix[6]);

	copyCoordinates(coordinatesPipeline[5],coordinatesPipeline[6]);
	allNodeMinFindersV2<highestPower-3,NNNHPowerLength>(allNodesGoodLinks[2], bestIndices[2], tripletMatrix[6], tripletMatrix[0], laplacianMinimumsOfNodeNNNHP);

	copyCoordinates(coordinatesPipeline[6],coordinatesPipeline[7]);
	allNodeMSS<highestPower-3,NNNHPowerLength>(laplacianMinimumsOfNodeNNNHP, allNodesGoodLinks[3], bestIndices[3]);

#if totalLayers == defaultLayersQC
	findAllTracks(allNodesGoodLinks[3],bestIndices[3],track,trackCandidate);
	indexTYPE bestTrack = findBestTrack(track, trackCandidate, coordinatesPipeline[7], trackParameters);
	removeGhostTracks(bestTrack,track,allNodesGoodLinks[3]);
#endif

#elif combinedNodeProcessor == true
	allNodeProcessors<highestPower>(allNodesGoodLinks[0], bestIndices[0], tripletMatrix[0]);
	allNodeProcessors<highestPower-1>(allNodesGoodLinks[0], bestIndices[0], tripletMatrix[0]);
    allNodeProcessors<highestPower-2>(allNodesGoodLinks[0], bestIndices[0], tripletMatrix[0]);
    allNodeProcessors<highestPower-3>(allNodesGoodLinks[0], bestIndices[0], tripletMatrix[0]);
#endif

	// Print final allNodesGoodLinks matrix
//    cout << "{" << "\n";
//	for(indexTYPE layer=0; layer<middleLayers; layer++) {
//        cout << "layer" << layer+1 << " {" << "\n";
//		for(indexTYPE nodeIndex=0; nodeIndex<numberOfNodes; nodeIndex++) {
//            cout << "node" << nodeIndex+1 << " {";
//			for(indexTYPE correspondingNodeIndex=0; correspondingNodeIndex<numberOfNodes; correspondingNodeIndex++) {
//				indexTYPE aboveLayerIndex = 0;
//				indexTYPE belowLayerIndex = 1;
//                cout << allNodesGoodLinks[layer][nodeIndex][aboveLayerIndex][correspondingNodeIndex] << allNodesGoodLinks[layer][nodeIndex][belowLayerIndex][correspondingNodeIndex] << " ";
//			}
//            cout << "}" << "\n";
//		}
//        cout << "}" << "\n";
//	}
//    cout << "}" << "\n";

	// Variable input ensures synthesis is performed for all nodes
	*fullSystemReturnCode = allNodesGoodLinks[highestPower-1][middleLayers-1][numberOfNodes-1][adjacentLayers-1][numberOfNodes-1] && (trackParameters[nMetrics][0]>1 && trackParameters[nMetrics][1]>1);
//	*fullSystemReturnCode = allNodesGoodLinks[middleLayers-1][numberOfNodes-1][adjacentLayers-1][numberOfNodes-1];

	return;
}

int main() {
	/*
    int layerRadii[totalLayers] = {5, 10, 15, 20, 25}; // in centimeters
    int fragmentsPerCollision = 16; 
    int numberOfCollisionsPerTime = 1;
    double pixelWidth = 0.0025; // in cm
    int numberOfSections = 1;
	int outcome = 1;
    int curveRadius = (100/6)*10000;
    */
#pragma HLS DATAFLOW
    bool * fullSystemReturnCode;
#if numberOfNodes == 4
    laplacianTYPE coordinates[totalLayers][numberOfNodes] =
    		{1, 19, 27, 34,
    		 3, 13, 23, 33,
			 7, 17, 37, 47,
			 3, 13, 23, 33,
			 7, 17, 37, 47};
#elif numberOfNodes == 8
    laplacianTYPE coordinates[totalLayers][numberOfNodes] =
			{1, 19, 27, 34, 99, 120, 140, 160,
			3, 13, 17, 45, 54, 63, 73, 83,
			29, 39, 49, 59, 89, 99, 109, 119,
			19, 29, 39, 49, 59, 89, 99, 109,
			4, 14, 24, 44, 54, 119, 129, 199};
#elif numberOfNodes == 16
    laplacianTYPE coordinates[totalLayers][numberOfNodes] = {
	  		1, 19, 27, 34, 99, 120, 140, 160, 202, 220, 228, 235, 300, 321, 341, 361,
			3, 13, 17, 45, 54, 63, 73, 83, 13, 113, 117, 145, 154, 163, 173, 183,
			29, 39, 49, 59, 89, 99, 109, 119, 129, 139, 149, 159, 189, 199, 209, 219
			,19, 29, 39, 49, 59, 89, 99, 109, 119, 129, 139, 149, 159, 189, 199, 309
			,4, 14, 24, 44, 54, 119, 129, 199, 204, 214, 224, 244, 254, 319, 329, 399
#if totalLayers >= 6
	  		,1, 19, 27, 34, 99, 120, 140, 160, 202, 220, 228, 235, 300, 321, 341, 361
#endif
	};
#else
    laplacianTYPE coordinates[totalLayers][numberOfNodes] = {0};
#endif
    spacepointTYPE weightedCoordinates[totalLayers][nWeightedCoordinates][numberOfNodes];
    laplacianTYPE xCoordinate, yCoordinate;

	// copy coordinates into weighted arrays. This part of code is for testing, presumably not synthesized
makeWeightedCoordLayerLoop:	for (indexTYPE layer=0; layer<totalLayers; layer++) {
makeWeightedCoordWeightLoop:		for (indexTYPE weightIndex=0; weightIndex<nWeightedCoordinates; weightIndex++) {
makeWeightedCoordNodeLoop:			for (indexTYPE nodeIndex=0; nodeIndex<numberOfNodes; nodeIndex++) {
				yCoordinate = coordinates[layer][nodeIndex];
				if (weightIndex == 1) {
					yCoordinate += coordinates[layer][nodeIndex]; // double it because central node is subtracted twice in Laplacian calculation
					yCoordinate = -yCoordinate; // negate it so we can use adder later
				}
				if (weightIndex == 4) {
					yCoordinate = -yCoordinate; // negate it so we can use adder later in the slope calculation
				}
				xCoordinate = yCoordinate;
				xCoordinate += yCoordinate;
				weightedCoordinates[layer][weightIndex][nodeIndex] = ( ( (spacepointTYPE) xCoordinate )<<16) | ( ( (spacepointTYPE) yCoordinate) & 0x0000FFFF );
//				weightedCoordinates[layer][weightIndex][nodeIndex][0] = xCoordinate;				weightedCoordinates[layer][weightIndex][nodeIndex][1] = yCoordinate;
			} // end nodeLoop
		} // end weightLoop
	} // end layerLoop

    // generateCoordinates(layerRadii, fragmentsPerCollision, numberOfCollisionsPerTime, pixelWidth, numberOfSections, outcome, curveRadius,coordinates);
	fullSystem(weightedCoordinates,fullSystemReturnCode);

//	ofstream MMFile;
//	MMFile.open ("MM.txt");
//    for (indexTYPE layer = 0; layer < totalLayers; layer++) {
//        MMFile << "{";
//        for (indexTYPE hit = 0; hit < numberOfNodes; hit++) {
//			if (hit != numberOfNodes - 1) {
//				MMFile << coordinates[layer][hit] << ", ";
//			} else {
//				MMFile << coordinates[layer][hit];
//			}
//
//        }
//        MMFile << "} \n";
//    }
//    MMFile << "\n";
//
//	MMFile << "MM" << "\n";
//    MMFile << "{" << "\n";
//	for(indexTYPE layer=0; layer<middleLayers; layer++) {
//        MMFile << "layer" << layer+1 << " {" << "\n";
//		for(indexTYPE nodeIndex=0; nodeIndex<numberOfNodes; nodeIndex++) {
//            MMFile << "node" << nodeIndex+1 << " {";
//			for(indexTYPE correspondingNodeIndex=0; correspondingNodeIndex<numberOfNodes; correspondingNodeIndex++) {
//				indexTYPE aboveLayerIndex = 0;
//				indexTYPE belowLayerIndex = 1;
//                MMFile << allNodesGoodLinks[layer][nodeIndex][aboveLayerIndex][correspondingNodeIndex] << allNodesGoodLinks[layer][nodeIndex][belowLayerIndex][correspondingNodeIndex] << " ";
//			}
//            MMFile << "}" << "\n";
//		}
//        MMFile << "}" << "\n";
//	}
//    MMFile << "}" << "\n" << "\n";
//	MMFile.close();
    return 0;
}
