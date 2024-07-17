#include <ap_int.h>
#include <assert.h>
#include <iostream>
#include <fstream>
#include <string>
using namespace std;

//Function to be synthesized: MSSTest(ap_int<20>[])

template<class array_t, class index_t>
void compareAndExchange(array_t a[], index_t i, index_t j, bool upOrDown) {
   #pragma HLS INLINE

   // true is down sort
   if (upOrDown == false) {
	   // i and j (which are indices) get swapped
	   int t = i;
	   i = j;
	   j = t;
   }
   if(a[i] > a[j]) {
		array_t t = a[i];
    	a[i] = a[j];
    	a[j] = t;
    }
}


template<class array_t, class index_t>
void exchange(array_t a[], index_t i, index_t j) {
    #pragma HLS INLINE
    array_t t = a[i];
    a[i] = a[j];
    a[j] = t;
}


//Bitonic sort from existing codes
//Description TBD
template<class array_t, class index_t, class mask_t>
void elementLoop(array_t a[], index_t j, mask_t mask, int const &power) {
    #pragma HLS INLINE
    // const int powerCopy;
    // memcpy(powerCopy, power, sizeof(int));
    LOOP_OVER_ELEMENTS: for (int i=0; i<(1<<power); i++) {
        int ij=i^j;


        if ((ij)>i) {

        	//test this
        	/*
            if ((i&mask)==0 && a[i] > a[ij]){
                exchange(a,i,ij);
            } else if ((i&mask)!=0 && a[i] < a[ij]){
                exchange(a,i,ij);
            }
            */

        	compareAndExchange(a,i,ij,(i&mask)==0);

        }
    }
}


//put top 8 numbers into the first 8 slots
void Max_n(ap_int<20> arr[], const int length){
   #pragma HLS INLINE
	int halfLength = length/2;
    for(int i=0;i<halfLength;i++){
        #pragma HLS unroll
        int j=i+halfLength;
        if(arr[i]<arr[j]){
            exchange(arr,i,j);
        }
    }
}

//Replace last stage of bitonic sort with Max_8 unit
void MSS(ap_int<20> work_array[], int const &power) {

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


void MSSTest(ap_int<20> work_array[16]){
	#pragma HLS ARRAY_PARTITION variable=work_array complete
	int power = 4;
	MSS(work_array, power);

}
