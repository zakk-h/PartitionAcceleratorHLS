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
// #include "ap_int.h"

// Namespaces
using namespace std;

// Import math keywords
#define _USE_MATH_DEFINES

// Global Constants
#define totalLayers 5 // Each layer corresponds to the set of hits detected by a single sensor
#define middleLayers 3
#define adjacentLayers 2
#define numberOfNodes 16 // Each node corresponds to a "hit" picked up by a sensor
#define adjacentNodes 16
#define acceptLink true 
#define rejectLink false
#define tripletBitWidth 20 // Each triplet corresponds to an i value (position of node in the above adjacent layer), 
							// j value (position of node in the below adjacent layer), and l value (laplacian)
#define coordinateBitWidth 12
#define nodeIndexBitWidth 4 // log_2(numberOfNodes)
#define upLink 0
#define downLink 1


int coordinates[5][16] = {{1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 12566}, \
                          {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 25132/2}, \
                          {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 37699/3}, \
                          {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 50265/4}, \
                          {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 62831/5}}; //16 corresponds to the number we are using in the project, thought it should really be equal to numberOfFragmentsPerTime

// MM is the global data structure that encodes the "accepted links" (most likely path taken by particle fragment between hits).
// We initialize MM such that all links are accept links

// TODO: I have all the links backward in the entire program, i.e. layer 1 links to layer 2 should be up, not down, and vice versa

// ensure that vivado keeps the default declaration values of a bool array to false

int random(int min, int max) {
   static bool first = true;
   if (first) {  
      srand( time(NULL) ); //seeding for the first time only!
      first = false;
   }
   return min + rand() % (( max + 1 ) - min);
}

void manuallyGenerateCoordinates(int layerRadii[5], double theta[16]) {
    for (int layer = 0; layer < 5; layer++) {
        for (int i = 0; i < 14; i++) {
            double segment = layerRadii[layer] * theta[i];
            int hit = (int) floor((segment*10e3)/25);
            coordinates[layer][i+1] = hit/(layer+1);
        }
    }
}

// 16 straight lines, 2 straight lines  on the edges, 2 straight lines in the middle, no straight lines, one slightly straight line (potentially think of more calibration sets)/curved line
// TODO: put in a straight line; the outermost edges of the hits (corresponding to the first pixel and last pixel on 
// every layer) are jagged across the layers. The straight line must be between these edges
// TODO: make visualization of MM matrix (can make separate program that parses the printout; can be written in python by taking in printout of this file)

void generateCoordinates(int layerRadii[5], int fragmentsPerCollision, int numberOfCollisionsPerTime, int timeBetweenCollisions, double pixelWidth, int numberOfSections) {
	for (int layer = 0; layer < 5; layer++) {
        int numberOfFragmentsPerTime = fragmentsPerCollision*numberOfCollisionsPerTime;
	    int fragmentsPerPart = (int) numberOfFragmentsPerTime/numberOfSections;
	    double circumferenceLayer = 2*layerRadii[layer]*M_PI;
	    double fragmentsDensityLayer = fragmentsPerPart/circumferenceLayer; // fragments per centimeter
	    double pixelDensity = 1/pixelWidth; // 1 is 1 cm
	    // this number doesnt correspond to 16 fragments like we have been using
	    double averageNumberOfPixelsPerParticle = pixelDensity/fragmentsDensityLayer; // e.g. every 10th pixel has a particle
	    int maxNumPixelsLayer = pixelDensity*circumferenceLayer;
        for (int i = 1; i < fragmentsPerCollision; i++) {
            // srand(time(0));
            int hit = random(1, maxNumPixelsLayer)/(layer+1); // note that 3500 is the true value of fragmentsPerCollision; we want to look at a slice with 16, not the whole circumference and say that that has 16; having a slice with only 16 is closer to reality
            // need to divide by layer number and then multply by 10; 
            // need to implement bias for when a particle is closer to one side or the other of a pixel
            coordinates[layer][i] = hit; // previously multiplied by pixelWidth to get and store physical distance in 1 dimension; can multiply*10000 is to go from cm to microns
        }


        int n = sizeof(coordinates[layer]) / sizeof(coordinates[layer][0]);
        sort(coordinates[layer], coordinates[layer] + n);
    }

	return;
}

/*
	Encodes (aboveNodeIndex, belowNodeIndex, Laplacian) as an integer with a 20 bit width
	@param aboveNodeIndex The index corresponding to a node in the layer above a particular node
	@param belowNodeIndex The index corresponding to a node in the layer below a particular node
	@param Laplacian The Laplacian value for the path represented by this particular triplet
	@return A 20 bit integer that stores the aboveNodeIndex, belowNodeIndex, and Laplacian value corresponding to a middleLayer node
*/
// Somewhere give a description why we chose 20 bits ... this is a serious potential chokepoint, because we are using int with 32 bits instead of ap_int<20> now.
int encode(int aboveNodeIndex, int belowNodeIndex, int Laplacian){
    return  (int) (((int) Laplacian )<<8) | ((int) aboveNodeIndex )  | (((int) belowNodeIndex )<<4);
}

