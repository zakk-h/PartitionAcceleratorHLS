// C++ imports
#include <stdio.h>
#include <iostream>
#include <stdint.h>
#include <assert.h>
#include <fstream>
#include <string>
#include <vector>
#include <algorithm>

// Vitis imports
// #include "ap_int.h"

// Namespaces
using namespace std;

// Global Constants
#define totalLayers 5 // Each layer corresponds to the set of hits detected by a single sensor
#define middleLayers 3
#define adjacentLayers 2
#define numberOfNodes 16 // Each node corresponds to a "hit" picked up by a sensor
#define aboveNodes 16
#define belowNodes 16
#define acceptLink true 
#define rejectLink false
#define tripletBitWidth 20 // Each triplet corresponds to an i value (position of node in the above adjacent layer), 
							// j value (position of node in the below adjacent layer), and l value (laplacian)
#define coordinateBitWidth 12
#define nodeIndexBitWidth 4 // log_2(numberOfNodes)

/* TODO:
1. Try to break the fullSystem into its component functions and test each individually on only a single node.
2. After we prove that every function works for a single node, show each works for multiple nodes.
3. Then perform integration tests between functions for each functions to test that the data properly flows
	from each function to the next. Should be able to demonstrate that pipelining works with a small scale design
4. Perform a system test.
5. Extend the Laplacians and system code from 1 dimension to 2 dimensions.
*/

/* TODO:
1. implement coordinate generation
2. test in C++ 
3. Try to get OIT VMs and download Vitis 
*/

