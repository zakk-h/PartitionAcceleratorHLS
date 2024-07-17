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
#include "hls_streamofblocks.h"
// #include hls_stream.h
// #include hls_vector.h

// Namespaces
using namespace std;

// Import math keywords
#define _USE_MATH_DEFINES

// Global Constants
#define totalLayers 5 // Each layer corresponds to the set of hits detected by a single sensor
#define middleLayers 3
#define adjacentLayers 2 // Each middle layer has 2 adjacent layers
#define numberOfNodes 16 // Each node corresponds to a "hit" picked up by a sensor; we assume that each layer has 16 hits for the sake of this project
#define adjacentNodes 16 // Each middle layer node has 16 adjacent nodes above and below
#define highestPower 4 // log_2(numberOfNodes)
#define coordinateParticle1 2
#define coordinateParticle2 3
#define acceptLink true 
#define rejectLink false
#define tripletBitWidth 20  // Each triplet corresponds to an "i" value (position of node in the above adjacent layer), 
							// a "j" value (position of node in the below adjacent layer), and am "l" value (the discrete 
							// Laplacian corresponding to this node, the i value, and the j value)
#define nodeIndexBitWidth 4 // log_2(numberOfNodes)
#define upLink 0
#define downLink 1
#define aboveLayerIndex 0
#define belowLayerIndex 1
#define killLaplacianValue -1
#define indexTYPE uint8_t  // data type for array indices
#define structTYPE ap_int<24> // data type for coded structure, laplacian + upLink + downLink
//#define structTYPE int
#define laplacianTYPE int // data type for laplacian and node (hit) coordinates
#define nWeightedCoordinates 5 // each coordinate has 3 weighted versions for laplacian calculation and 2 for slope calculation
#define eventPipelineStages 1 // number of events in pipeline

