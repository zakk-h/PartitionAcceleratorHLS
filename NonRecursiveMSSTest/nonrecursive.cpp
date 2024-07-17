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

template<class index_t, class array_t>
void compareAndExchange(array_t a[], index_t i, index_t j, bool upOrDown) {
   //#pragma HLS INLINE
//#pragma HLS array_partition array=a dim=0
   // true is down sort
   if (upOrDown == false) {
	   // i and j (which are indices) get swapped
	   int t = i;
	   i = j;
	   j = t;
   }
   if(a[i] > a[j]) { //decided decodelaplacian is redundan
		int t = a[i];
    	a[i] = a[j];
    	a[j] = t;
    }
}

template<class array_t, class index_t, class mask_t>// TODO: Try to understand why this piece of code works
void elementLoop(array_t a[], index_t j, mask_t mask, const int power) {
    LOOP_OVER_ELEMENTS: for (int element=0; element<(1<<power); element++) {
#pragma HLS unroll
        int iXORj=element^j;
        //cleaned up if else statement to use commpare and exchange
        if (iXORj>element) compareAndExchange(a,element,iXORj, (element&mask)==0);
    }
}

template<class T>
void Max(T array[], int power){
	int offset = 1<<power;
   #pragma HLS INLINE
    for(int i=0; i<offset; i++){
        #pragma HLS unroll
        int j = i+offset;
        compareAndExchange(array, i, j, false);

    }
}

template<class T>
void MSS(T array[], const int power) {
#pragma HLS inline //we're not sure how inline can affect the rtl design exactly (scope issues?)
    //#pragma HLS PIPELINE II=10
    //#pragma HLS ARRAY_PARTITION variable=work_array complete

	BLUE_ARROWS_LOOP: for (int i=0; i<power; i++) {
#pragma HLS pipeline off //without any pragmas vitis automatically tries to pipeline and do other optimizations that will mess with our current understanding of MSS needing to be sequential
		//DOTTED_LINE_LOOPS: for (int j = 1<<i; j>0; j=j>>1) {
//#pragma HLS pipeline off
        	//elementLoop(array, j, 2<<i, power);
		elementLoop(array, 1, 2<<i, power); //if you run synthesis and look at visualization and the scheduler, no sequential pattern can be discerned. Possible(?) reason: power/other function arguments are not being read as constant
		//}
	}
    //Max(array, power-1);
}


const int power = 2;

int data[4] = {3, 1, 4, 2};
void testMSSNonRecursive(){
	//#pragma HLS array_reshape variable=test complete
	//reshape increases resource usage vs partition and has weird errors like cannot open rtl ports for data array and cannot flatten loop because outter loop is not perfect
#pragma HLS array_partition variable=data complete
	MSS(data, power);
}
