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
#define adjacentNodes 16 // Each middle layer node has 16 adjacent nodes above and below TODO: consider splitting this into aboveNodes and belowNodes
#define acceptLink true 
#define rejectLink false
#define tripletBitWidth 20  // Each triplet corresponds to an "i" value (position of node in the above adjacent layer), 
							// a "j" value (position of node in the below adjacent layer), and am "l" value (the discrete 
							// Laplacian corresponding to this node, the i value, and the j value)
#define nodeIndexBitWidth 4 // log_2(numberOfNodes)
#define upLink 0
#define downLink 1

// TODO: make visualization of MM matrix (can make separate program that parses the printout; can be written in python by taking in printout of this file); create UI for user input corresonding to the preset values currently being set in the main function

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
	@param outcome Calibrates generateCoordinates for a particular collision outcome: 0 for sixteen straight lines, 1 for two straight lines on the edges, 2 for two straight lines in the middle, 3 for no straight lines, 4 for one curved line
*/

void generateCoordinates(int layerRadii[totalLayers], double theta[numberOfNodes], int fragmentsPerCollision, int numberOfCollisionsPerTime, int timeBetweenCollisions, double pixelWidth, int numberOfSections, int outcome) {
	// Fill in coordinates array with fixed values corresponding to 16 straight lines
	if (outcome == 0) {
		for (int layer = 0; layer < totalLayers; layer++) {
			for (int fragmentIndex = 0; fragmentIndex < fragmentsPerCollision; fragmentIndex++) {
				if (fragmentIndex == 0) {
					coordinates[layer][fragmentIndex] = 1;
				} else if (fragmentIndex != 0 && fragmentIndex != 15) {
					double segment = layerRadii[layer] * theta[fragmentIndex];
					int hit = (int) floor((segment*10e3)/25);
					coordinates[layer][fragmentIndex] = hit/(layer+1);
				} else {
					coordinates[layer][fragmentIndex] = 12566;
				}
			}
		}

	} else {
		for (int layer = 0; layer < totalLayers; layer++) {
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

			// Sort each coordinate layer spatially
			int n = sizeof(coordinates[layer]) / sizeof(coordinates[layer][0]);
			sort(coordinates[layer], coordinates[layer] + n);

			// should probably try more lines for outcome == 2, and also different values for the addition in outcome == 4 and different nodes.
			if (outcome == 1) {
				coordinates[layer][0] = 1; 
				coordinates[layer][15] = 12566; 
			} else if (outcome == 2) {
				coordinates[layer][5] = 4600; 
				coordinates[layer][12] = 7400;
			} else if (outcome == 3) {
				// do nothing
			} else {
				// TODO: determine if this offset is enough or if we should increase it or vary it more
				coordinates[layer][5] = 4600 + layer; // change layer to arc equation dependent on parameter for curvature. half the lines are left turning and half are right. circle with tangent line. the point of tangency is the origin. If radius increases, the curvature of the circle decreases. this edge of the circle is a curved line
			}
		}
	}
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
	
	// When we run singleNodeLaplacianCalculator on the transpose matrix, aboveNodeLoop actually runs through the below nodes
	aboveNodeLoop: for(int aboveNodeIndex=0; aboveNodeIndex<adjacentNodes; aboveNodeIndex++) {
		//#pragma HLS unroll
		int c1pos3 = laplacianWeights[0]*aboveNodeList[aboveNodeIndex];
		// When we run singleNodeLaplacianCalculator on the transpose matrix, belowNodeLoop actually runs through the above nodes
		belowNodeLoop: for(int belowNodeIndex=0; belowNodeIndex<adjacentNodes; belowNodeIndex++) {
			//#pragma HLS unroll
			// Calculate the Laplacian
			int laplacian = abs(c1pos3 + belowNodeList[belowNodeIndex] - laplacianWeights[1]*inputNode); 
			// Bit encode the node indices and Laplacian into an integer that represents the triplet 
			int triplet = encode(aboveNodeIndex, belowNodeIndex, laplacian);
			// Store the triplet in the corresponding array position
			nodeTriplets[aboveNodeIndex][belowNodeIndex] = triplet;
			nodeTripletsTranspose[belowNodeIndex][aboveNodeIndex] = triplet;
		}
	}
    return;
}