// these decode functions are all potential chokepoints now that we have gone from 20 to 32 bits
/*
	Returns the Laplacian value given the 20 bit encoded triplet
	@param triplet A 20 bit integer that stores the aboveNodeIndex, belowNodeIndex, and Laplacian value corresponding to a middleLayer node
*/
int decodeLaplacian(int triplet){
    //#pragma HLS INLINE
    return (int) (triplet>>8);
}

/*
	Returns the aboveNodeIndex value given the 20 bit encoded triplet
	@param triplet A 20 bit integer that stores the aboveNodeIndex, belowNodeIndex, and Laplacian value corresponding to a middleLayer node
*/
int decodeAboveNodeIndex(int triplet){
    //#pragma HLS INLINE
    return  (int) triplet&15;
}

/*
	Returns the belowNodeIndex value given the 20 bit encoded triplet
	@param triplet A 20 bit integer that stores the aboveNodeIndex, belowNodeIndex, and Laplacian value corresponding to a middleLayer node
*/
int decodeBelowNodeIndex(int triplet){
    //#pragma HLS INLINE
    return  (int) ((triplet>>4) & 15);
}

/*
	Calculates the Laplacian values for all of the triplets associated with a single node and stores each 20 bit triplet
	in triplet[numberOfNodes][numberOfNodes]
	@param aboveNodeList The list of nodes in the layer above the current node
	@param belowNodeList The list of nodes in the layer below the current node
	@param nodeTriplets A submatrix of tripletMatrix corresponding to a single node that stores all of the triplets
						associated with that node
	@param nodeTripletsTranspose A submatrix of tripletMatrixTranspose corresponding to a single node that stores all of the triplets
						associated with that node
	@param laplacianWeight The w_(ijk,l) number that weights the Laplacians in the trackTrigger.pdf paper
	@param inputNode The coordiantes of the node that we are generating the triplets for
*/
// might need to change indexing...since 1 and the last index are right next to each other, but thats not being represented
void singleNodeLaplacianCalculator(int aboveNodeList[adjacentNodes], int belowNodeList[adjacentNodes], int nodeTriplets[adjacentNodes][adjacentNodes], int nodeTripletsTranspose[adjacentNodes][adjacentNodes], int laplacianWeight, int laplacianWeight2, int inputNode) {
	//#pragma HLS unroll

	// should pass in angles that correspond to each pixel, NOT THE PIXEL VALUE
	// layer 1 pixel entries should be divided by 1, layer 2 by 2, and so on
	// converts each pixel value to the angles
		
	// TODO: define laplacian weight as array of two; the first weight is currently 1, and the second weight is currently 2; these are just approximations (these are reflections of the geometry )
	// When we run singleNodeLaplacianCalculator on the transpose matrix, aboveNodeLoop actually runs through the below nodes
	aboveNodeLoop: for(int aboveNodeIndex=0; aboveNodeIndex<adjacentNodes; aboveNodeIndex++) {
		//#pragma HLS unroll
		int c1pos3 = laplacianWeight*aboveNodeList[aboveNodeIndex];
		// When we run singleNodeLaplacianCalculator on the transpose matrix, belowNodeLoop actually runs through the above nodes
		belowNodeLoop: for(int belowNodeIndex=0; belowNodeIndex<adjacentNodes; belowNodeIndex++) {
			//#pragma HLS unroll
			// calculate the Laplacian
			int laplacian = abs(c1pos3 + belowNodeList[belowNodeIndex] - laplacianWeight2*inputNode); 
			// Encode the node indices and Laplacian into a 20 bit integer that represents the triplet
			cout << aboveNodeIndex << " " << belowNodeIndex << " " << laplacian << "\n";
			int triplet = encode(aboveNodeIndex, belowNodeIndex, laplacian);
			cout << decodeAboveNodeIndex(triplet) << " " << decodeBelowNodeIndex(triplet) << " " << decodeLaplacian(triplet) << "\n";
            //std::cout<<std::bitset<32>(triplet)<<std::endl;
			// Store the triplet in the corresponding array position
			nodeTriplets[aboveNodeIndex][belowNodeIndex] = triplet;
			nodeTripletsTranspose[belowNodeIndex][aboveNodeIndex] = triplet;
		}
	}
    return;
}

template<class index_t, class array_t>
void exchange(array_t a[], index_t i, index_t j) {
   //#pragma HLS INLINE
    array_t t = a[i];
    a[i] = a[j];
    a[j] = t;
}

//Bitonic sort from existing codes
//Description TBD
template<class array_t, class index_t, class mask_t> // TODO: Try to understand why this piece of code works (with masters thesis)
void elementLoop(array_t a[], index_t j, mask_t mask) {
    //#pragma HLS INLINE
    LOOP_OVER_ELEMENTS: for (int i=0; i<mask; i++) { 
        int ij=i^j;
        if ((ij)>i) {
            if ((i&mask)==0 && decodeLaplacian(a[i]) > decodeLaplacian(a[ij])){
                exchange(a,i,ij);
            } else if ((i&mask)!=0 && decodeLaplacian(a[i]) < decodeLaplacian(a[ij])){
                exchange(a,i,ij);
            }
        }
    }
}

