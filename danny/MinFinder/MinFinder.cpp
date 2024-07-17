#include "MinFinder.h"
#include <iostream>

using namespace std;

//full: encode 12 bit laplacian value, 4 bit j, 4 bit i (from MSB to LSB)

//given full, return laplacian
ap_uint<12> decodeL(ap_uint<20> full){
    #pragma HLS INLINE
    return (ap_uint<12>) ((full>>8)& 4095);
}

//given full, return i
ap_uint<4> decodeI(ap_uint<20> full){
    #pragma HLS INLINE
    return  (ap_uint<4>) full&15;
}

//given full, return j
ap_uint<4> decodeJ(ap_uint<20> full){
    #pragma HLS INLINE
    return  (ap_uint<4>) ((full>>4) & 15);
}

template<class index_t, class array_t>
void exchange(array_t a[], index_t i, index_t j) {
   #pragma HLS INLINE
    array_t t = a[i];
    a[i] = a[j];
    a[j] = t;
}

//Bitonic sort from existing codes
//Description TBD
template<class array_t, class index_t, class mask_t>
void elementLoop(array_t a[], index_t j, mask_t mask) {

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

//replace last stage of bitonic sort with a simple Compare and Exchange
//between the first and last element.
void MinFinder_20 (ap_uint<20> arr[16]){
		#pragma HLS PIPELINE II=10
       #pragma HLS ARRAY_PARTITION variable=arr complete
       int j = 0;

       LOOP2: for (j=1; j>0; j=j>>1) {
           elementLoop(arr,j,2);
       }

       LOOP4: for (j=2; j>0; j=j>>1) {
           elementLoop(arr,j,4);
       }

       LOOP8: for (j=4; j>0; j=j>>1) {
           elementLoop(arr,j,8);
       }
       if(decodeL(arr[0])>decodeL(arr[15])){
    	   exchange(arr,0,15);
       }

}