//TODO: turn into compare and exchange
template<class index_t, class array_t>
void exchange(array_t a[], index_t i, index_t j) {
   //#pragma HLS INLINE
	array_t t = a[i];
    a[i] = a[j];
    a[j] = t;
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
void elementLoop(array_t a[], index_t j, mask_t mask, int power) {
    //#pragma HLS INLINE
    LOOP_OVER_ELEMENTS: for (int i=0; i<pow(2, power); i++) { 
        int ij=i^j;
		
		
        if ((ij)>i) {
			
            if ((i&mask)==0 && a[i] > a[ij]){
                exchange(a,i,ij);
            } else if ((i&mask)!=0 && a[i] < a[ij]){
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
void MinFinder(T array[], int power){
	// length is 2^power. This is the length of array
    int length = 1<<power;
    for(int i=0; i<power; i++){
        int increment = 2<<i;
        int halfIncrement = increment>>1;
        for(int j=0; j<length; j+= increment){
            if(decodeLaplacian(array[j]) > decodeLaplacian(array[j+halfIncrement])){
                exchange(array, j, j+halfIncrement);
            }
        }
    }
}

// TODO: implement figure 3.1

/*
	Given an array of length pow(2, power), put the pow(2, power)/2 greatest elements in the last pow(2, power)/2 slots
	in the array
	@param array[(int)pow(2, power)] The array to be sorted
	@param power The power of two that determines how many elements are the the array
*/

/*
template<class T>
void MSS(T array[], int power) {
    //#pragma HLS PIPELINE II=10
    //#pragma HLS ARRAY_PARTITION variable=work_array complete

	for (int i=0; i<power; i++) {
		for (int j = (int)pow(2, i); j>0; j=j>>1) {
        	elementLoop(array, j, (int)pow(2, (i+1)));
		}
	}
    //Max(array, power-1);
}
*/

template<class T>
void Max(T array[], int power, int startIndex, bool down){ 
   //#pragma HLS INLINE
   for(int i=startIndex; i<startIndex+(int)pow(2, power); i++){
        //#pragma HLS unroll
        int j = i+(int)pow(2, power);
		compareAndExchange(array, i, j, down);
    }
}

// create a header file with the declarations
template<class T>
void FullSort(T arr[], int power, int startIndex, int down);

template<class T>
void MSSv2(T arr[], int power, int startIndex, bool down);

template<class T>
void FullSort(T arr[], int power, int startIndex, int down) { // TODO: if start index is always 0 or 2^power/2, then replace index with a boolean and make the decision internally (via an if statement) 
	if (power == 1) {
		compareAndExchange(arr, startIndex, startIndex+1, down); // pass in upOrDown here 
	} else {
		MSSv2(arr, power, startIndex, down);
		FullSort(arr, power-1, startIndex, down);
		FullSort(arr, power-1, startIndex+pow(2,power-1), down); // should this be power, not power-1?
	}
}

template<class T>
void MSSv2(T arr[], int power, int startIndex, bool down) { // startIndex is 0 for call in FullSystem; upOrDown is always down (true) for call in FullSystem
	// note: could solve the Max start index problem by using an array slice for these calls (or instead of slicing, create an array of half length with pointers to the first/second half of elements in the original array)
	if (power == 1) {
		compareAndExchange(arr, startIndex, startIndex+1, down); // always down
		// exchange for down sort
	} else {

		FullSort(arr, power-1, startIndex, true); // instead of 0, have startIndex passed in from MSS param. 
		FullSort(arr, power-1, startIndex+pow(2, power-1), false); // have startindex + pow(2, power-1)
		
		Max(arr, power-1, startIndex, down); // need to specifiy up or down sort in max, and also need a start index since it is always working on the original length 16 array
	}
	
}



template<class T>
void MSS(T arr[], int power) {
    //#pragma HLS PIPELINE II=10
    //#pragma HLS ARRAY_PARTITION variable=work_array complete
	// remember to add decodelaplacian back in for all comparisons

	// make general
	/*
	bool sortUp = true; // sortUp means array[i] < array[i+1]
	for (int index = 0; index < (int)pow(2, power); index=index+2) {
		// unroll this

		if (sortUp == true) {
			if (decodeLaplacian(arr[index]) > decodeLaplacian(arr[index+1])) {
				exchange(arr, index, index+1);
			}
		} else {
			if (decodeLaplacian(arr[index]) < decodeLaplacian(arr[index+1])) {
				exchange(arr, index, index+1);
			}
		}

		if (sortUp == true) {
			sortUp = false;
		} else {
			sortUp = true;
		}
	}

	cout << "arr after first sort: " << "\n";
	for (int index = 0; index < 16; index++) {
		cout << decodeLaplacian(arr[index]) << "\n";
	}

	sortUp = true;
	for (int index = 0; index < (int)pow(2, power); index=index+4) {

		if (sortUp == true) {
			if (decodeLaplacian(arr[index]) > decodeLaplacian(arr[index+2])) {
				exchange(arr, index, index+2);
			}
			if (decodeLaplacian(arr[index+1]) > decodeLaplacian(arr[index+3])) {
				exchange(arr, index+1, index+3);
			}
			if (decodeLaplacian(arr[index]) > decodeLaplacian(arr[index+1])) {
				exchange(arr, index, index+1);
			}
			if (decodeLaplacian(arr[index+2]) > decodeLaplacian(arr[index+3])) {
				exchange(arr, index+2, index+3);
			}
		} else {

			if (decodeLaplacian(arr[index]) < decodeLaplacian(arr[index+2])) {
				exchange(arr, index, index+2);
			}
			if (decodeLaplacian(arr[index+1]) < decodeLaplacian(arr[index+3])) {
				exchange(arr, index+1, index+3);
			}
			if (decodeLaplacian(arr[index]) < decodeLaplacian(arr[index+1])) {
				exchange(arr, index, index+1);
			}
			if (decodeLaplacian(arr[index+2]) < decodeLaplacian(arr[index+3])) {
				exchange(arr, index+2, index+3);
			}
		}
		
		if (sortUp == true) {
			sortUp = false;
		} else {
			sortUp = true;
		}
	}
	*/

	// power is passed in as a parameter, and vitis thinks a variable
	// const int powerCopy = memcpy(power)

	// powerCopy = power

	for (int i=0; i<power; i++) {
		for (int j = (int)pow(2, i); j>0; j=j>>1) {
        	elementLoop(arr, j, (int)pow(2, (i+1)), power);
		}
	}

	cout << "arr after old MSS sort: " << "\n";
	for (int index = 0; index < 16; index++) {
		cout << decodeLaplacian(arr[index]) << "\n";
	}

	
	if (power == 4) {
		for (int index = 0; index < (int)pow(2, power)/2; index=index+2) {
			// unroll this
			if (decodeLaplacian(arr[index]) > decodeLaplacian(arr[index+1])) {
				exchange(arr, index, index+1);
			}
		}

		for (int index = 0; index < (int)pow(2, power)/2; index=index+4) {

			if (decodeLaplacian(arr[index]) > decodeLaplacian(arr[index+2])) {
				exchange(arr, index, index+2);
			}
			if (decodeLaplacian(arr[index+1]) > decodeLaplacian(arr[index+3])) {
				exchange(arr, index+1, index+3);
			}
			if (decodeLaplacian(arr[index+1]) > decodeLaplacian(arr[index+2])) {
				exchange(arr, index+1, index+2);
			}
		}

		for (int index = 0; index < (int) pow(2, power)/4; index++) {
			if (decodeLaplacian(arr[index]) > decodeLaplacian(arr[index+((int) pow(2, power)/4)])) {
				exchange(arr, index, index+((int) pow(2, power)/4));
			}
		}

		if (decodeLaplacian(arr[2]) > decodeLaplacian(arr[4])) {
				exchange(arr, 2, 4);
		}

		if (decodeLaplacian(arr[3]) > decodeLaplacian(arr[5])) {
				exchange(arr, 3, 5);
		}

		for (int index = 1; index < (int)pow(2, power)/2 - 1; index=index+2) {
			// unroll this
			if (decodeLaplacian(arr[index]) < decodeLaplacian(arr[index+1])) {
				exchange(arr, index, index+1);
			}
		}	

		for (int index = 1; index < (int)pow(2, power)/2 - 1; index=index+2) {
			// unroll this
			if (decodeLaplacian(arr[index]) > decodeLaplacian(arr[index+1])) {
				exchange(arr, index, index+1);
			}
		}

		for (int index = (int)pow(2, power)/2; index < (int)pow(2, power); index=index+2) {
			// unroll this
			if (decodeLaplacian(arr[index]) < decodeLaplacian(arr[index+1])) {
				exchange(arr, index, index+1);
			}
		}

		for (int index = (int)pow(2, power)/2; index < (int)pow(2, power); index=index+4) {

			if (decodeLaplacian(arr[index]) < decodeLaplacian(arr[index+2])) {
				exchange(arr, index, index+2);
			}
			if (decodeLaplacian(arr[index+1]) < decodeLaplacian(arr[index+3])) {
				exchange(arr, index+1, index+3);
			}
			if (decodeLaplacian(arr[index+1]) < decodeLaplacian(arr[index+2])) {
				exchange(arr, index+1, index+2);
			}
		}

		for (int index = (int) pow(2, power)/2; index < ((int) pow(2, power)*3)/4; index++) {
			if (decodeLaplacian(arr[index]) < decodeLaplacian(arr[index+((int) pow(2, power)/4)])) {
				exchange(arr, index, index+((int) pow(2, power)/4));
			}
		}

		if (decodeLaplacian(arr[10]) < decodeLaplacian(arr[12])) {
			exchange(arr, 10, 12);
		}

		if (decodeLaplacian(arr[11]) < decodeLaplacian(arr[13])) {
			exchange(arr, 11, 13);
		}

		for (int index = 9; index < (int)pow(2, power) - 1; index=index+2) { // TODO: fix this out of bounds problem, then make code more general
			// unroll this
			if (decodeLaplacian(arr[index]) < decodeLaplacian(arr[index+1])) {
				exchange(arr, index, index+1);
			}
		}		

	}

	cout << "arr after power sort: " << "\n";
	for (int index = 0; index < 16; index++) {
		cout << decodeLaplacian(arr[index]) << "\n";
	}

	for (int index = 0; index < (int) pow(2, power)/2; index++) {
		if (decodeLaplacian(arr[index]) > decodeLaplacian(arr[index+((int) pow(2, power)/2)])) {
			exchange(arr, index, index+((int) pow(2, power)/2));
		}
	}

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
// We need coordinateBitWidth bit precision for the coordinates; the algebra done to get the Laplacian value (a coordinateBitWidth bit number) must be done with all coordinateBitWidth bit numbers
void fullSystem(const int nodeCoordinates[totalLayers][numberOfNodes], bool MM[middleLayers][numberOfNodes][adjacentLayers][numberOfNodes], int laplacianWeights[2]) {
	
	// Initialize MM to rejectLinks
	//#pragma HLS array_partition variable=MM complete dim=0
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

	// tripletMatrix contains the set of all possible triplets per node
	int tripletMatrix[middleLayers][numberOfNodes][adjacentNodes][adjacentNodes]; 
    
	// When tripletMatrixTranspose is declared, the submatrices corresponding to each node is the transpose of the 
	// analogous submatrix in tripletMatrix. However, this property is not an invariant, and is broken when MinFinder is run
	int tripletMatrixTranspose[middleLayers][numberOfNodes][adjacentNodes][adjacentNodes];

	// Loop through only the middle layers because the uppermost and lowermost layers are not associated with triplets
	middleLayerLoop1: for (int middleLayer=0; middleLayer<middleLayers; middleLayer++) {
		//#pragma HLS unroll
		nodeLoop1: for(int nodeIndex=0; nodeIndex<numberOfNodes; nodeIndex++) {
			//#pragma HLS unroll

			// Recognize the indexing discrepency between nodeCoordinates (which contains all 5 layers) and tripletMatrix 
			// which contains only the middle layers. aboveLayer and belowLayer are initialized to account for this 
			// discrepency in the singleNodeLaplacianCalculator call
			int aboveLayer = middleLayer+2;
			int belowLayer = middleLayer;

			singleNodeLaplacianCalculator((int*) nodeCoordinates[aboveLayer], (int*) nodeCoordinates[belowLayer], \
											tripletMatrix[middleLayer][nodeIndex], tripletMatrixTranspose[middleLayer][nodeIndex], laplacianWeights, \
											nodeCoordinates[middleLayer+1][nodeIndex]);

			// power denotes numberOfLinksRemainingInAdjacentLayersPerNode = pow(2, power)
			int power = 4;

			// MinFinder and MSS modify the array passed in. To create tripletMatrixPruned in the power loop, we must maintain the index correspondence between tripletMatrix and MM. Therefore, MinFinder
			// and MSS must modify copies of tripletMatrix rather than tripletMatrix itself
			int tripletMatrixCopy[middleLayers][numberOfNodes][adjacentNodes][adjacentNodes]; 
			memcpy(tripletMatrixCopy, tripletMatrix, middleLayers*numberOfNodes*adjacentNodes*adjacentNodes*sizeof(int));
			int tripletMatrixTransposeCopy[middleLayers][numberOfNodes][adjacentNodes][adjacentNodes];
			memcpy(tripletMatrixTransposeCopy, tripletMatrixTranspose, middleLayers*numberOfNodes*adjacentNodes*adjacentNodes*sizeof(int));

			// Store the triplets with the smallest Laplacian values per adjacent node to nodeIndex in laplacianMinimums (above nodes)
			// or laplacianMinimumsTranspose (below nodes)
			int laplacianMinimums[adjacentNodes];
			int laplacianMinimumsTranspose[adjacentNodes];
			for (int adjacentNodeIndex=0; adjacentNodeIndex<adjacentNodes; adjacentNodeIndex++) {
				//#pragma HLS unroll
				MinFinder(tripletMatrixCopy[middleLayer][nodeIndex][adjacentNodeIndex], power);
				MinFinder(tripletMatrixTransposeCopy[middleLayer][nodeIndex][adjacentNodeIndex], power);
				laplacianMinimums[adjacentNodeIndex] = tripletMatrixCopy[middleLayer][nodeIndex][adjacentNodeIndex][0];

				laplacianMinimumsTranspose[adjacentNodeIndex] = tripletMatrixTransposeCopy[middleLayer][nodeIndex][adjacentNodeIndex][0];
                // TODO FOR LATER: Technically should be able to compare without decoding; but 1. this is not the case if the laplacian value can be negative, and 2. need to make sure that the ij values are maintained
			}

			cout << "laplacianMinimums before MSS" << "\n";
			for (int i = 0; i < sizeof(laplacianMinimums)/sizeof(laplacianMinimums[0]); i++) {
				cout << "laplacianMinimums[i]: " << decodeAboveNodeIndex(laplacianMinimums[i]) << " " << decodeBelowNodeIndex(laplacianMinimums[i]) << " " << decodeLaplacian(laplacianMinimums[i]) << "\n";
				cout << "laplacianMinimumsTranspose[i]: " << decodeAboveNodeIndex(laplacianMinimumsTranspose[i]) << " " << decodeBelowNodeIndex(laplacianMinimumsTranspose[i]) << " " << decodeLaplacian(laplacianMinimumsTranspose[i]) << "\n";
			} 

            // TODO: see if we can pass in the triplets and do comparisons on the triplets (not the laplacians) for MSS and Minfinder
			MSSv2(laplacianMinimums, power, 0, true);
			MSSv2(laplacianMinimumsTranspose, power, 0, true);

			cout << "laplacianMinimums after MSS" << "\n";
			for (int i = 0; i < sizeof(laplacianMinimums)/sizeof(laplacianMinimums[0]); i++) {
				cout << "laplacianMinimums[i]: " << decodeAboveNodeIndex(laplacianMinimums[i]) << " " << decodeBelowNodeIndex(laplacianMinimums[i]) << " " << decodeLaplacian(laplacianMinimums[i]) << "\n";
				cout << "laplacianMinimumsTranspose[i]: " << decodeAboveNodeIndex(laplacianMinimumsTranspose[i]) << " " << decodeBelowNodeIndex(laplacianMinimumsTranspose[i]) << " " << decodeLaplacian(laplacianMinimumsTranspose[i]) << "\n";
			} 

			// Accept the links corresponding to the smallest half of the triplets stored in the Minimums lists
			for (int largestLaplacianIndex=0; largestLaplacianIndex<numberOfNodes/2; largestLaplacianIndex++) {
				//#pragma HLS unroll
				updateUpLink(laplacianMinimums[largestLaplacianIndex], MM, nodeIndex, middleLayer);
				updateDownLink(laplacianMinimumsTranspose[largestLaplacianIndex], MM, nodeIndex, middleLayer);
			}
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
		}
	}

	// Run consensus protocol
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
	pruneGlobalMatrix(MM);
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

	// Repeat the process above, cutting the number of triplets per node in half until there is only a single triplet
	// associated with each node
	powerLoop: for (int power=3; power>=1; power--) {
        // tripletMatrixPruned contains the set of all triplets per node that have acceptLinks
        int tripletMatrixPruned[middleLayers][numberOfNodes][(int)pow(2, power)][(int)pow(2, power)];
        int tripletMatrixPrunedTranspose[middleLayers][numberOfNodes][(int)pow(2, power)][(int)pow(2, power)];

		// Intialize tripletmatrixPruned with max/dummy values for laplacian and dummy ij values 00;
		for (int j=0; j < middleLayers; j++) {
			for (int nodeIndex = 0; nodeIndex < 16; nodeIndex++) {
				for (int i =0; i <(int)pow(2, power); i++) {
					for (int belowNodeIterator = 0; belowNodeIterator < (int)pow(2, power); belowNodeIterator++) {
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

		int tripletMatrixCopy[middleLayers][numberOfNodes][(int)pow(2, power)][(int)pow(2, power)]; 
		memcpy(tripletMatrixCopy, tripletMatrixPruned, middleLayers*numberOfNodes*(int)pow(2, power)*(int)pow(2, power)*sizeof(int));
		int tripletMatrixTransposeCopy[middleLayers][numberOfNodes][(int)pow(2, power)][(int)pow(2, power)];
		memcpy(tripletMatrixTransposeCopy, tripletMatrixPrunedTranspose, middleLayers*numberOfNodes*(int)pow(2, power)*(int)pow(2, power)*sizeof(int));
		
		// Set MM to all rejectLinks. Since we already stored all possible triplets corresponding to acceptLinks in tripletMatrixPruned, we no longer need to keep the record in MM.
		// Refreshing MM allows us to further decrease the possible triplet solutions and update MM with updateLink again with a fewer number of triplets, then repeat the process until
		// there is at most one triplet per node.
		//#pragma HLS array_partition variable=MM complete dim=0
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

		// Repeat the process in the first loop to narrow the max possible triplets per node from 2^power to 2^(power-1)
		for (int middleLayer=0; middleLayer<middleLayers; middleLayer++) {
			//#pragma HLS unroll
			for (int nodeIndex=0; nodeIndex<numberOfNodes; nodeIndex++) {
				//#pragma HLS unroll
                
				// Store the triplets with the smallest Laplacian values per adjacent node to nodeIndex in laplacianMinimums (above nodes)
				// or laplacianMinimumsTranspose (below nodes)

                // laplacianMinimums is an array of size 2^power, which corresponds to the greatest possible number of triplets that were accepted the last time updateUpLink and updateDownLink were run
				int laplacianMinimums[(int)pow(2, power)];
				int laplacianMinimumsTranspose[(int)pow(2, power)];
				for (int adjacentNodeIndex=0; adjacentNodeIndex<(int)pow(2, power); adjacentNodeIndex++) {
					//#pragma HLS unroll
					MinFinder(tripletMatrixCopy[middleLayer][nodeIndex][adjacentNodeIndex], power);
					MinFinder(tripletMatrixTransposeCopy[middleLayer][nodeIndex][adjacentNodeIndex], power);
					laplacianMinimums[adjacentNodeIndex] = tripletMatrixCopy[middleLayer][nodeIndex][adjacentNodeIndex][0];
					laplacianMinimumsTranspose[adjacentNodeIndex] = tripletMatrixTransposeCopy[middleLayer][nodeIndex][adjacentNodeIndex][0];
				}

				cout << "laplacianMinimums before MSS" << "\n";
				for (int i = 0; i < sizeof(laplacianMinimums)/sizeof(laplacianMinimums[0]); i++) {
					cout << "laplacianMinimums[i]: " << decodeAboveNodeIndex(laplacianMinimums[i]) << " " << decodeBelowNodeIndex(laplacianMinimums[i]) << " " << decodeLaplacian(laplacianMinimums[i]) << "\n";
					cout << "laplacianMinimumsTranspose[i]: " << decodeAboveNodeIndex(laplacianMinimumsTranspose[i]) << " " << decodeBelowNodeIndex(laplacianMinimumsTranspose[i]) << " " << decodeLaplacian(laplacianMinimumsTranspose[i]) << "\n";
				} 
				MSSv2(laplacianMinimums, power, 0, true);
				MSSv2(laplacianMinimumsTranspose, power, 0, true);
				

				cout << "laplacianMinimums after MSS" << "\n";
				for (int i = 0; i < sizeof(laplacianMinimums)/sizeof(laplacianMinimums[0]); i++) {
					cout << "laplacianMinimums[i]: " << decodeAboveNodeIndex(laplacianMinimums[i]) << " " << decodeBelowNodeIndex(laplacianMinimums[i]) << " " << decodeLaplacian(laplacianMinimums[i]) << "\n";
					cout << "laplacianMinimumsTranspose[i]: " << decodeAboveNodeIndex(laplacianMinimumsTranspose[i]) << " " << decodeBelowNodeIndex(laplacianMinimumsTranspose[i]) << " " << decodeLaplacian(laplacianMinimumsTranspose[i]) << "\n";
				} 
				
				// Accept the links corresponding to the smallest half of the triplets stored in the Minimums lists
				for (int largestTripletIndex=0; largestTripletIndex<(int)(pow(2, power))/2; largestTripletIndex++) {
					//#pragma HLS unroll
					updateUpLink(laplacianMinimums[largestTripletIndex], MM, nodeIndex, middleLayer);
					updateDownLink(laplacianMinimumsTranspose[largestTripletIndex], MM, nodeIndex, middleLayer);
				}
			}
		}
		// Run consensus protocol
		pruneGlobalMatrix(MM);
	}	
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

	// TODO: file 1. create python file that takes in text file and makes visualization 3. create bash script that runs the c++ script then the python script
	// 
	// Print final MM matrix
	
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
	int outcome = 2;

    generateCoordinates(layerRadii, theta, fragmentsPerCollision, numberOfCollisionsPerTime, timeBetweenCollisions, pixelWidth, numberOfSections, outcome);


	// MM is the global data structure that encodes the "accepted links" (most likely path taken by particle fragment between hits).
	// We initialize MM such that all links are reject links
	// TODO: ensure that vivado keeps the default declaration values of a bool array to false
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




	int array[16] = {9145,8381,7147,5985,4496,5403,3092,1642,1582,1416,981,806,2603,341,160,419};
	//int array[16] = {1658, 3038, 3860, 3218, 4603, 4789, 5239, 4962, 6108, 7007, 7876, 7396, 7589, 10544, 12058, 10859};
	//int array[4] = {encode(0,0, 6016), encode(0,0,2451), encode(0,0,2020), encode(0,0,1976)}; // 1812, 867, 615, 9, 1006, 955, 84, 227, 243, 170, 49, 74}; //MSS sometimes works, sometimes with Max it splits the array in two and sorts the largest half correct, sometimes it splits in two but doesn't sort correctly, sometimes it doesnt properly split in two
	//int array[8] = {36, 30, 878, 1035, 226, 212, 14, 373}; // 98, 131, 18, 296, 546, 1124, 1199, 1668 
	//int array[16] = {encode(0,0,317), encode(0,0,188), encode(0,0,222), encode(0,0,23), encode(0,0,118), encode(0,0,0), encode(0,0,59), encode(0,0,991), encode(0,0,1107), encode(0,0,1069), encode(0,0,721), encode(0,0,69), encode(0,0,452), encode(0,0,2324), encode(0,0,2446), encode(0,0,2645)};
	cout << "array before MSS: " << "\n";
	for (int i = 0; i < 16; i++) {
		array[i] = encode(0,0, array[i]);
		cout << decodeLaplacian(array[i]) << "\n";
	}

	MSSv2(array, 4, 0, true);

	cout << "array after MSS: " << "\n";
	for (int i = 0; i < 16; i++) {
		cout << decodeLaplacian(array[i]) << "\n";
	}
	// to test MSS: generate 8! different arrays. run MSS on each array, and run a fullSort on a copy of that array as well, then add the last half of both arrays to the set and see if the length of the set is 4. if it is, then MSS is correct
	// or, could call max on first four and min on second for, and max should be less than min. If this is true, MSS is correct
    return 0;
}