/*
	Modifies an array of length pow(2, power) such that the smallest value of the array is put in its 0th index
	@param array[(int)pow(2, power)] The array to be sorted
	@param power The power of two that determines how many elements are the the array
*/
template<class T>
void MinFinder(T array[], int power){ //TODO: ask why decode is used for the comparisons in MinFinder but not in MSS; if decoding is necessary it needs to be done everywhere, if not, it needs to be done nowhere
	//#pragma HLS PIPELINE II=10
    //#pragma HLS ARRAY_PARTITION variable=arr complete
    
	for (int i=0; i<power; i++) {
		for (int j=(int)pow(2, i); j>0; j=j>>1) {
        	elementLoop(array, j, (int)pow(2, (i+1)));
		}
	}
    if(decodeLaplacian(array[0])>decodeLaplacian(array[(int)pow(2, power)])){ 
    	exchange(array, 0, (int)pow(2, power - 1));
    }
}

template<class T>
void Max(T array[], int power){
   //#pragma HLS INLINE
    for(int i=0; i<(int)pow(2, power); i++){
        //#pragma HLS unroll
        int j = i+(int)pow(2, power);
        if(decodeLaplacian(array[i])<decodeLaplacian(array[j])){
            exchange(array, i, j);
        }
    }
}

/*
	Given an array of length pow(2, power), put the pow(2, power)/2 greatest elements in the last pow(2, power)/2 slots
	in the array
	@param array[(int)pow(2, power)] The array to be sorted
	@param power The power of two that determines how many elements are the the array
*/
template<class T>
void MSS(T array[], int power) {
    //#pragma HLS PIPELINE II=10
    //#pragma HLS ARRAY_PARTITION variable=work_array complete

	for (int i=0; i<power; i++) {
		for (int j = (int)pow(2, i); j>0; j=j>>1) {
        	elementLoop(array, j, (int)pow(2, (i+1)));
		}
	}
    Max(array, power-1);
}

/*
	Sets both links corresponding to a single triplet to rejectLink in MM
	@param tripletMatrixMaximum A triplet with a Laplacian value larger than the first half of triplets in laplacianMinimums
								after it is sorted by MSS
    @param nodeIndex The index of the node in the layer that the triplet corresponds to
*/
void updateUpLink(int tripletMatrixMaximum, bool MM[middleLayers][numberOfNodes][adjacentLayers][numberOfNodes], int nodeIndex, int middleLayer) { 
	int aboveNodeIndex = decodeAboveNodeIndex(tripletMatrixMaximum); 
	MM[middleLayer][nodeIndex][0][aboveNodeIndex] = acceptLink;

}

void updateDownLink(int tripletMatrixMaximumTranspose, bool MM[middleLayers][numberOfNodes][adjacentLayers][numberOfNodes], int nodeIndex, int middleLayer) { 
	int belowNodeIndex = decodeBelowNodeIndex(tripletMatrixMaximumTranspose);
	MM[middleLayer][nodeIndex][1][belowNodeIndex] = acceptLink;
}

/*
	Given the MM global data structure, run the consensus algorithm between up links and down links:
		Between two nodes there is an up link and down link. Set the value of both links to the AND of
		the two links
	@Param MM The global data structure that encodes the "accepted links" (most likely path taken by a particle fragment between hits)
*/
void pruneGlobalMatrix(bool MM[middleLayers][numberOfNodes][adjacentLayers][numberOfNodes]){
	//#pragma HLS array_partition variable=MM complete dim=0
    // compare middlelayer 0 and 1, then 1 and 2
	for(int middleLayer=0; middleLayer<middleLayers-1; middleLayer++) {
		//#pragma HLS unroll
		for(int nodeIndex=0; nodeIndex<numberOfNodes; nodeIndex++) {
			//#pragma HLS unroll
			for(int correspondingNodeIndex=0; correspondingNodeIndex<numberOfNodes; correspondingNodeIndex++) {
				//#pragma HLS unroll
				int aboveLayerIndex = 0;
				int belowLayerIndex = 1;
                // the middleLayer+1 code will have to change to account for the fact that there are no end layers anymore
				bool linkState = MM[middleLayer+1][correspondingNodeIndex][belowLayerIndex][nodeIndex] && MM[middleLayer][nodeIndex][aboveLayerIndex][correspondingNodeIndex];
				MM[middleLayer][nodeIndex][aboveLayerIndex][correspondingNodeIndex] = linkState;
				MM[middleLayer+1][correspondingNodeIndex][belowLayerIndex][nodeIndex] = linkState;
			}
		}
	}
}

