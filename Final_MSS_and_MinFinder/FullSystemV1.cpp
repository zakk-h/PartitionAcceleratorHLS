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
#define adjacentLayers 2 // Each middle layer has 2 adjacent layers
#define numberOfNodes 16 // Each node corresponds to a "hit" picked up by a sensor; we assume that each layer has 16 hits for the sake of this project
#define adjacentNodes 16 // Each middle layer node has 16 adjacent nodes above and below
#define acceptLink true 
#define rejectLink false
#define tripletBitWidth 20  // Each triplet corresponds to an "i" value (position of node in the above adjacent layer), 
							// a "j" value (position of node in the below adjacent layer), and am "l" value (the discrete 
							// Laplacian corresponding to this node, the i value, and the j value)
#define nodeIndexBitWidth 4 // log_2(numberOfNodes)
#define upLink 0
#define downLink 1

int coordinates[totalLayers][numberOfNodes] = {{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, \
                          {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, \
                          {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, \
                          {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, \
                          {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}}; 

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
	@param numberOfCollisionsPerTime The number of collisions every timeBetweenCollisions nanoseconds
	@param timeBetweenCollisions The nanoseconds between collisions
	@param pixelWidth The micron width of each pixel in one dimension
	@param numberOfSections The number of sections that the sensor is split into (x sections --> x - 1 vertical planes perpendicar to the z axis)
	@param outcome Calibrates generateCoordinates for a particular collision outcome: 0 for one curved path, 1 for two curved paths, 2 for no curved paths 
    @param curveRadius The radius of curvature corresponding to the equation p = 0.3 Br
*/

void generateCoordinates(int layerRadii[totalLayers], double theta[numberOfNodes], int fragmentsPerCollision, int numberOfCollisionsPerTime, int timeBetweenCollisions, double pixelWidth, int numberOfSections, int outcome, int curveRadius) {
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
            coordinates[layer][5] = curvedLine1 + sign*(int)(10000/25)*((double)curveRadius - abs(((double)curveRadius)*cos(curveTheta))); 
            curvedLine1 = coordinates[layer][5];
            CurvedFile <<  curvedLine1 << "\n";
		} else if (outcome == 1) {
            coordinates[layer][5] = curvedLine1 + sign*(int)(10000/25)*((double)curveRadius - abs(((double)curveRadius)*cos(curveTheta)));  // TODO: make +- random for curvedLine1 +-
            curvedLine1 = coordinates[layer][5];
			coordinates[layer][12] = curvedLine2 - sign*(int)(10000/25)*((double)curveRadius - abs(((double)curveRadius)*cos(curveTheta))); 
            curvedLine2 = coordinates[layer][12];
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
int encode(int aboveNodeIndex, int belowNodeIndex, int Laplacian){
    return  (int) (((int) Laplacian )<<8) | ((int) aboveNodeIndex )  | (((int) belowNodeIndex )<<4);
}

/*
	Returns the Laplacian value given the bit encoded triplet
	@param triplet An integer that stores the aboveNodeIndex, belowNodeIndex, and Laplacian value corresponding to a middleLayer node
*/
int decodeLaplacian(int triplet){
    //#pragma HLS INLINE
    return (int) (triplet>>8);
}

/*
	Returns the aboveNodeIndex value given the bit encoded triplet
	@param triplet An integer that stores the aboveNodeIndex, belowNodeIndex, and Laplacian value corresponding to a middleLayer node
*/
int decodeAboveNodeIndex(int triplet){
    //#pragma HLS INLINE
    return  (int) triplet&15;
}

/*
	Returns the belowNodeIndex value given the bit encoded triplet
	@param triplet An integer that stores the aboveNodeIndex, belowNodeIndex, and Laplacian value corresponding to a middleLayer node
*/
int decodeBelowNodeIndex(int triplet){
    //#pragma HLS INLINE
    return  (int) ((triplet>>4) & 15);
}

/*
	Calculates the Laplacian values for all of the triplets associated with a single node and stores each bit encoded triplet
	in triplet[numberOfNodes][numberOfNodes]
	@param aboveNodeList The list of nodes in the layer above the current node
	@param belowNodeList The list of nodes in the layer below the current node
	@param nodeTriplets A submatrix of tripletMatrix corresponding to a single node that stores all of the triplets
						associated with that node
	@param nodeTripletsTranspose A submatrix of tripletMatrixTranspose corresponding to a single node that stores all of the triplets
						associated with that node
	@param laplacianWeights The first value is w_(ijk,l) number that weights the Laplacians in the trackTrigger.pdf paper, and the second value is the value corresponding to a + c - laplacianWeights[1]b in the discrete Laplacian calculation
	@param inputNode The coordiantes of the node that we are generating the triplets for
*/
void singleNodeLaplacianCalculator(int aboveNodeList[adjacentNodes], int belowNodeList[adjacentNodes], int nodeTriplets[adjacentNodes][adjacentNodes], int nodeTripletsTranspose[adjacentNodes][adjacentNodes], int laplacianWeights[2], int inputNode) {
	//#pragma HLS unroll
	int weightedNode = laplacianWeights[1]*inputNode;
	// When we run singleNodeLaplacianCalculator on the transpose matrix, aboveNodeLoop actually runs through the below nodes
	aboveNodeLoop: for(int aboveNodeIndex=0; aboveNodeIndex<adjacentNodes; aboveNodeIndex++) {
		//#pragma HLS unroll
		int c1pos3 = laplacianWeights[0]*aboveNodeList[aboveNodeIndex];
		// When we run singleNodeLaplacianCalculator on the transpose matrix, belowNodeLoop actually runs through the above nodes
		belowNodeLoop: for(int belowNodeIndex=0; belowNodeIndex<adjacentNodes; belowNodeIndex++) {
			//#pragma HLS unroll
			// Calculate the Laplacian
			int laplacian = abs(c1pos3 + belowNodeList[belowNodeIndex] - weightedNode); 
			// Bit encode the node indices and Laplacian into an integer that represents the triplet 
			int triplet = encode(aboveNodeIndex, belowNodeIndex, laplacian);
			// Store the triplet in the corresponding array position
			nodeTriplets[aboveNodeIndex][belowNodeIndex] = triplet;
			nodeTripletsTranspose[belowNodeIndex][aboveNodeIndex] = triplet;
		}
	}
    return;
}

template<class index_t, class array_t>
void compareAndExchange(array_t a[], index_t i, index_t j, bool upOrDown) {
   //#pragma HLS INLINE

   // true is down sort
   if (upOrDown == false) {
	   // i and j (which are indices) get swapped
	   int t = i;
	   i = j;
	   j = t;
   } 
   if(decodeLaplacian(a[i]) > decodeLaplacian(a[j])) {
		array_t t = a[i];
    	a[i] = a[j];
    	a[j] = t;
    }
}

//Bitonic sort from existing codes
//Description TBD
template<class array_t, class index_t, class mask_t> 
void elementLoop(array_t a[], index_t j, mask_t mask, int const power) {
    //#pragma HLS INLINE
    // const int powerCopy;
    // memcpy(powerCopy, power, sizeof(int));
    LOOP_OVER_ELEMENTS: for (int i=0; i<(1<<power); i++) { 
        int ij=i^j;
        if ((ij)>i) compareAndExchange(a, i, ij, (i&mask)==0); 
    }
}

/*
	Modifies an array of length pow(2, power) such that the smallest value of the array is put in its 0th index
	@param array[(int)pow(2, power)] The array to be sorted
	@param power The power of two that determines how many elements are the the array
*/
template<class T> 
void MinFinder(T array[], int const power){
	// length is 2^power. This is the length of array
    int length = 1<<power;
    for(int i=0; i<power; i++){
        int increment = 2<<i;
        int halfIncrement = increment>>1;
        for(int j=0; j<length; j+= increment){
            compareAndExchange(array, j, j+halfIncrement, true);
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
void MSS(T work_array[], int const power) {
	#pragma HLS PIPELINE II=10
    #pragma HLS ARRAY_PARTITION variable=work_array complete
    
    if (power >= 2) {
        LOOP2: for (int j=1; j>0; j=j>>1) {
            elementLoop(work_array,j,2, power);
        }
    } 
    if (power >= 3) {
        LOOP4: for (int j=2; j>0; j=j>>1) {
            elementLoop(work_array,j,4, power);
        }
    } 
    if (power >= 4) {
        LOOP8: for (int j=4; j>0; j=j>>1) {
            elementLoop(work_array,j,8, power);
        }
    }

    elementLoop(work_array, 1<<(power-1), 0, power-1);
}

/*
	Sets link corresponding to a single triplet's upLink to acceptLink in MM
	@param tripletMatrixMaximum A triplet with a Laplacian value smaller than the first half of triplets in laplacianMinimums
								after it is sorted by MSS
    @param nodeIndex The index of the node in the layer that the triplet corresponds to
*/
void updateUpLink(int tripletMatrixMinimum, bool MM[middleLayers][numberOfNodes][adjacentLayers][numberOfNodes], int nodeIndex, int middleLayer) { 
	int aboveNodeIndex = decodeAboveNodeIndex(tripletMatrixMinimum); 
	MM[middleLayer][nodeIndex][0][aboveNodeIndex] = acceptLink;
}

/*
	Sets link corresponding to a single triplet's downLink to acceptLink in MM
	@param tripletMatrixMaximum A triplet with a Laplacian value smaller than the first half of triplets in laplacianMinimumsTranspose
								after it is sorted by MSS
    @param nodeIndex The index of the node in the layer that the triplet corresponds to
*/
void updateDownLink(int tripletMatrixMinimumTranspose, bool MM[middleLayers][numberOfNodes][adjacentLayers][numberOfNodes], int nodeIndex, int middleLayer) { 
	int belowNodeIndex = decodeBelowNodeIndex(tripletMatrixMinimumTranspose);
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
void fullSystem(const int nodeCoordinates[totalLayers][numberOfNodes], bool MM[middleLayers][numberOfNodes][adjacentLayers][numberOfNodes], int laplacianWeights[2]) {
    // tripletMatrix contains the set of all possible triplets per node
    int tripletMatrix[middleLayers][numberOfNodes][adjacentNodes][adjacentNodes];
    // When tripletMatrixTranspose is declared, the submatrices corresponding to each node is the transpose of the 
	// analogous submatrix in tripletMatrix. However, this property is not an invariant, and is broken when MinFinder is run
    int tripletMatrixTranspose[middleLayers][numberOfNodes][adjacentNodes][adjacentNodes];

	powerLoop: for (int power=4; power>=1; power--) {
        // tripletMatrixPruned contains the set of all triplets per node that have acceptLinks
        int tripletMatrixPruned[middleLayers][numberOfNodes][1<<power][1<<power];
        int tripletMatrixPrunedTranspose[middleLayers][numberOfNodes][1<<power][1<<power];
        // MinFinder and MSS modify the array passed in. To create tripletMatrixPruned in the power loop, we must maintain the index correspondence between tripletMatrix and MM. Therefore, MinFinder
		// and MSS must modify copies of tripletMatrix rather than tripletMatrix itself
        int tripletMatrixCopy[middleLayers][numberOfNodes][1<<power][1<<power]; 
        int tripletMatrixTransposeCopy[middleLayers][numberOfNodes][1<<power][1<<power];
        
        if (power != 4) {
            // Intialize tripletmatrixPruned with max/dummy values for laplacian and dummy ij values 00
            for (int j=0; j < middleLayers; j++) {
                for (int nodeIndex = 0; nodeIndex < 16; nodeIndex++) {
                    for (int i =0; i < 1<<power; i++) {
                        for (int belowNodeIterator = 0; belowNodeIterator < 1<<power; belowNodeIterator++) {
                            tripletMatrixPruned[j][nodeIndex][i][belowNodeIterator] = encode(0, 0, 999999);
                            tripletMatrixPrunedTranspose[j][nodeIndex][belowNodeIterator][i] = encode(0, 0, 999999);
                        }
                    }
                }
            }

            // Iterate through MM, if the link is accept, insert the corresponding triplet from tripletMatrix into tripletMatrixPruned 
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
                            if (MM[middleLayer][nodeIndex][belowLayerIndex][belowNodeIndex] == acceptLink && MM[middleLayer][nodeIndex][aboveLayerIndex][aboveNodeIndex] == acceptLink) {
                                // If the two links corresponding to the loop indices are accept in MM, then add the triplet corresponding to these two links in tripletMatrix to tripletMatrixPruned
                                ifStatementTriggered = true;
                                // The index in tripletMatrixPruned that we insert the triplet into is determined sequentially, corresponding to the iterators
                                tripletMatrixPruned[middleLayer][nodeIndex][aboveNodeIterator][belowNodeIterator] = tripletMatrix[middleLayer][nodeIndex][aboveNodeIndex][belowNodeIndex];
                                tripletMatrixPrunedTranspose[middleLayer][nodeIndex][belowNodeIterator][aboveNodeIterator] = tripletMatrixTranspose[middleLayer][nodeIndex][belowNodeIndex][aboveNodeIndex];
                                belowNodeIterator++;
                            } 
                        }
                        if (ifStatementTriggered) {
                            aboveNodeIterator++;
                        }
                    }
                }
            }

            memcpy(tripletMatrixCopy, tripletMatrixPruned, middleLayers*numberOfNodes*(1<<power)*(1<<power)*sizeof(int));
            memcpy(tripletMatrixTransposeCopy, tripletMatrixPrunedTranspose, middleLayers*numberOfNodes*(1<<power)*(1<<power)*sizeof(int));
        }

        // Set MM to all rejectLinks. Since we already stored all possible triplets corresponding to acceptLinks in tripletMatrixPruned, we no longer need to keep the record in MM.
        // Refreshing MM allows us to further decrease the possible triplet solutions and update MM with updateLink again with a fewer number of triplets, then repeat the process until
        // there is at most one triplet per node.
        for(int layer=0; layer<middleLayers; layer++) {
            //#pragma HLS unroll
            for(int nodeIndex=0; nodeIndex<numberOfNodes; nodeIndex++) {
                //#pragma HLS unroll
                for(int correspondingNodeIndex=0; correspondingNodeIndex<numberOfNodes; correspondingNodeIndex++) {
                    //#pragma HLS unroll
                    int aboveLayerIndex = 0;
                    int belowLayerIndex = 1;
                    MM[layer][nodeIndex][aboveLayerIndex][correspondingNodeIndex] = rejectLink;
                    MM[layer][nodeIndex][belowLayerIndex][correspondingNodeIndex] = rejectLink;
                }
            }
        }        

		// Loop through only the middle layers because the uppermost and lowermost layers are not associated with triplets
		for (int middleLayer=0; middleLayer<middleLayers; middleLayer++) {
			//#pragma HLS unroll
			for (int nodeIndex=0; nodeIndex<numberOfNodes; nodeIndex++) {
				//#pragma HLS unroll
                if (power == 4) {
                    // Recognize the indexing discrepency between nodeCoordinates (which contains all 5 layers) and tripletMatrix 
			        // which contains only the middle layers. aboveLayer and belowLayer are initialized to account for this 
			        // discrepency in the singleNodeLaplacianCalculator call
                    int aboveLayer = middleLayer+2;
                    int belowLayer = middleLayer;

                    singleNodeLaplacianCalculator((int*) nodeCoordinates[aboveLayer], (int*) nodeCoordinates[belowLayer], \
                                                    tripletMatrix[middleLayer][nodeIndex], tripletMatrixTranspose[middleLayer][nodeIndex], laplacianWeights, \
                                                    nodeCoordinates[middleLayer+1][nodeIndex]);
                    
                    memcpy(tripletMatrixCopy, tripletMatrix, middleLayers*numberOfNodes*(1<<power)*(1<<power)*sizeof(int));
                    memcpy(tripletMatrixTransposeCopy, tripletMatrixTranspose, middleLayers*numberOfNodes*(1<<power)*(1<<power)*sizeof(int));
                }

                //#pragma HLS array_partition variable=MM complete dim=0
                
				// Store the triplets with the smallest Laplacian values per adjacent node to nodeIndex in laplacianMinimums (above nodes)
				// or laplacianMinimumsTranspose (below nodes). laplacianMinimums is an array of size 2^power, which corresponds to the greatest 
                // possible number of triplets that were accepted the last time updateUpLink and updateDownLink were run
				int laplacianMinimums[1<<power];
				int laplacianMinimumsTranspose[1<<power];
				for (int adjacentNodeIndex=0; adjacentNodeIndex< 1<<power; adjacentNodeIndex++) {
					//#pragma HLS unroll
					MinFinder(tripletMatrixCopy[middleLayer][nodeIndex][adjacentNodeIndex], power);
					MinFinder(tripletMatrixTransposeCopy[middleLayer][nodeIndex][adjacentNodeIndex], power);
					laplacianMinimums[adjacentNodeIndex] = tripletMatrixCopy[middleLayer][nodeIndex][adjacentNodeIndex][0];
					laplacianMinimumsTranspose[adjacentNodeIndex] = tripletMatrixTransposeCopy[middleLayer][nodeIndex][adjacentNodeIndex][0];
				}

                // TODO: see if we can pass in the triplets and do comparisons on the triplets (not the laplacians) for MSS and Minfinder
				MSS(laplacianMinimums, power);
				MSS(laplacianMinimumsTranspose, power);
				
				// Accept the links corresponding to the smallest half of the triplets stored in the Minimums lists
				for (int largestTripletIndex=0; largestTripletIndex < (1<<(power-1)); largestTripletIndex++) {
					//#pragma HLS unroll
					updateUpLink(laplacianMinimums[largestTripletIndex], MM, nodeIndex, middleLayer);
					updateDownLink(laplacianMinimumsTranspose[largestTripletIndex], MM, nodeIndex, middleLayer);
				}
			}
		}
		// Run consensus protocol
		pruneGlobalMatrix(MM);
	}	

	// Print final MM matrix
    cout << "{" << "\n";
	for(int layer=0; layer<middleLayers; layer++) {
        cout << "layer" << layer+1 << " {" << "\n";
		for(int nodeIndex=0; nodeIndex<numberOfNodes; nodeIndex++) {
            cout << "node" << nodeIndex+1 << " {";
			for(int correspondingNodeIndex=0; correspondingNodeIndex<numberOfNodes; correspondingNodeIndex++) {
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
	// Variable input ensures synthesis is performed for all nodes
    // TODO: add this line back in 
	// *ans = tripletMatrix[c1][c2][c3][c4]; 
}

int main() {
    int layerRadii[totalLayers] = {5, 10, 15, 20, 25}; // in centimeters
    double theta[numberOfNodes] = {0, 1.5, 1.7, 1.9, 2.1, 2.3, 2.5, 2.7, 2.9, 3.1, 3.3, 3.5, 3.7, 3.9, 5, 6.28}; // we'll say for now that the 16 hits are not within a slice, but within the whole cylinder
    int fragmentsPerCollision = 16; 
    int numberOfCollisionsPerTime = 1;
    int timeBetweenCollisions = 25; // in nanoseconds
    double pixelWidth = 0.0025; // in cm
    int numberOfSections = 1;
	int outcome = 1;
    int curveRadius = (100/6)*10000;
    generateCoordinates(layerRadii, theta, fragmentsPerCollision, numberOfCollisionsPerTime, timeBetweenCollisions, pixelWidth, numberOfSections, outcome, curveRadius);
    
    // MM is the global data structure that encodes the "accepted links" (most likely path taken by particle fragment between hits).
	// We initialize MM such that all links are reject links
	bool MM[middleLayers][numberOfNodes][adjacentLayers][numberOfNodes];
	int laplacianWeights[2] = {1, 2};
    fullSystem(coordinates, MM, laplacianWeights);

	ofstream MMFile;
	MMFile.open ("MM.txt");
    for (int layer = 0; layer < totalLayers; layer++) {
        MMFile << "{";
        for (int hit = 0; hit < numberOfNodes; hit++) {
			if (hit != numberOfNodes - 1) {
				MMFile << coordinates[layer][hit] << ", ";
			} else {
				MMFile << coordinates[layer][hit];
			}
            
        }
        MMFile << "} \n";
    }
    MMFile << "\n";

	MMFile << "MM" << "\n";
    MMFile << "{" << "\n";
	for(int layer=0; layer<middleLayers; layer++) {
        MMFile << "layer" << layer+1 << " {" << "\n";
		for(int nodeIndex=0; nodeIndex<numberOfNodes; nodeIndex++) {
            MMFile << "node" << nodeIndex+1 << " {";
			for(int correspondingNodeIndex=0; correspondingNodeIndex<numberOfNodes; correspondingNodeIndex++) {
				int aboveLayerIndex = 0;
				int belowLayerIndex = 1;
                MMFile << MM[layer][nodeIndex][aboveLayerIndex][correspondingNodeIndex] << MM[layer][nodeIndex][belowLayerIndex][correspondingNodeIndex] << " ";
			}
            MMFile << "}" << "\n";
		}
        MMFile << "}" << "\n";
	}
    MMFile << "}" << "\n" << "\n";
	MMFile.close();
    return 0;
}