/*
	Sets both links corresponding to a single triplet to rejectLink in MM
	@param tripletMatrixMaximum A triplet with a Laplacian value larger than the first half of triplets in laplacianMinimums
								after it is sorted by MSS
*/
void updateLink(int tripletMatrixMaximum) {
	aboveNodeIndex = decodeAbove(tripletMatrixMaximum); 
	belowNodeIndex = decodeBelow(tripletMatrixMaximum);
	MM[1][nodeIndex][0][aboveNodeIndex] = rejectLink;
	MM[1][nodeIndex][1][belowNodeIndex] = rejectLink;
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
    return  (int) (((int) Laplacian )<<8) | ((int) aboveNodeIndex )  | (((int belowNodeIndex )<<4);
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

void singleNodeLaplacianCalculator(int aboveNodeList[aboveNodes], int belowNodeList[belowNodes], int nodeTriplets[belowNodes][aboveNodes], int nodeTripletsTranspose[belowNodes][aboveNodes], int16_t laplacianWeight, int16_t inputNode){
	#pragma HLS unroll
	// When we run singleNodeLaplacianCalculator on the transpose matrix, aboveNodeLoop actually runs through the below nodes
	aboveNodeLoop: for(int aboveNodeIndex=0; aboveNodeIndex<16; aboveNodeIndex++){
		#pragma HLS unroll
		int c1pos3 = laplacianWeight*aboveNodeList[aboveNodeIndex];
		// When we run singleNodeLaplacianCalculator on the transpose matrix, belowNodeLoop actually runs through the above nodes
		belowNodeLoop: for(int belowNodeIndex=0; belowNodeIndex<16; belowNodeIndex++) {
			#pragma HLS unroll
			// calculate the Laplacian
			int Laplacian = c1pos3 + belowNodeList[belowNodeIndex] - c3pos2; 
			// Encode the node indices and Laplacian into a 20 bit integer that represents the triplet
			int triplet = encode(aboveNodeIndex, belowNodeIndex, Laplacian);
			// Store the triplet in the corresponding array position
			nodeTriplets[aboveNodeIndex][belowNodeIndex] = triplet;
			nodeTripletsTranspose[belowNodeIndex][aboveNodeIndex] = triplet;
		}
	}
}

/*
	Given an array and two indices, swap the elements in those two indices
*/
template<class index_t, class array_t>
void exchange(array_t a[], index_t i, index_t j) {
   #pragma HLS INLINE
    array_t t = a[i];
    a[i] = a[j];
    a[j] = t;
}

// these decode functions are all potential chokepoints now that we have gone from 20 to 32 bits
/*
	Returns the Laplacian value given the 20 bit encoded triplet
	@param triplet A 20 bit integer that stores the aboveNodeIndex, belowNodeIndex, and Laplacian value corresponding to a middleLayer node
*/
int decodeLaplacian(int triplet){
    #pragma HLS INLINE
    return (int) ((triplet>>8)& 4095);
}

/*
	Returns the aboveNodeIndex value given the 20 bit encoded triplet
	@param triplet A 20 bit integer that stores the aboveNodeIndex, belowNodeIndex, and Laplacian value corresponding to a middleLayer node
*/
int decodeAboveNodeIndex(int triplet){
    #pragma HLS INLINE
    return  (int) triplet&15;
}

/*
	Returns the belowNodeIndex value given the 20 bit encoded triplet
	@param triplet A 20 bit integer that stores the aboveNodeIndex, belowNodeIndex, and Laplacian value corresponding to a middleLayer node
*/
int decodeBelowNodeIndex(int triplet){
    #pragma HLS INLINE
    return  (int) ((triplet>>4) & 15);
}

//Bitonic sort from existing codes
//Description TBD
template<class array_t, class index_t, class mask_t>
void elementLoopMinFinder(array_t a[], index_t j, mask_t mask) {
    #pragma HLS INLINE
    LOOP_OVER_ELEMENTS: for (int i=0; i<16; i++) {
        int ij=i^j;
        if ((ij)>i) {
            if ((i&mask)==0 && decodeL(a[i]) > decodeL(a[ij])){
                exchange(a,i,ij);
            } else if ((i&mask)!=0 && decodeL(a[i]) < decodeL(a[ij])){
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
template<class array_t, class int>
void MinFinder(int array[], int power){
	#pragma HLS PIPELINE II=10
    #pragma HLS ARRAY_PARTITION variable=arr complete

	for (int i=0; i<power; power++) {
		for (int j=(int)pow(2, i); j>0; j=j>>1) {
        	elementLoop(work_array, j, (int)pow(2, (i+1)));
		}
	}
    if(decodeL(array[0])>decodeL(array[(int)pow(2, power)])){ 
    	exchange(array, 0, (int)pow(2, power - 1));
    }
}

//Bitonic sort from existing codes
//Description TBD
template<class array_t, class index_t, class mask_t>
void elementLoopMSS(array_t a[], index_t j, mask_t mask) {
    #pragma HLS INLINE
    LOOP_OVER_ELEMENTS: for (int i=0; i<16; i++) {
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

template<class array_t, class int>
void Max(int array[], int power){
   #pragma HLS INLINE
    for(int i=0; i<(int)pow(2, power); i++){
        #pragma HLS unroll
        int j = i+(int)pow(2, power);
        if(arr[i]<arr[j]){
            exchange(arr, i, j);
        }
    }
}

/*
	Given an array of length pow(2, power), put the pow(2, power)/2 greatest elements in the last pow(2, power)/2 slots
	in the array
	@param array[(int)pow(2, power)] The array to be sorted
	@param power The power of two that determines how many elements are the the array
*/
template<class array_t, class int>
void MSS(int array[], int power) {
    #pragma HLS PIPELINE II=10
    #pragma HLS ARRAY_PARTITION variable=work_array complete

	for (int i=0; i<power; power++) {
		for (int j = (int)pow(2, i); j>0; j=j>>1) {
        	elementLoop(array, j, (int)pow(2, (i+1)));
		}
	}
    Max(array, power-1);
}

/*
	Given the MM global data structure, run the consensus algorithm between up links and down links:
		Between two nodes there is an up link and down link. Set the value of both links to the AND of
		the two links
	@Param MM The global data structure that encodes the "accepted links" (most likely path taken by a particle fragment between hits)
*/
void pruneGlobalMatrix(int (&MM)[totalLayers][numberOfNodes][adjacentLayers][numberOfNodes]){
	#pragma HLS array_partition variable=MM complete dim=0
	for(int middleLayer=1; middleLayer<=middleLayers; middleLayer++) {
		#pragma HLS unroll
		for(int nodeIndex=0; nodeIndex<numberOfNodes; nodeIndex++) {
			#pragma HLS unroll
			for(int correspondingNodeIndex=0; correspondingNodeIndex<numberOfNodes; correspondingNodeIndex++) {
				#pragma HLS unroll
				int aboveLayerIndex = 0;
				int belowLayerIndex = 1;
				bool linkState = MM[middleLayer+1][correspondingNodeIndex][belowLayerIndex][nodeIndex] && MM[middleLayer][nodeIndex][aboveLayerIndex][correspondingNodeIndex];
				MM[middleLayer][nodeIndex][aboveLayerIndex][correspondingNodeIndex] = linkState;
				MM[middleLayer+1][correspondingNodeIndex][belowLayerIndex][nodeIndex] = linkState;
			}
		}
	}
}

int main() {
	cout << "hello world";
}