/*
	fullSystem: Determines the most likely paths taken by particle fragments resulting from a collision in the Large Hadron Collider
	@param nodeCoordinates A totalLayers x numberOfNodes Matrix that contains the physical coordinate points for each hit
	@param laplacianWeight Any value between 0.5 and 2 TODO: This value should be different per layer...so could be implemented as an array (of four)...this value scales to account for the distances between layers
	@param c1-c4 Necessary for Vivado synthesis
	@param ans Necessary for Vivado synthesis
*/
// We need coordinateBitWidth bit precision for the coordinates; the algebra done to get the Laplacian value (a coordinateBitWidth bit number) must be done with all coordinateBitWidth bit numbers
void fullSystem(const int nodeCoordinates[totalLayers][numberOfNodes], bool MM[middleLayers][numberOfNodes][adjacentLayers][numberOfNodes], int laplacianWeight, int laplacianWeight2) {
	
	
	cout << "{" << "\n";
	//#pragma HLS array_partition variable=MM complete dim=0
	for(int layer=0; layer<middleLayers; layer++) {
		//#pragma HLS unroll
		cout << "layer" << layer+1 << " {" << "\n";
		for(int nodeIndex=0; nodeIndex<numberOfNodes; nodeIndex++) {
			cout << "node" << nodeIndex+1 << " {";
			//#pragma HLS unroll
			for(int correspondingNodeIndex=0; correspondingNodeIndex<numberOfNodes; correspondingNodeIndex++) {
				//#pragma HLS unroll
				int aboveLayerIndex = 0;
				int belowLayerIndex = 1;
				MM[layer][nodeIndex][aboveLayerIndex][correspondingNodeIndex] = 0;
				MM[layer][nodeIndex][belowLayerIndex][correspondingNodeIndex] = 0;

				cout << MM[layer][nodeIndex][aboveLayerIndex][correspondingNodeIndex] << MM[layer][nodeIndex][belowLayerIndex][correspondingNodeIndex] << " ";
			}
			cout << "}" << "\n";
			}
		cout << "}" << "\n";
	}
	cout << "}" << "\n";

	// tripletMatrix contains the set of all possible triplets per node
	int tripletMatrix[middleLayers][numberOfNodes][adjacentNodes][adjacentNodes]; 
    
	// When tripletMatrixTranspose is declared, the submatrices corresponding to each node is the transpose of the 
	// analogous submatrix in tripletMatrix. However, this property is not an invariant, and is broken when MinFinder is run
	int tripletMatrixTranspose[middleLayers][numberOfNodes][adjacentNodes][adjacentNodes];

	// Loop through only the middle layers because the uppermost and lowermost layers are not associated with triplets
	middleLayerLoop1: for (int middleLayer=0; middleLayer<middleLayers; middleLayer++) {
		// Each layer runs in parallel
		//#pragma HLS unroll
		nodeLoop1: for(int nodeIndex=0; nodeIndex<numberOfNodes; nodeIndex++) {

			// Each node in each layer runs in parallel
			//#pragma HLS unroll

			// Recognize the indexing discrepency between nodeCoordinates (which contains all 5 layers) and tripletMatrix 
			// which contains only the middle layers. aboveLayer and belowLayer are initialized to account for this 
			// discrepency in the singleNodeLaplacianCalculator call
			int aboveLayer = middleLayer+2;
			int belowLayer = middleLayer;

			// TODO: need to switch any of these methods to pass-by-reference?
			singleNodeLaplacianCalculator((int*) nodeCoordinates[aboveLayer], (int*) nodeCoordinates[belowLayer], \
											tripletMatrix[middleLayer][nodeIndex], tripletMatrixTranspose[middleLayer][nodeIndex], laplacianWeight, laplacianWeight2, \
											nodeCoordinates[middleLayer+1][nodeIndex]);
			

			// Store triplets associated with a single node and all of its adjacent nodes (either above nodes or below nodes   
			// depending on if we are using the Transpose or not); the first triplet in the list is the triplet with the 
			// smallest Laplacian value
			int laplacianMinimums[adjacentNodes];
			int laplacianMinimumsTranspose[adjacentNodes];

			// power denotes numberOfLinksRemainingInAdjacentLayersPerNode = pow(2, power)
			int power = 4;

			int tripletMatrixCopy[middleLayers][numberOfNodes][adjacentNodes][adjacentNodes]; 
			memcpy(tripletMatrixCopy, tripletMatrix, middleLayers*numberOfNodes*adjacentNodes*adjacentNodes*sizeof(int));
			int tripletMatrixTransposeCopy[middleLayers][numberOfNodes][adjacentNodes][adjacentNodes];
			memcpy(tripletMatrixTransposeCopy, tripletMatrixTranspose, middleLayers*numberOfNodes*adjacentNodes*adjacentNodes*sizeof(int));

			// Store the triplets with the smallest Laplacian values per adjacent node to nodeIndex in laplacianMinimums (above)
			// or laplacianMinimumsTranspose (below)
			for (int adjacentNodeIndex=0; adjacentNodeIndex<adjacentNodes; adjacentNodeIndex++) {
				// Each MinFinder for each adjacent node runs in parallel
				//#pragma HLS unroll

				MinFinder(tripletMatrixCopy[middleLayer][nodeIndex][adjacentNodeIndex], power);
				MinFinder(tripletMatrixTransposeCopy[middleLayer][nodeIndex][adjacentNodeIndex], power);

				laplacianMinimums[adjacentNodeIndex] = tripletMatrixCopy[middleLayer][nodeIndex][adjacentNodeIndex][0];
				laplacianMinimumsTranspose[adjacentNodeIndex] = tripletMatrixTransposeCopy[middleLayer][nodeIndex][adjacentNodeIndex][0];
                // TODO FOR LATER: Technically should be able to compare without decoding; but 1. this is not the case if the laplacian value can be negative, and 2. need to make sure that the ij values are maintained
			}

			

            // TODO: see if we can pass in the triplets and do comparisons on the triplets (not the laplacians) for MSS and Minfinder
			MSS(laplacianMinimums, power);
			MSS(laplacianMinimumsTranspose, power);

            
			// Reject the links corresponding to the largest half of the triplet stored in the Minimums lists
			for (int largestLaplacianIndex=numberOfNodes/2; largestLaplacianIndex<numberOfNodes; largestLaplacianIndex++) {
				// Updating all the links runs in parallel
				//#pragma HLS unroll
                
				updateUpLink(laplacianMinimums[largestLaplacianIndex], MM, nodeIndex, middleLayer);
				updateDownLink(laplacianMinimumsTranspose[largestLaplacianIndex], MM, nodeIndex, middleLayer);
			}
            cout << "{" << "\n";
            //#pragma HLS array_partition variable=MM complete dim=0
            for(int layer=0; layer<middleLayers; layer++) {
                //#pragma HLS unroll
                cout << "layer" << layer+1 << " {" << "\n";
                for(int nodeIndex=0; nodeIndex<numberOfNodes; nodeIndex++) {
                    cout << "node" << nodeIndex+1 << " {";
                    //#pragma HLS unroll
                    for(int correspondingNodeIndex=0; correspondingNodeIndex<numberOfNodes; correspondingNodeIndex++) {
                        //#pragma HLS unroll
                        int aboveLayerIndex = 0;
                        int belowLayerIndex = 1;
                        cout << MM[layer][nodeIndex][aboveLayerIndex][correspondingNodeIndex] << MM[layer][nodeIndex][belowLayerIndex][correspondingNodeIndex] << " ";
                    }
                    cout << "}" << "\n";
                }
                cout << "}" << "\n";
            }
            cout << "}" << "\n";
		}
	}

    cout << "{" << "\n";
	//#pragma HLS array_partition variable=MM complete dim=0
	for(int layer=0; layer<middleLayers; layer++) {
		//#pragma HLS unroll
        cout << "layer" << layer+1 << " {" << "\n";
		for(int nodeIndex=0; nodeIndex<numberOfNodes; nodeIndex++) {
            cout << "node" << nodeIndex+1 << " {";
			//#pragma HLS unroll
			for(int correspondingNodeIndex=0; correspondingNodeIndex<numberOfNodes; correspondingNodeIndex++) {
				//#pragma HLS unroll
				int aboveLayerIndex = 0;
				int belowLayerIndex = 1;
                cout << MM[layer][nodeIndex][aboveLayerIndex][correspondingNodeIndex] << MM[layer][nodeIndex][belowLayerIndex][correspondingNodeIndex] << " ";
			}
            cout << "}" << "\n";
		}
        cout << "}" << "\n";
	}
    cout << "}" << "\n";

	// Run consensus protocol
	pruneGlobalMatrix(MM);
    cout << "{" << "\n";
	//#pragma HLS array_partition variable=MM complete dim=0
	for(int layer=0; layer<middleLayers; layer++) {
		//#pragma HLS unroll
        cout << "layer" << layer+1 << " {" << "\n";
		for(int nodeIndex=0; nodeIndex<numberOfNodes; nodeIndex++) {
            cout << "node" << nodeIndex+1 << " {";
			//#pragma HLS unroll
			for(int correspondingNodeIndex=0; correspondingNodeIndex<numberOfNodes; correspondingNodeIndex++) {
				//#pragma HLS unroll
				int aboveLayerIndex = 0;
				int belowLayerIndex = 1;
                cout << MM[layer][nodeIndex][aboveLayerIndex][correspondingNodeIndex] << MM[layer][nodeIndex][belowLayerIndex][correspondingNodeIndex] << " ";
			}
            cout << "}" << "\n";
		}
        cout << "}" << "\n";
	}
    cout << "}" << "\n";
	cout << "hello" << "\n";

	// Repeat the process above, cutting the number of triplets per node in half until there is only a single triplet
	// associated with each node

    // the indices for laplacian minimums and adjacentNodeIndex are problematic because they should all decrease to 1
    // need to implement tripletsPrime

	powerLoop: for (int power=3; power>=1; power--) {
        cout << "hello world" << "\n";
        // intialize tripletmatrix1 with max/dummy values for laplacian and dummy ij values 00;
        // after pruneglobalmatrix; Iterate through MM, if the link is accept, build a triplet and overwrite the corresponding 
        // tripletMatrix element

        // dummy idea didn't work, can't intialize array of a variable length, can only declare it

        //TODO: update comments
        // tripletMatrix contains the set of all possible triplets per node
        int tripletMatrixPruned[middleLayers][numberOfNodes][(int)pow(2, power)][(int)pow(2, power)];
        int tripletMatrixPrunedTranspose[middleLayers][numberOfNodes][(int)pow(2, power)][(int)pow(2, power)];

		for (int j=0; j < middleLayers; j++) {
			for (int nodeIndex = 0; nodeIndex < 16; nodeIndex++) {
				for (int i =0; i <(int)pow(2, power); i++) {
					for (int belowNodeIterator = 0; belowNodeIterator < (int)pow(2, power); belowNodeIterator++) {
                        tripletMatrixPruned[j][nodeIndex][i][belowNodeIterator] = encode(0, 0, 999999);
                        // cout << std::bitset<32>(tripletMatrixPruned[middleLayer][nodeIndex][aboveNodeIterator][belowNodeIterator]) << "\n";
                        tripletMatrixPrunedTranspose[j][nodeIndex][belowNodeIterator][i] = encode(0, 0, 999999);
					}
				}
			}
		}

		cout << "{" << "\n";
		//#pragma HLS array_partition variable=MM complete dim=0
		for(int layer=0; layer<middleLayers; layer++) {
			//#pragma HLS unroll
			cout << "layer" << layer+1 << " {" << "\n";
			for(int nodeIndex=0; nodeIndex<numberOfNodes; nodeIndex++) {
				cout << "node" << nodeIndex+1 << " {";
				//#pragma HLS unroll
				for(int correspondingNodeIndex=0; correspondingNodeIndex<numberOfNodes; correspondingNodeIndex++) {
					//#pragma HLS unroll
					int aboveLayerIndex = 0;
					int belowLayerIndex = 1;

					cout << MM[layer][nodeIndex][aboveLayerIndex][correspondingNodeIndex] << MM[layer][nodeIndex][belowLayerIndex][correspondingNodeIndex] << " ";
				}
				cout << "}" << "\n";
			}
			cout << "}" << "\n";
		}
		cout << "}" << "\n";

        // its not clear that we can even use MM to create tripletMatrixPruned
        for(int middleLayer=0; middleLayer<middleLayers; middleLayer++) {
		    //#pragma HLS unroll
            for(int nodeIndex=0; nodeIndex<numberOfNodes; nodeIndex++) {
                //#pragma HLS unroll
                int aboveNodeIterator = 0;
                for(int aboveNodeIndex=0; aboveNodeIndex<numberOfNodes; aboveNodeIndex++) {
                    bool ifStatementTriggered = false;
                    int belowNodeIterator = 0;
                    for(int belowNodeIndex=0; belowNodeIndex<numberOfNodes; belowNodeIndex++) {
                        int aboveLayerIndex = 0;
                        int belowLayerIndex = 1;
                        // cout << aboveNodeIterator << "\n";
                        // The other way to fill in the dummy values would be to check if belowNodeIndex == numberOfNodes - 1, and for (i = 2^power - belowNodeIterator), fill in the remainder of the tripletMatrix values as dummy
                        
                        // going to need to go through the MM outputted by pruneGlobalMatrix and actually trace through and ensure that there are only 8 x 8 triplets per node and fix above/belowNodeIterator accordingly
                        if (MM[middleLayer][nodeIndex][belowLayerIndex][belowNodeIndex] == acceptLink && MM[middleLayer][nodeIndex][aboveLayerIndex][aboveNodeIndex] == acceptLink) {
                            ifStatementTriggered = true;
                            // if this if was executed, at least once, then abovenodeiterator++ on the next abovenodeindex increas
                            tripletMatrixPruned[middleLayer][nodeIndex][aboveNodeIterator][belowNodeIterator] = tripletMatrix[middleLayer][nodeIndex][aboveNodeIndex][belowNodeIndex];
                            tripletMatrixPrunedTranspose[middleLayer][nodeIndex][belowNodeIterator][aboveNodeIterator] = tripletMatrixTranspose[middleLayer][nodeIndex][belowNodeIndex][aboveNodeIndex];
                            // cout << std::bitset<32>(tripletMatrixPruned[middleLayer][nodeIndex][aboveNodeIterator][belowNodeIterator]) << "\n";
                            belowNodeIterator++;
                        } // going to have to separately load these and mathematically determine when to 
                    }
                    if (ifStatementTriggered) {
                        aboveNodeIterator++;
                    }
                }
            }
            //cout << "hello" << "\n";
	    }
        //cout << "hello" << "\n";
		
		cout << "{" << "\n";
		for (int j=0; j < middleLayers; j++) {
			for (int nodeIndex = 0; nodeIndex < 16; nodeIndex++) {
				for (int i =0; i <(int)pow(2, power); i++) {
					for (int belowNodeIterator = 0; belowNodeIterator < (int)pow(2, power); belowNodeIterator++) {

						cout << "tripletMatrixPruned[" << j << "][" << nodeIndex << "][" << i << "][" << belowNodeIterator << "]: " << decodeAboveNodeIndex(tripletMatrixPruned[j][nodeIndex][i][belowNodeIterator]) << " " << decodeBelowNodeIndex(tripletMatrixPruned[j][nodeIndex][i][belowNodeIterator]) << " " << decodeLaplacian(tripletMatrixPruned[j][nodeIndex][i][belowNodeIterator]) << "\n";
					}
				}
			}
		}
		cout << "}" << "\n";

		int tripletMatrixCopy[middleLayers][numberOfNodes][(int)pow(2, power)][(int)pow(2, power)]; 
		memcpy(tripletMatrixCopy, tripletMatrixPruned, middleLayers*numberOfNodes*(int)pow(2, power)*(int)pow(2, power)*sizeof(int));
		int tripletMatrixTransposeCopy[middleLayers][numberOfNodes][(int)pow(2, power)][(int)pow(2, power)];
		memcpy(tripletMatrixTransposeCopy, tripletMatrixPrunedTranspose, middleLayers*numberOfNodes*(int)pow(2, power)*(int)pow(2, power)*sizeof(int));

		cout << "{" << "\n";
		//#pragma HLS array_partition variable=MM complete dim=0
		for(int layer=0; layer<middleLayers; layer++) {
			//#pragma HLS unroll
			cout << "layer" << layer+1 << " {" << "\n";
			for(int nodeIndex=0; nodeIndex<numberOfNodes; nodeIndex++) {
				cout << "node" << nodeIndex+1 << " {";
				//#pragma HLS unroll
				for(int correspondingNodeIndex=0; correspondingNodeIndex<numberOfNodes; correspondingNodeIndex++) {
					//#pragma HLS unroll
					int aboveLayerIndex = 0;
					int belowLayerIndex = 1;
					MM[layer][nodeIndex][aboveLayerIndex][correspondingNodeIndex] = 0;
					MM[layer][nodeIndex][belowLayerIndex][correspondingNodeIndex] = 0;

					cout << MM[layer][nodeIndex][aboveLayerIndex][correspondingNodeIndex] << MM[layer][nodeIndex][belowLayerIndex][correspondingNodeIndex] << " ";
				}
				cout << "}" << "\n";
				}
			cout << "}" << "\n";
		}
		cout << "}" << "\n";

		cout << "{" << "\n";
		//#pragma HLS array_partition variable=MM complete dim=0
		for(int layer=0; layer<middleLayers; layer++) {
			//#pragma HLS unroll
			cout << "layer" << layer+1 << " {" << "\n";
			for(int nodeIndex=0; nodeIndex<numberOfNodes; nodeIndex++) {
				cout << "node" << nodeIndex+1 << " {";
				//#pragma HLS unroll
				for(int correspondingNodeIndex=0; correspondingNodeIndex<numberOfNodes; correspondingNodeIndex++) {
					//#pragma HLS unroll
					int aboveLayerIndex = 0;
					int belowLayerIndex = 1;
					MM[layer][nodeIndex][aboveLayerIndex][correspondingNodeIndex] = 0;
					MM[layer][nodeIndex][belowLayerIndex][correspondingNodeIndex] = 0;

					cout << MM[layer][nodeIndex][aboveLayerIndex][correspondingNodeIndex] << MM[layer][nodeIndex][belowLayerIndex][correspondingNodeIndex] << " ";
				}
				cout << "}" << "\n";
			}
			cout << "}" << "\n";
		}
		cout << "}" << "\n";

		for (int middleLayer=0; middleLayer<middleLayers; middleLayer++) {
			//#pragma HLS unroll
			for (int nodeIndex=0; nodeIndex<numberOfNodes; nodeIndex++) {
				//#pragma HLS unroll
                
                //TODO: explain this for expressiveness
				int laplacianMinimums[(int)pow(2, power)];
				int laplacianMinimumsTranspose[(int)pow(2, power)];

				for (int adjacentNodeIndex=0; adjacentNodeIndex<(int)pow(2, power); adjacentNodeIndex++) { // adjacentNodeIndex can depend on power once the above laplacianPrime matrix code is implemented.
                    
					//#pragma HLS unroll
					// A lot of this code is repeated from above due to the fact that we haven't implemented laplacianPrime.
					// Once we implement laplacianPrime, we can just go over links that are remaining in MM at each stage.
					MinFinder(tripletMatrixCopy[middleLayer][nodeIndex][adjacentNodeIndex], power);
					MinFinder(tripletMatrixTransposeCopy[middleLayer][nodeIndex][adjacentNodeIndex], power);
                    // Need to assign TRIPLETS not laplacians here...but should modify MSS to do comparisons on the laplacians, not the triplets.
					laplacianMinimums[adjacentNodeIndex] = tripletMatrixCopy[middleLayer][nodeIndex][adjacentNodeIndex][0];
					laplacianMinimumsTranspose[adjacentNodeIndex] = tripletMatrixTransposeCopy[middleLayer][nodeIndex][adjacentNodeIndex][0];
				}

				cout << "laplacianMinimums before MSS" << "\n";
				for (int i = 0; i < sizeof(laplacianMinimums)/sizeof(laplacianMinimums[0]); i++) {
					cout << "laplacianMinimums[i]: " << decodeAboveNodeIndex(laplacianMinimums[i]) << " " << decodeBelowNodeIndex(laplacianMinimums[i]) << " " << decodeLaplacian(laplacianMinimums[i]) << "\n";
					cout << "laplacianMinimumsTranspose[i]: " << decodeAboveNodeIndex(laplacianMinimumsTranspose[i]) << " " << decodeBelowNodeIndex(laplacianMinimumsTranspose[i]) << " " << decodeLaplacian(laplacianMinimumsTranspose[i]) << "\n";
				} 

				MSS(laplacianMinimums, power);
				MSS(laplacianMinimumsTranspose, power);

				cout << "laplacianMinimums after MSS" << "\n";
				for (int i = 0; i < sizeof(laplacianMinimums)/sizeof(laplacianMinimums[0]); i++) {
					cout << "laplacianMinimums[i]: " << decodeAboveNodeIndex(laplacianMinimums[i]) << " " << decodeBelowNodeIndex(laplacianMinimums[i]) << " " << decodeLaplacian(laplacianMinimums[i]) << "\n";
					cout << "laplacianMinimumsTranspose[i]: " << decodeAboveNodeIndex(laplacianMinimumsTranspose[i]) << " " << decodeBelowNodeIndex(laplacianMinimumsTranspose[i]) << " " << decodeLaplacian(laplacianMinimumsTranspose[i]) << "\n";
				} 
				
				// Reject the links corresponding to the largest half of the triplet stored in the Minimums lists
				for (int largestTripletIndex=(int)(pow(2, power)/2); largestTripletIndex<(int)(pow(2, power)); largestTripletIndex++) {
					// Updating all the links runs in parallel
					//#pragma HLS unroll
					updateUpLink(laplacianMinimums[largestTripletIndex], MM, nodeIndex, middleLayer);
					updateDownLink(laplacianMinimumsTranspose[largestTripletIndex], MM, nodeIndex, middleLayer);
				}
			}
		}
		cout << "{" << "\n";
		//#pragma HLS array_partition variable=MM complete dim=0
		for(int layer=0; layer<middleLayers; layer++) {
			//#pragma HLS unroll
			cout << "layer" << layer+1 << " {" << "\n";
			for(int nodeIndex=0; nodeIndex<numberOfNodes; nodeIndex++) {
				cout << "node" << nodeIndex+1 << " {";
				//#pragma HLS unroll
				for(int correspondingNodeIndex=0; correspondingNodeIndex<numberOfNodes; correspondingNodeIndex++) {
					//#pragma HLS unroll
					int aboveLayerIndex = 0;
					int belowLayerIndex = 1;

					cout << MM[layer][nodeIndex][aboveLayerIndex][correspondingNodeIndex] << MM[layer][nodeIndex][belowLayerIndex][correspondingNodeIndex] << " ";
				}
				cout << "}" << "\n";
			}
			cout << "}" << "\n";
		}
		cout << "}" << "\n";
		// Run consensus protocol
		pruneGlobalMatrix(MM); // what is the purpose of running prune global matrix when we are setting it equal to zero?
		for(int layer=0; layer<middleLayers; layer++) {
			//#pragma HLS unroll
			cout << "layer" << layer+1 << " {" << "\n";
			for(int nodeIndex=0; nodeIndex<numberOfNodes; nodeIndex++) {
				cout << "node" << nodeIndex+1 << " {";
				//#pragma HLS unroll
				for(int correspondingNodeIndex=0; correspondingNodeIndex<numberOfNodes; correspondingNodeIndex++) {
					//#pragma HLS unroll
					int aboveLayerIndex = 0;
					int belowLayerIndex = 1;

					cout << MM[layer][nodeIndex][aboveLayerIndex][correspondingNodeIndex] << MM[layer][nodeIndex][belowLayerIndex][correspondingNodeIndex] << " ";
				}
				cout << "}" << "\n";
			}
			cout << "}" << "\n";
		}
		cout << "}" << "\n";
		
	}	
	// Variable input ensures synthesis is performed for all nodes
    // TODO: add this line back in 
	// *ans = tripletMatrix[c1][c2][c3][c4]; 

	// this printout is referring to the wrong MM (refers to MM declared at the top of fullysystem, whereas we have redefined MM multiple times in the power loop)
    cout << "{" << "\n";
	//#pragma HLS array_partition variable=MM complete dim=0
	for(int layer=0; layer<middleLayers; layer++) {
		//#pragma HLS unroll
        cout << "layer" << layer+1 << " {" << "\n";
		for(int nodeIndex=0; nodeIndex<numberOfNodes; nodeIndex++) {
            cout << "node" << nodeIndex+1 << " {";
			//#pragma HLS unroll
			for(int correspondingNodeIndex=0; correspondingNodeIndex<numberOfNodes; correspondingNodeIndex++) {
				//#pragma HLS unroll
				int aboveLayerIndex = 0;
				int belowLayerIndex = 1;
                cout << MM[layer][nodeIndex][aboveLayerIndex][correspondingNodeIndex] << MM[layer][nodeIndex][belowLayerIndex][correspondingNodeIndex] << " ";
			}
            cout << "}" << "\n";
		}
        cout << "}" << "\n";
	}
    cout << "}" << "\n";
	return;
}

