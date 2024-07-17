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

using namespace std;

#define _USE_MATH_DEFINES

int decodeLaplacian(int triplet){
    #pragma HLS INLINE
    return (int) (triplet>>8);
}


template<class index_t, class array_t>
void compareAndExchange(array_t a[], index_t i, index_t j, bool upOrDown) {
   #pragma HLS INLINE

   // true is down sort
   if (upOrDown == false) {
	   // i and j (which are indices) get swapped
	   int t = i;
	   i = j;
	   j = t;
   }
   if(decodeLaplacian(a[i]) > decodeLaplacian(a[j])) {
		int t = a[i];
    	a[i] = a[j];
    	a[j] = t;
    }
}

template<int32_t power> struct MaxOuter{
	template<class T>
	static void Max(T array[], int startIndex, bool down){
	   #pragma HLS INLINE
		const int powerIndex = power;
	   for(int i=startIndex; i<startIndex+(int)pow(2, powerIndex); i++){
			#pragma HLS unroll
			int j = i+(int)pow(2, powerIndex);
			compareAndExchange(array, i, j, down);
		}
	}
};

template<class T>
void FullSort(T arr[], int power, int startIndex, bool down);
/*
template<class T>
void MSSv2(T arr[], int power, int startIndex, bool down);
*/
template<int64_t power> struct MSSv2Outer;

template<int64_t power> struct FullSortOuter{
	template<class T> //switch to void and int32_t
	static T FullSort(T arr[], int startIndex, bool down) { // TODO: if start index is always 0 or 2^power/2, then replace index with a boolean and make the decision internally (via an if statement)

		const int powerIndex = power;
		const int powerIndexMinus1=power-1;
		MSSv2Outer<powerIndex>::MSSv2(arr, startIndex, down);
		return FullSortOuter<powerIndexMinus1>::FullSort(arr, startIndex, down);
		return FullSortOuter<powerIndexMinus1>::FullSort(arr, startIndex+pow(2,powerIndexMinus1), down); // should this be power, not power-1?

	}
};

template<> struct FullSortOuter<1>{
	template<class T>
	static T FullSort(T arr[], int startIndex, bool down)
	{
		compareAndExchange(arr, startIndex, startIndex+1, down);


		return arr[0];
	}
};
template<int64_t power> struct MSSv2Outer{
	template<class T>
	static void MSSv2(T arr[], int startIndex, bool down) { // startIndex is 0 for call in FullSystem; upOrDown is always down (true) for call in FullSystem
		// note: could solve the Max start index problem by using an array slice for these calls (or instead of slicing, create an array of half length with pointers to the first/second half of elements in the original array)
		if (power == 1) {
			compareAndExchange(arr, startIndex, startIndex+1, down); // always down
			// exchange for down sort
		} else {
			const int powerIndex = power-1; //needs to be constant at compile time IDK how to fix for now
			int dummy1=FullSortOuter<powerIndex>::FullSort(arr, startIndex, true); // instead of 0, have startIndex passed in from MSS param.
			int dummy2=FullSortOuter<powerIndex>::FullSort(arr, startIndex+pow(2, powerIndex), false); // have startindex + pow(2, power-1)


			MaxOuter<powerIndex>::Max(arr, startIndex, down); // need to specifiy up or down sort in max, and also need a start index since it is always working on the original length 16 array
		}
	}
};

int test[16] = {0};

void testMSSv2(){
	MSSv2Outer<4>::MSSv2(test, 0, true);
}