#define combinedNodeProcessor false
#define inlineModules true
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
// TODO 2D nodeCoordinates, nBits for Laplacian, pipelined MinFinder, pipelined laplacianCalculator (to reduce DSP by factor of 10)
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
    return  (indexTYPE) triplet&15;
}
/*
	Returns the belowNodeIndex value given the bit encoded triplet
	@param triplet An integer that stores the aboveNodeIndex, belowNodeIndex, and Laplacian value corresponding to a middleLayer node
*/
indexTYPE decodeBelowNodeIndex(structTYPE triplet){
    #pragma HLS INLINE
    return  (indexTYPE) ((triplet & 240)>>4);
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
void makeHalfLaplacian(laplacianTYPE nodeList[adjacentNodes], laplacianTYPE inputNode, laplacianTYPE (& halfLaplacian)[adjacentNodes]){
#pragma HLS INLINE OFF

makeHalfLaplacianLoop: for (indexTYPE nodeIndex=0; nodeIndex<adjacentNodes; nodeIndex++) {
	         	       #pragma HLS UNROLL
	                       halfLaplacian[nodeIndex] = nodeList[nodeIndex] + inputNode;
					   }
return;
}
void makeAdder(laplacianTYPE thisNode, laplacianTYPE inputNode, laplacianTYPE (& halfLaplacian)){
#pragma HLS INLINE OFF
	 halfLaplacian = thisNode + inputNode;
return;
}
void makeAbs(laplacianTYPE laplacian[adjacentNodes],  laplacianTYPE (& absLaplacian) [adjacentNodes]) {
#pragma HLS INLINE
makeAbsLoop: for (indexTYPE nodeIndex=0; nodeIndex<adjacentNodes; nodeIndex++) {
			 #pragma HLS UNROLL
            	absLaplacian[nodeIndex] = std::abs(laplacian[nodeIndex]);
//    if (laplacian[nodeIndex] < 0) absLaplacian[nodeIndex] = -laplacian[nodeIndex]; else absLaplacian[nodeIndex] = laplacian[nodeIndex];
             }
return;
}
void singleNodeLaplacianCalculator(laplacianTYPE aboveNodeList[adjacentNodes], laplacianTYPE belowNodeList[adjacentNodes], structTYPE (&nodeTriplets)[adjacentNodes][adjacentNodes], laplacianTYPE inputNode) {
	#pragma HLS INLINE OFF
	laplacianTYPE halfLaplacian[adjacentNodes];
    #pragma HLS array_partition variable=halfLaplacian complete dim=0
	laplacianTYPE laplacian[adjacentNodes];
    #pragma HLS array_partition variable=laplacian complete dim=0
	laplacianTYPE absLaplacian[adjacentNodes][adjacentNodes];
    #pragma HLS array_partition variable=absLaplacian complete dim=0

//    makeHalfLaplacian(aboveNodeList, inputNode, halfLaplacian);
SNLCaboveNodeLoop: for (indexTYPE aboveNodeIndex=0; aboveNodeIndex<adjacentNodes; aboveNodeIndex++) {
				   #pragma HLS PIPELINE
					  makeAdder(aboveNodeList[aboveNodeIndex], inputNode, halfLaplacian[aboveNodeIndex]);
                      makeHalfLaplacian(belowNodeList, halfLaplacian[aboveNodeIndex], laplacian);
                      makeAbs(laplacian, absLaplacian[aboveNodeIndex]);
			       }
SNLCaboveLoopEncode: for (indexTYPE aboveNodeIndex=0; aboveNodeIndex<adjacentNodes; aboveNodeIndex++) {
				   #pragma HLS UNROLL
SNLCbelowLoopEncode: 	  for (indexTYPE belowNodeIndex=0; belowNodeIndex<adjacentNodes; belowNodeIndex++) {
						  #pragma HLS UNROLL
     				      nodeTriplets[aboveNodeIndex][belowNodeIndex] = tripletEncode(aboveNodeIndex, belowNodeIndex, absLaplacian[aboveNodeIndex][belowNodeIndex]); // Bit encode the node indices and Laplacian into a structTYPE that represents the triplet, Store the triplet in the corresponding array position
					  }
			       }

    return;
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
template<std::size_t power, std::size_t powerLength, std::size_t stage>
void MinFinderPipelined(structTYPE array[powerLength], structTYPE (& arrayOut)[powerLength]){
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
template<std::size_t power>
void MSS(structTYPE work_array[]) {
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
								nodeBadTriplets[belowNodeIndex][aboveNodeIndex] =
								!(nodeGoodLinks[belowLayerIndex][belowNodeIndex] == acceptLink && nodeGoodLinks[aboveLayerIndex][aboveNodeIndex] == acceptLink);
						     }
					     }
}
template<std::size_t powerLength>
void buildOnePrunedMatrix(
		indexTYPE thisNodeBestIndices[adjacentLayers][numberOfNodes],
		bool thisNodeBadTriplet[numberOfNodes][numberOfNodes],
		structTYPE tM[adjacentNodes][adjacentNodes],
		structTYPE (&tMP)[powerLength][powerLength],
		bool (&thisNodeBadTripletPruned)[powerLength][powerLength]){
#pragma HLS INLINE OFF
buildTMPnodesAbove: for (indexTYPE aboveNodeIndex=0; aboveNodeIndex<powerLength; aboveNodeIndex++) {
//                        #pragma HLS unroll
						indexTYPE originalAbove = thisNodeBestIndices[aboveLayerIndex][aboveNodeIndex];
buildTMPnodesBelow:     for (indexTYPE belowNodeIndex=0; belowNodeIndex<powerLength; belowNodeIndex++) {
//							#pragma HLS unroll
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
							if (thisNodeBadTripletPruned[aboveNodeIndex][belowNodeIndex]) {
								tMP[aboveNodeIndex][belowNodeIndex] = killLaplacianValue;
							}
                        }
					}
}
template<std::size_t powerLength>
void buildPrunedMatrices(bool nodeGoodLinks[adjacentLayers][numberOfNodes],indexTYPE bestIndices[adjacentLayers][numberOfNodes],
		structTYPE tM[adjacentNodes][adjacentNodes],structTYPE (&tMP)[powerLength][powerLength]){
#pragma HLS INLINE OFF
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
void nodeMinFinderEngine(structTYPE TMr[powerLength][powerLength], structTYPE laplacianMinimumsOfNode[powerLength], structTYPE laplacianMinimumsOfNodeTranspose[powerLength]) {
#pragma HLS INLINE OFF
//	structTYPE TM[powerLength][powerLength];
// 	#pragma HLS ARRAY_PARTITION variable=TM complete dim=0
//	structTYPE TMT[powerLength][powerLength];
// 	#pragma HLS ARRAY_PARTITION variable=TMT complete dim=0
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
					MinFinderPipelined<power,powerLength,0>(TMslice,TMintermed[0]);
					MinFinderPipelined<power,powerLength,0>(TMTslice,TMTintermed[0]);
				    if (power >= 2) {
				    	MinFinderPipelined<power,powerLength,1>(TMintermed[0],TMintermed[1]);
				    	MinFinderPipelined<power,powerLength,1>(TMTintermed[0],TMTintermed[1]);
				    }
				    if (power >= 3) {
				    	MinFinderPipelined<power,powerLength,2>(TMintermed[1],TMintermed[2]);
				    	MinFinderPipelined<power,powerLength,2>(TMTintermed[1],TMTintermed[2]);
				    }
				    if (power == 4) {
				    	MinFinderPipelined<power,powerLength,3>(TMintermed[2],TMintermed[3]);
				    	MinFinderPipelined<power,powerLength,3>(TMTintermed[2],TMTintermed[3]);
				    }
					laplacianMinimumsOfNode[adjacentNodeIndex] = TMintermed[power-1][0];
					laplacianMinimumsOfNodeTranspose[adjacentNodeIndex] = TMTintermed[power-1][0];
				}
}
template<std::size_t power, std::size_t powerLength>
void nodeMSSEngine(structTYPE laplacianMinimumsOfNode[powerLength], structTYPE laplacianMinimumsOfNodeTranspose[powerLength], bool nodeLinks[adjacentLayers][numberOfNodes], indexTYPE bestIndices[adjacentLayers][numberOfNodes]) {
#pragma HLS INLINE OFF

// Set allNodesGoodLinks to all rejectLinks. Since we already stored all possible triplets corresponding to acceptLinks in tripletMatrixPruned, we no longer need to keep the record in allNodesGoodLinks.
// Refreshing allNodesGoodLinks allows us to further decrease the possible triplet solutions and update allNodesGoodLinks with updateLink again with a fewer number of triplets, then repeat the process until
// there is at most one triplet per node.
   initializeNodeGlobalMatrix(nodeLinks);

                // TODO: see if we can pass in the triplets and do comparisons on the triplets (not the laplacians) for MSS and Minfinder
				MSS<power>(laplacianMinimumsOfNode);
				MSS<power>(laplacianMinimumsOfNodeTranspose);
			// Accept the links corresponding to the smallest half of the triplets stored in the Minimums lists
updateLinks:	for (indexTYPE largestTripletIndex=0; largestTripletIndex < (1<<(power-1)); largestTripletIndex++) {
// unrolling this loop increases LUT from 85K to 97K for nodeMSSEngine, and only saves 3 cycles at 1.5 ns, so we do not unroll
					updateUpLink(laplacianMinimumsOfNode[largestTripletIndex], nodeLinks[aboveLayerIndex], bestIndices[aboveLayerIndex][largestTripletIndex]);
					updateDownLink(laplacianMinimumsOfNodeTranspose[largestTripletIndex], nodeLinks[belowLayerIndex], bestIndices[belowLayerIndex][largestTripletIndex]);
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
   		// Set allNodesGoodLinks to all rejectLinks. Since we already stored all possible triplets corresponding to acceptLinks in tripletMatrixPruned, we no longer need to keep the record in allNodesGoodLinks.
        // Refreshing allNodesGoodLinks allows us to further decrease the possible triplet solutions and update allNodesGoodLinks with updateLink again with a fewer number of triplets, then repeat the process until
        // there is at most one triplet per node.
//       initializeNodeGlobalMatrix(nodeGoodLinks); moved to nodeMSSEngine

	   nodeMinFinderEngine<power,localPowerLength>(tripletMatrixPruned,laplacianMinimumsOfNode,laplacianMinimumsOfNodeTranspose);
	   nodeMSSEngine<power,localPowerLength>(laplacianMinimumsOfNode,laplacianMinimumsOfNodeTranspose,nodeGoodLinks,bestIndices);
}
void laplacianCalculator(laplacianTYPE coordinates[totalLayers][nWeightedCoordinates][numberOfNodes], structTYPE (&tripletMatrix)[middleLayers][numberOfNodes][adjacentNodes][adjacentNodes]) {
#pragma HLS INLINE OFF
	// Loop through only the middle layers because the uppermost and lowermost layers are not associated with triplets
LaplacianLayerLoop: for (indexTYPE middleLayer=0; middleLayer<middleLayers; middleLayer++) {
                	#pragma HLS UNROLL
LaplacianNodeLoop:	    for (indexTYPE nodeIndex=0; nodeIndex<numberOfNodes; nodeIndex++) {
	       				#pragma HLS UNROLL
							   singleNodeLaplacianCalculator(coordinates[middleLayer+2][2], coordinates[middleLayer][0], tripletMatrix[middleLayer][nodeIndex], coordinates[middleLayer+1][1][nodeIndex]);
        	     		} // end nodeLoop
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
void allNodeMSS(structTYPE laplacianMinimumsOfNode[middleLayers][numberOfNodes][powerLength],
		        structTYPE laplacianMinimumsOfNodeTranspose[middleLayers][numberOfNodes][powerLength],
				bool (& allNodesGoodLinks)[middleLayers][numberOfNodes][adjacentLayers][numberOfNodes],
                indexTYPE (& bestIndices)[middleLayers][numberOfNodes][adjacentLayers][numberOfNodes]
					   ) {
#pragma HLS INLINE OFF
#pragma HLS ARRAY_PARTITION variable=laplacianMinimumsOfNode complete dim=0
#pragma HLS ARRAY_PARTITION variable=laplacianMinimumsOfNodeTranspose complete dim=0
#pragma HLS ARRAY_PARTITION variable=allNodesGoodLinks complete dim=0
#pragma HLS ARRAY_PARTITION variable=bestIndices complete dim=0

aNMSSlayerLoop: for (indexTYPE middleLayer=0; middleLayer<middleLayers; middleLayer++) {
	      	  #pragma HLS unroll
aNMSSnodeLoop:	  for (indexTYPE nodeIndex=0; nodeIndex<numberOfNodes; nodeIndex++) {
	    		  #pragma HLS UNROLL
						nodeMSSEngine<power,powerLength>(laplacianMinimumsOfNode[middleLayer][nodeIndex],laplacianMinimumsOfNodeTranspose[middleLayer][nodeIndex],
								allNodesGoodLinks[middleLayer][nodeIndex],bestIndices[middleLayer][nodeIndex]);
			      } // end nodeLoop
              } // end layerLoop
	     consensusProtocol(allNodesGoodLinks);
}
template<std::size_t power, std::size_t localPowerLength>
void nodeMinFinder(bool nodeGoodLinks[adjacentLayers][numberOfNodes], indexTYPE bestIndices[adjacentLayers][numberOfNodes], structTYPE tM[adjacentNodes][adjacentNodes],
	structTYPE (& laplacianMinimumsOfNode)[localPowerLength], structTYPE (& laplacianMinimumsOfNodeTranspose)[localPowerLength]
	) {
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
	   nodeMinFinderEngine<power,localPowerLength>(tripletMatrixPruned,laplacianMinimumsOfNode,laplacianMinimumsOfNodeTranspose);
}
template<std::size_t power, std::size_t powerLength>
void allNodeMinFindersV2(bool allNodesGoodLinks[middleLayers][numberOfNodes][adjacentLayers][numberOfNodes],
                	   indexTYPE bestIndices[middleLayers][numberOfNodes][adjacentLayers][numberOfNodes],
					   structTYPE tripletMatrix[middleLayers][numberOfNodes][adjacentNodes][adjacentNodes],
					   structTYPE (& laplacianMinimumsOfNode)[middleLayers][numberOfNodes][powerLength],
					   structTYPE (& laplacianMinimumsOfNodeTranspose)[middleLayers][numberOfNodes][powerLength]
					   ) {
#pragma HLS INLINE OFF
#pragma HLS ARRAY_PARTITION variable=laplacianMinimumsOfNode complete dim=0
#pragma HLS ARRAY_PARTITION variable=laplacianMinimumsOfNodeTranspose complete dim=0
#pragma HLS ARRAY_PARTITION variable=allNodesGoodLinks complete dim=0
#pragma HLS ARRAY_PARTITION variable=bestIndices complete dim=0
aNMF2layerLoop: for (indexTYPE middleLayer=0; middleLayer<middleLayers; middleLayer++) {
	      	  #pragma HLS unroll
aNMF2nodeLoop:	  for (indexTYPE nodeIndex=0; nodeIndex<numberOfNodes; nodeIndex++) {
	    		  #pragma HLS UNROLL
						nodeMinFinder<power,powerLength>(allNodesGoodLinks[middleLayer][nodeIndex],bestIndices[middleLayer][nodeIndex],tripletMatrix[middleLayer][nodeIndex],
								laplacianMinimumsOfNode[middleLayer][nodeIndex],laplacianMinimumsOfNodeTranspose[middleLayer][nodeIndex]);
			      } // end nodeLoop
              } // end layerLoop
}
template<std::size_t power, std::size_t powerlength>
void allNodeMinFinders(structTYPE tripletMatrixPruned[middleLayers][numberOfNodes][powerlength][powerlength],
					   structTYPE (& laplacianMinimumsOfNode)[middleLayers][numberOfNodes][powerlength],
					   structTYPE (& laplacianMinimumsOfNodeTranspose)[middleLayers][numberOfNodes][powerlength]) {
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
						nodeMinFinderEngine<power,powerlength>(tripletMatrixLocal[middleLayer][nodeIndex],
								laplacianMinimumsOfNode[middleLayer][nodeIndex],
								laplacianMinimumsOfNodeTranspose[middleLayer][nodeIndex]);
	                 } else {
	                	nodeMinFinderEngine<power,powerlength>(tripletMatrixPruned[middleLayer][nodeIndex],
                    			laplacianMinimumsOfNode[middleLayer][nodeIndex],
								laplacianMinimumsOfNodeTranspose[middleLayer][nodeIndex]);
	                 }
			      } // end nodeLoop
              } // end layerLoop
}
void copyCoordinates(laplacianTYPE coordinates[totalLayers][nWeightedCoordinates][numberOfNodes], laplacianTYPE nodeCoordinates[totalLayers][nWeightedCoordinates][numberOfNodes]) {
#pragma HLS INLINE OFF
	// copy coordinates into local arrays
copyCoordLayerLoop: for (indexTYPE layer=0; layer<totalLayers; layer++) {
	              	  	#pragma HLS unroll
copyCoordWeightedLoop:	for (indexTYPE weightIndex=0; weightIndex<nWeightedCoordinates; weightIndex++) {
			           		#pragma HLS UNROLL
copyCoordNodeLoop:	        for (indexTYPE nodeIndex=0; nodeIndex<numberOfNodes; nodeIndex++) {
	            			   	#pragma HLS UNROLL
									nodeCoordinates[layer][weightIndex][nodeIndex] = coordinates[layer][weightIndex][nodeIndex];
          	     	    	} // end nodeLoop
                        } // end weightLoop
                    } // end layerLoop
}

template<std::size_t power, std::size_t powerLength>
void eventLoopAllNodeMSS(hls::stream_of_blocks<structTYPE[eventPipelineStages][middleLayers][numberOfNodes][powerLength]> &laplacianMinimumsOfNodeSOB,
		        	hls::stream_of_blocks<structTYPE[eventPipelineStages][middleLayers][numberOfNodes][powerLength]> &laplacianMinimumsOfNodeTransposeSOB,
					hls::stream_of_blocks<bool[eventPipelineStages][middleLayers][numberOfNodes][adjacentLayers][numberOfNodes]> &allNodesGoodLinksSOB,
                	hls::stream_of_blocks<indexTYPE[eventPipelineStages][middleLayers][numberOfNodes][adjacentLayers][numberOfNodes]> &bestIndicesSOB
					   ) {
#pragma HLS INLINE OFF
hls::write_lock<bool[eventPipelineStages][middleLayers][numberOfNodes][adjacentLayers][numberOfNodes]> allNodesGoodLinks(allNodesGoodLinksSOB);
hls::write_lock<indexTYPE[eventPipelineStages][middleLayers][numberOfNodes][adjacentLayers][numberOfNodes]> bestIndices(bestIndicesSOB);
hls::read_lock<structTYPE[eventPipelineStages][middleLayers][numberOfNodes][powerLength]> laplacianMinimumsOfNode(laplacianMinimumsOfNodeSOB);
hls::read_lock<structTYPE[eventPipelineStages][middleLayers][numberOfNodes][powerLength]> laplacianMinimumsOfNodeTranspose(laplacianMinimumsOfNodeTransposeSOB)

allNodeMSSEventLoop: for (indexTYPE eventPipeline=0; eventPipeline<eventPipelineStages; eventPipeline++) {
							allNodeMSS<power,powerLength>(laplacianMinimumsOfNode[eventPipeline], laplacianMinimumsOfNodeTranspose[eventPipeline], allNodesGoodLinks[eventPipeline], bestIndices[eventPipeline]);
							}
}

template<std::size_t power, std::size_t powerLength>
void eventLoopAllNodeMinFindersV2(hls::stream_of_blocks<bool[eventPipelineStages][middleLayers][numberOfNodes][adjacentLayers][numberOfNodes]> &allNodesGoodLinksSOB,
                	   		hls::stream_of_blocks<indexTYPE[eventPipelineStages][middleLayers][numberOfNodes][adjacentLayers][numberOfNodes]> &bestIndicesSOB,
					   		structTYPE tripletMatrix[eventPipelineStages][middleLayers][numberOfNodes][adjacentNodes][adjacentNodes],
					  		hls::stream_of_blocks<structTYPE[eventPipelineStages][middleLayers][numberOfNodes][powerLength]> &laplacianMinimumsOfNodeSOB,
					   		hls::stream_of_blocks<structTYPE[eventPipelineStages][middleLayers][numberOfNodes][powerLength]> &laplacianMinimumsOfNodeTransposeSOB
					   ) {
#pragma HLS INLINE OFF
hls::read_lock<bool[eventPipelineStages][middleLayers][numberOfNodes][adjacentLayers][numberOfNodes]> allNodesGoodLinks(allNodesGoodLinksSOB);
hls::read_lock<indexTYPE[eventPipelineStages][middleLayers][numberOfNodes][adjacentLayers][numberOfNodes]> bestIndices(bestIndicesSOB);
hls::write_lock<structTYPE[eventPipelineStages][middleLayers][numberOfNodes][powerLength]> laplacianMinimumsOfNode(laplacianMinimumsOfNodeSOB);
hls::write_lock<structTYPE[eventPipelineStages][middleLayers][numberOfNodes][powerLength]> laplacianMinimumsOfNodeTranspose(laplacianMinimumsOfNodeTransposeSOB)

allNodeMinFinderEventLoop: for (indexTYPE eventPipeline=0; eventPipeline<eventPipelineStages; eventPipeline++) {
							allNodeMinFindersV2<power,powerLength>(allNodesGoodLinks[eventPipeline], bestIndices[eventPipeline], tripletMatrix[eventPipeline], laplacianMinimumsOfNode[eventPipeline], laplacianMinimumsOfNodeTranspose[eventPipeline]);
							}

}



/*
	fullSystem: Determines the most likely paths taken by particle fragments resulting from a collision in the Large Hadron Collider
	@param nodeCoordinates A totalLayers x numberOfNodes Matrix that contains the physical coordinate points for each hit. Each coordinate has 5 weighted copies to account for the distances between layers (3 copies for second derivative and 2 for first derivative)
	@param ans Necessary for Vivado synthesis
*/
//TODO: Move the testing part (generateCoordinates and *maybe also* main) into the test bench
void fullSystem(laplacianTYPE coordinates[totalLayers][nWeightedCoordinates][numberOfNodes], bool * fullSystemReturnCode) {
	#pragma HLS DATAFLOW

	#pragma HLS interface m_axi port=coordinates offset=slave bundle=mem
	#pragma HLS ARRAY_PARTITION variable=coordinates complete dim=1
	#pragma HLS ARRAY_PARTITION variable=coordinates complete dim=2
	#pragma HLS ARRAY_PARTITION variable=coordinates complete dim=3

	laplacianTYPE nodeCoordinates[totalLayers][nWeightedCoordinates][numberOfNodes];
	#pragma HLS ARRAY_PARTITION variable=nodeCoordinates complete dim=1
	#pragma HLS ARRAY_PARTITION variable=nodeCoordinates complete dim=2
	#pragma HLS ARRAY_PARTITION variable=nodeCoordinates complete dim=3
/*
	// allNodesGoodLinks is the global data structure that encodes the "accepted links" (most likely path taken by particle fragment between hits). Initialize allNodeGoodLinks so all links are reject links
	bool allNodesGoodLinks[eventPipelineStages][middleLayers][numberOfNodes][adjacentLayers][numberOfNodes];
	#pragma HLS ARRAY_PARTITION variable=allNodesGoodLinks complete dim=0
*/
//	typedef structTYPE TMtype[middleLayers][numberOfNodes][adjacentNodes][adjacentNodes];

	// tripletMatrix contains the set of all possible triplets per node
	structTYPE tripletMatrix[eventPipelineStages][middleLayers][numberOfNodes][adjacentNodes][adjacentNodes];
	#pragma HLS ARRAY_PARTITION variable=tripletMatrix dim=1 complete
	#pragma HLS ARRAY_PARTITION variable=tripletMatrix dim=2 complete
	#pragma HLS ARRAY_PARTITION variable=tripletMatrix dim=3 complete
	#pragma HLS ARRAY_RESHAPE variable=tripletMatrix dim=4 complete
	#pragma HLS ARRAY_RESHAPE variable=tripletMatrix dim=5 complete
	// allNodesGoodLinks is the global data structure that encodes the "accepted links" (most likely path taken by particle fragment between hits). Initialize allNodeGoodLinks so all links are reject links
	// bool allNodesGoodLinks[eventPipelineStages][middleLayers][numberOfNodes][adjacentLayers][numberOfNodes];
	// #pragma HLS ARRAY_PARTITION variable=allNodesGoodLinks complete dim=0
    // we save the best indices for each node's links up and down, coming out of nodeMSSEngine
    // indexTYPE bestIndices[eventPipelineStages][middleLayers][numberOfNodes][adjacentLayers][numberOfNodes];
	// #pragma HLS ARRAY_PARTITION variable=bestIndices complete dim=0

#if combinedNodeProcessor == false

    const std::size_t highestPowerLength = 1<<highestPower;
    const std::size_t NHPowerLength = 1<<(highestPower-1);
    const std::size_t NNHPowerLength = 1<<(highestPower-2);
    const std::size_t NNNHPowerLength = 1<<(highestPower-3);

    hls::stream_of_blocks<structTYPE[eventPipelineStages][middleLayers][numberOfNodes][highestPowerLength]> laplacianMinimumsOfNodeHP;
    hls::stream_of_blocks<structTYPE[eventPipelineStages][middleLayers][numberOfNodes][highestPowerLength]> laplacianMinimumsOfNodeTransposeHP;

    hls::stream_of_blocks<structTYPE[eventPipelineStages][middleLayers][numberOfNodes][NHPowerLength]> laplacianMinimumsOfNodeNHP;
    hls::stream_of_blocks<structTYPE[eventPipelineStages][middleLayers][numberOfNodes][NHPowerLength]> laplacianMinimumsOfNodeTransposeNHP;

    hls::stream_of_blocks<structTYPE[eventPipelineStages][middleLayers][numberOfNodes][NNHPowerLength]> laplacianMinimumsOfNodeNNHP;
    hls::stream_of_blocks<structTYPE[eventPipelineStages][middleLayers][numberOfNodes][NNHPowerLength]> laplacianMinimumsOfNodeTransposeNNHP;

    hls::stream_of_blocks<structTYPE[eventPipelineStages][middleLayers][numberOfNodes][NNNHPowerLength]> laplacianMinimumsOfNodeNNNHP;
    hls::stream_of_blocks<structTYPE[eventPipelineStages][middleLayers][numberOfNodes][NNNHPowerLength]> laplacianMinimumsOfNodeTransposeNNNHP;

	hls::stream_of_blocks<bool[eventPipelineStages][middleLayers][numberOfNodes][adjacentLayers][numberOfNodes]>allNodesGoodLinksHP;
	hls::stream_of_blocks<indexTYPE[eventPipelineStages][middleLayers][numberOfNodes][adjacentLayers][numberOfNodes]>bestIndicesHP;

	hls::stream_of_blocks<bool[eventPipelineStages][middleLayers][numberOfNodes][adjacentLayers][numberOfNodes]>allNodesGoodLinksNHP;
	hls::stream_of_blocks<indexTYPE[eventPipelineStages][middleLayers][numberOfNodes][adjacentLayers][numberOfNodes]>bestIndicesNHP;

	hls::stream_of_blocks<bool[eventPipelineStages][middleLayers][numberOfNodes][adjacentLayers][numberOfNodes]>allNodesGoodLinksNNHP;
	hls::stream_of_blocks<indexTYPE[eventPipelineStages][middleLayers][numberOfNodes][adjacentLayers][numberOfNodes]>bestIndicesNNHP;

	hls::stream_of_blocks<bool[eventPipelineStages][middleLayers][numberOfNodes][adjacentLayers][numberOfNodes]>allNodesGoodLinksNNNHP;
	hls::stream_of_blocks<indexTYPE[eventPipelineStages][middleLayers][numberOfNodes][adjacentLayers][numberOfNodes]>bestIndicesNNNHP;

		hls::stream_of_blocks<bool[eventPipelineStages][middleLayers][numberOfNodes][adjacentLayers][numberOfNodes]>allNodesGoodLinksLAST;
	hls::stream_of_blocks<indexTYPE[eventPipelineStages][middleLayers][numberOfNodes][adjacentLayers][numberOfNodes]>bestIndicesLAST;

#endif

/*
	// tripletMatrix contains the set of all possible triplets per node
	structTYPE tripletMatrix[middleLayers][numberOfNodes][adjacentNodes][adjacentNodes];
	#pragma HLS ARRAY_PARTITION variable=tripletMatrix dim=1 complete
	#pragma HLS ARRAY_PARTITION variable=tripletMatrix dim=2 complete
	#pragma HLS ARRAY_RESHAPE variable=tripletMatrix dim=3 complete
	#pragma HLS ARRAY_RESHAPE variable=tripletMatrix dim=4 complete
	// allNodesGoodLinks is the global data structure that encodes the "accepted links" (most likely path taken by particle fragment between hits). Initialize allNodeGoodLinks so all links are reject links
	bool allNodesGoodLinks[middleLayers][numberOfNodes][adjacentLayers][numberOfNodes];
	#pragma HLS ARRAY_PARTITION variable=allNodesGoodLinks complete dim=0
    // we save the best indices for each node's links up and down, coming out of nodeMSSEngine
    indexTYPE bestIndices[middleLayers][numberOfNodes][adjacentLayers][numberOfNodes];
	#pragma HLS ARRAY_PARTITION variable=bestIndices complete dim=0
*/

    // dummy variables to clarify sequencing for event pipeline
//    indexTYPE dummyForSequencing[eventPipelineStages][highestPower];
//	#pragma HLS ARRAY_PARTITION variable=dummyForSequencing complete dim=0

/*
    indexTYPE pipelineStage[eventPipelineStages][eventPipelineStages] = {
    		{0,1,2,3,4},
    		{4,0,1,2,3},
    		{3,4,0,1,2},
    		{2,3,4,0,1},
    		{1,2,3,4,0}
    };
*/
    /*
	// tripletMatrix contains the set of all possible triplets per node
	structTYPE tripletMatrix0[middleLayers][numberOfNodes][adjacentNodes][adjacentNodes];
	#pragma HLS ARRAY_PARTITION variable=tripletMatrix0 dim=1 complete
	#pragma HLS ARRAY_PARTITION variable=tripletMatrix0 dim=2 complete
	#pragma HLS ARRAY_RESHAPE variable=tripletMatrix0 dim=3 complete
	#pragma HLS ARRAY_RESHAPE variable=tripletMatrix0 dim=4 complete
	// allNodesGoodLinks is the global data structure that encodes the "accepted links" (most likely path taken by particle fragment between hits). Initialize allNodeGoodLinks so all links are reject links
	bool allNodesGoodLinks0[middleLayers][numberOfNodes][adjacentLayers][numberOfNodes];
	#pragma HLS ARRAY_PARTITION variable=allNodesGoodLinks0 complete dim=0
    // we save the best indices for each node's links up and down, coming out of nodeMSSEngine
    indexTYPE bestIndices0[middleLayers][numberOfNodes][adjacentLayers][numberOfNodes];
	#pragma HLS ARRAY_PARTITION variable=bestIndices0 complete dim=0

	// tripletMatrix contains the set of all possible triplets per node
	structTYPE tripletMatrix1[middleLayers][numberOfNodes][adjacentNodes][adjacentNodes];
	#pragma HLS ARRAY_PARTITION variable=tripletMatrix1 dim=1 complete
	#pragma HLS ARRAY_PARTITION variable=tripletMatrix1 dim=2 complete
	#pragma HLS ARRAY_RESHAPE variable=tripletMatrix1 dim=3 complete
	#pragma HLS ARRAY_RESHAPE variable=tripletMatrix1 dim=4 complete
	// allNodesGoodLinks is the global data structure that encodes the "accepted links" (most likely path taken by particle fragment between hits). Initialize allNodeGoodLinks so all links are reject links
	bool allNodesGoodLinks1[middleLayers][numberOfNodes][adjacentLayers][numberOfNodes];
	#pragma HLS ARRAY_PARTITION variable=allNodesGoodLinks1 complete dim=0
    // we save the best indices for each node's links up and down, coming out of nodeMSSEngine
    indexTYPE bestIndices1[middleLayers][numberOfNodes][adjacentLayers][numberOfNodes];
	#pragma HLS ARRAY_PARTITION variable=bestIndices1 complete dim=0

	// tripletMatrix contains the set of all possible triplets per node
	structTYPE tripletMatrix2[middleLayers][numberOfNodes][adjacentNodes][adjacentNodes];
	#pragma HLS ARRAY_PARTITION variable=tripletMatrix2 dim=1 complete
	#pragma HLS ARRAY_PARTITION variable=tripletMatrix2 dim=2 complete
	#pragma HLS ARRAY_RESHAPE variable=tripletMatrix2 dim=3 complete
	#pragma HLS ARRAY_RESHAPE variable=tripletMatrix2 dim=4 complete
	// allNodesGoodLinks is the global data structure that encodes the "accepted links" (most likely path taken by particle fragment between hits). Initialize allNodeGoodLinks so all links are reject links
	bool allNodesGoodLinks2[middleLayers][numberOfNodes][adjacentLayers][numberOfNodes];
	#pragma HLS ARRAY_PARTITION variable=allNodesGoodLinks2 complete dim=0
    // we save the best indices for each node's links up and down, coming out of nodeMSSEngine
    indexTYPE bestIndices2[middleLayers][numberOfNodes][adjacentLayers][numberOfNodes];
	#pragma HLS ARRAY_PARTITION variable=bestIndices2 complete dim=0

	// tripletMatrix contains the set of all possible triplets per node
	structTYPE tripletMatrix3[middleLayers][numberOfNodes][adjacentNodes][adjacentNodes];
	#pragma HLS ARRAY_PARTITION variable=tripletMatrix3 dim=1 complete
	#pragma HLS ARRAY_PARTITION variable=tripletMatrix3 dim=2 complete
	#pragma HLS ARRAY_RESHAPE variable=tripletMatrix3 dim=3 complete
	#pragma HLS ARRAY_RESHAPE variable=tripletMatrix3 dim=4 complete
	// allNodesGoodLinks is the global data structure that encodes the "accepted links" (most likely path taken by particle fragment between hits). Initialize allNodeGoodLinks so all links are reject links
	bool allNodesGoodLinks3[middleLayers][numberOfNodes][adjacentLayers][numberOfNodes];
	#pragma HLS ARRAY_PARTITION variable=allNodesGoodLinks3 complete dim=0
    // we save the best indices for each node's links up and down, coming out of nodeMSSEngine
    indexTYPE bestIndices3[middleLayers][numberOfNodes][adjacentLayers][numberOfNodes];
	#pragma HLS ARRAY_PARTITION variable=bestIndices3 complete dim=0

	// tripletMatrix contains the set of all possible triplets per node
	structTYPE tripletMatrix4[middleLayers][numberOfNodes][adjacentNodes][adjacentNodes];
	#pragma HLS ARRAY_PARTITION variable=tripletMatrix4 dim=1 complete
	#pragma HLS ARRAY_PARTITION variable=tripletMatrix4 dim=2 complete
	#pragma HLS ARRAY_RESHAPE variable=tripletMatrix4 dim=3 complete
	#pragma HLS ARRAY_RESHAPE variable=tripletMatrix4 dim=4 complete
	// allNodesGoodLinks is the global data structure that encodes the "accepted links" (most likely path taken by particle fragment between hits). Initialize allNodeGoodLinks so all links are reject links
	bool allNodesGoodLinks4[middleLayers][numberOfNodes][adjacentLayers][numberOfNodes];
	#pragma HLS ARRAY_PARTITION variable=allNodesGoodLinks4 complete dim=0
    // we save the best indices for each node's links up and down, coming out of nodeMSSEngine
    indexTYPE bestIndices4[middleLayers][numberOfNodes][adjacentLayers][numberOfNodes];
	#pragma HLS ARRAY_PARTITION variable=bestIndices4 complete dim=0

    structTYPE (*TM0Pointer)[middleLayers][numberOfNodes][adjacentNodes][adjacentNodes] = &tripletMatrix0;
    structTYPE (*TM1Pointer)[middleLayers][numberOfNodes][adjacentNodes][adjacentNodes] = &tripletMatrix1;
    structTYPE (*TM2Pointer)[middleLayers][numberOfNodes][adjacentNodes][adjacentNodes] = &tripletMatrix2;
    structTYPE (*TM3Pointer)[middleLayers][numberOfNodes][adjacentNodes][adjacentNodes] = &tripletMatrix3;
    structTYPE (*TM4Pointer)[middleLayers][numberOfNodes][adjacentNodes][adjacentNodes] = &tripletMatrix4;

    structTYPE *TMlist[eventPipelineStages];
    TMlist[0] = &(tripletMatrix0[0][0][0][0]);
    TMlist[1] = &(tripletMatrix1[0][0][0][0]);
    TMlist[2] = &(tripletMatrix2[0][0][0][0]);
    TMlist[3] = &(tripletMatrix3[0][0][0][0]);
    TMlist[4] = &(tripletMatrix4[0][0][0][0]);
*/

    copyCoordinates(coordinates, nodeCoordinates);

/* for event loop
//    laplacianCalculator(nodeCoordinates, *TMlist[pipelineStage[0]]);

eventPipelineLoop:    for (indexTYPE iPipeline=0; iPipeline<eventPipelineStages; iPipeline++) {
//		#pragma HLS PIPELINE II=120 rewind

//    	laplacianCalculator(nodeCoordinates, tripletMatrix[pipelineStage[iPipeline][0]]);
//    	allNodeProcessors<highestPower>(allNodesGoodLinks[pipelineStage[iPipeline][1]], bestIndices[pipelineStage[iPipeline][1]], tripletMatrix[pipelineStage[iPipeline][1]]);
//    	allNodeProcessors<highestPower-1>(allNodesGoodLinks[pipelineStage[iPipeline][2]], bestIndices[pipelineStage[iPipeline][2]], tripletMatrix[pipelineStage[iPipeline][2]]);
//    	allNodeProcessors<highestPower-2>(allNodesGoodLinks[pipelineStage[iPipeline][3]], bestIndices[pipelineStage[iPipeline][3]], tripletMatrix[pipelineStage[iPipeline][3]]);
//    	allNodeProcessors<highestPower-3>(allNodesGoodLinks[pipelineStage[iPipeline][4]], bestIndices[pipelineStage[iPipeline][4]], tripletMatrix[pipelineStage[iPipeline][4]]);

//    	laplacianCalculator(nodeCoordinates, tripletMatrix[iPipeline]);
//    	allNodeProcessors<highestPower>(allNodesGoodLinks[iPipeline], bestIndices[iPipeline], tripletMatrix[iPipeline], 1, dummyForSequencing[iPipeline][0]);
//    	allNodeProcessors<highestPower-1>(allNodesGoodLinks[iPipeline], bestIndices[iPipeline], tripletMatrix[iPipeline], dummyForSequencing[iPipeline][0], dummyForSequencing[iPipeline][1]);
//    	allNodeProcessors<highestPower-2>(allNodesGoodLinks[iPipeline], bestIndices[iPipeline], tripletMatrix[iPipeline], dummyForSequencing[iPipeline][1], dummyForSequencing[iPipeline][2]);
//    	allNodeProcessors<highestPower-3>(allNodesGoodLinks[iPipeline], bestIndices[iPipeline], tripletMatrix[iPipeline], dummyForSequencing[iPipeline][2], dummyForSequencing[iPipeline][3]);

    	laplacianCalculator(nodeCoordinates, tripletMatrix[iPipeline]);
    	allNodeProcessors<highestPower>(allNodesGoodLinks[iPipeline], bestIndices[iPipeline], tripletMatrix[iPipeline]);
    	allNodeProcessors<highestPower-1>(allNodesGoodLinks[iPipeline], bestIndices[iPipeline], tripletMatrix[iPipeline]);
    	allNodeProcessors<highestPower-2>(allNodesGoodLinks[iPipeline], bestIndices[iPipeline], tripletMatrix[iPipeline]);
    	allNodeProcessors<highestPower-3>(allNodesGoodLinks[iPipeline], bestIndices[iPipeline], tripletMatrix[iPipeline]);

	} // end event loop
*/

/*
    allNodeProcessors<highestPower>(allNodesGoodLinks1, bestIndices1, (structTYPE (*)[numberOfNodes][adjacentNodes][adjacentNodes])TMlist[pipelineStage[1]]);
    allNodeProcessors<highestPower-1>(allNodesGoodLinks2, bestIndices2, (structTYPE (*)[numberOfNodes][adjacentNodes][adjacentNodes])TMlist[pipelineStage[2]]);
    allNodeProcessors<highestPower-2>(allNodesGoodLinks3, bestIndices3, (structTYPE (*)[numberOfNodes][adjacentNodes][adjacentNodes])TMlist[pipelineStage[3]]);
    allNodeProcessors<highestPower-3>(allNodesGoodLinks4, bestIndices4, (structTYPE (*)[numberOfNodes][adjacentNodes][adjacentNodes])TMlist[pipelineStage[4]]);
    for (indexTYPE iPipeline=0; iPipeline<eventPipelineStages; iPipeline++) {
    	pipelineStage[iPipeline] = (pipelineStage[iPipeline] + (eventPipelineStages-1)) % eventPipelineStages;
    	// {0,1,2,3,4) becomes {4,0,1,2,3} becomes {3,4,0,1,2} becomes {2,3,4,0,1} becomes {1,2,3,4,0} becomes {0,1,2,3,4}
    	// cycling back to {1,2,3,4,0} means that event0 is ready with final answer, followed by event4 giving final answer, followed by event3 etc.
    }
*/

    laplacianCalculator(nodeCoordinates, tripletMatrix[0]);
//    allNodeProcessors<highestPower>(allNodesGoodLinks[0], bestIndices[0], tripletMatrix[0]);

#if combinedNodeProcessor == false

//    allNodeMinFinders<highestPower,highestPowerLength>(tripletMatrix[0], laplacianMinimumsOfNodeHP, laplacianMinimumsOfNodeTransposeHP);
	eventLoopAllNodeMinFindersV2<highestPower,highestPowerLength>(allNodesGoodLinksHP, bestIndicesHP, tripletMatrix, laplacianMinimumsOfNodeHP, laplacianMinimumsOfNodeTransposeHP);
	eventLoopAllNodeMSS<highestPower,highestPowerLength>(laplacianMinimumsOfNodeHP, laplacianMinimumsOfNodeTransposeHP, allNodesGoodLinksNHP, bestIndicesNHP);
	eventLoopAllNodeMinFindersV2<highestPower-1,NHPowerLength>(allNodesGoodLinksNHP, bestIndicesNHP, tripletMatrix, laplacianMinimumsOfNodeNHP, laplacianMinimumsOfNodeTransposeNHP);
	eventLoopAllNodeMSS<highestPower-1,NHPowerLength>(laplacianMinimumsOfNodeNHP, laplacianMinimumsOfNodeTransposeNHP, allNodesGoodLinksNNHP, bestIndicesNNHP);
	eventLoopAllNodeMinFindersV2<highestPower-2,NNHPowerLength>(allNodesGoodLinksNNHP, bestIndicesNNHP, tripletMatrix, laplacianMinimumsOfNodeNNHP, laplacianMinimumsOfNodeTransposeNNHP);
	eventLoopAllNodeMSS<highestPower-2,NNHPowerLength>(laplacianMinimumsOfNodeNNHP, laplacianMinimumsOfNodeTransposeNNHP, allNodesGoodLinksNNNHP, bestIndicesNNNHP);
//	allNodeMinFindersV2<highestPower-3,NNNHPowerLength>(allNodesGoodLinksNNNHP, bestIndicesNNNHP, tripletMatrix, laplacianMinimumsOfNodeNNNHP, laplacianMinimumsOfNodeTransposeNNNHP);
//	allNodeMSS<highestPower-3,NNNHPowerLength>(laplacianMinimumsOfNodeNNNHP, laplacianMinimumsOfNodeTransposeNNNHP, allNodesGoodLinksLAST, bestIndicesLAST);

#elif combinedNodeProcessor == true

	allNodeProcessors<highestPower>(allNodesGoodLinks[0], bestIndices[0], tripletMatrix[0]);
	allNodeProcessors<highestPower-1>(allNodesGoodLinks[0], bestIndices[0], tripletMatrix[0]);
    allNodeProcessors<highestPower-2>(allNodesGoodLinks[0], bestIndices[0], tripletMatrix[0]);
    allNodeProcessors<highestPower-3>(allNodesGoodLinks[0], bestIndices[0], tripletMatrix[0]);

#endif

/*
    laplacianCalculator(nodeCoordinates, tripletMatrix[1]);
    allNodeProcessors<highestPower>(allNodesGoodLinks[1], bestIndices[1], tripletMatrix[1]);
    allNodeProcessors<highestPower-1>(allNodesGoodLinks[1], bestIndices[1], tripletMatrix[1]);
    allNodeProcessors<highestPower-2>(allNodesGoodLinks[1], bestIndices[1], tripletMatrix[1]);
    allNodeProcessors<highestPower-3>(allNodesGoodLinks[1], bestIndices[1], tripletMatrix[1]);
*/

/*
    laplacianCalculator(nodeCoordinates, tripletMatrix);
    allNodeProcessors<highestPower>(allNodesGoodLinks, bestIndices, tripletMatrix);
    allNodeProcessors<highestPower-1>(allNodesGoodLinks, bestIndices, tripletMatrix);
    allNodeProcessors<highestPower-2>(allNodesGoodLinks, bestIndices, tripletMatrix);
    allNodeProcessors<highestPower-3>(allNodesGoodLinks, bestIndices, tripletMatrix);
*/

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
	*fullSystemReturnCode = allNodesGoodLinks[eventPipelineStages-1][middleLayers-1][numberOfNodes-1][adjacentLayers-1][numberOfNodes-1];
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
//#pragma HLS DATAFLOW
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
			29, 39, 49, 59, 89, 99, 109, 119, 129, 139, 149, 159, 189, 199, 209, 219,
			19, 29, 39, 49, 59, 89, 99, 109, 119, 129, 139, 149, 159, 189, 199, 309,
			4, 14, 24, 44, 54, 119, 129, 199, 204, 214, 224, 244, 254, 319, 329, 399
	};
#else
    laplacianTYPE coordinates[totalLayers][numberOfNodes] = {0};
#endif
    #pragma HLS ARRAY_PARTITION variable=coordinates complete dim=1
    #pragma HLS ARRAY_PARTITION variable=coordinates complete dim=2

    laplacianTYPE weightedCoordinates[totalLayers][nWeightedCoordinates][numberOfNodes];
//  #pragma HLS ARRAY_PARTITION variable=weightedCoordinates complete dim=1
//	#pragma HLS ARRAY_PARTITION variable=weightedCoordinates complete dim=2
//	#pragma HLS ARRAY_PARTITION variable=weightedCoordinates complete dim=3

	// copy coordinates into weighted arrays. This part of code is for testing, presumably not synthesized
makeWeightedCoordLayerLoop:	for (indexTYPE layer=0; layer<totalLayers; layer++) {
		#pragma HLS UNROLL
makeWeightedCoordWeightLoop:		for (indexTYPE weightIndex=0; weightIndex<nWeightedCoordinates; weightIndex++) {
			#pragma HLS UNROLL
makeWeightedCoordNodeLoop:			for (indexTYPE nodeIndex=0; nodeIndex<numberOfNodes; nodeIndex++) {
				#pragma HLS UNROLL
				weightedCoordinates[layer][weightIndex][nodeIndex] = coordinates[layer][nodeIndex];
				if (weightIndex == 1) {
					weightedCoordinates[layer][weightIndex][nodeIndex] += coordinates[layer][nodeIndex]; // double it because central node is subtracted twice in Laplacian calculation
					weightedCoordinates[layer][weightIndex][nodeIndex] += -weightedCoordinates[layer][weightIndex][nodeIndex]; // negate it so we can use adder later
				}
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