int main() {
    
    int layerRadii[5] = {5, 10, 15, 20, 25}; // in centimeters
    double theta[14] = {1.5, 1.7, 1.9, 2.1, 2.3, 2.5, 2.7, 2.9, 3.1, 3.3, 3.5, 3.7, 3.9, 5}; // we'll say for now that the 16 are not within a slice, but within the whole cylinder.
    int fragmentsPerCollision = 15;
    int numberOfCollisionsPerTime = 1;
    int timeBetweenCollisions = 25; // in nanoseconds
    double pixelWidth = 0.0025; // in cm
    int numberOfSections = 1;
    generateCoordinates(layerRadii, fragmentsPerCollision, numberOfCollisionsPerTime, timeBetweenCollisions, pixelWidth, numberOfSections);
    // manuallyGenerateCoordinates(layerRadii, theta);

    cout << "{ \n";
    for (int layer = 0; layer < totalLayers; layer++) {
        cout << "{";
        for (int hit = 0; hit < numberOfNodes; hit++) {
            cout << coordinates[layer][hit] << ", ";
        }
        cout << "} \n";
    }
    cout << "}";


    int laplacianWeight = 1;
	int laplacianWeight2 = 2;
	bool MM[middleLayers][numberOfNodes][adjacentLayers][numberOfNodes];
	
    fullSystem(coordinates, MM, laplacianWeight, laplacianWeight2);    
    return 0;
}