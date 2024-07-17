#include "MSS.h"
#include <assert.h>
#include <iostream>
#include <fstream>
#include <string>
using namespace std;


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
void elementLoop(array_t a[], index_t j, mask_t mask) {
   
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

//put top 8 numbers into the first 8 slots
void Max_8(ap_int<12> arr[16]){
   #pragma HLS INLINE
    for(int i=0;i<8;i++){
        #pragma HLS unroll
        int j=i+8;
        if(arr[i]<arr[j]){
            exchange(arr,i,j);
        }
    }
}

//Replace last stage of bitonic sort with Max_8 unit
void MSS(ap_int<12> work_array[16]) {

        #pragma HLS PIPELINE II=10
        #pragma HLS ARRAY_PARTITION variable=work_array complete
        int j = 0;

        LOOP2: for (j=1; j>0; j=j>>1) {
            elementLoop(work_array,j,2);
        }

        LOOP4: for (j=2; j>0; j=j>>1) {
            elementLoop(work_array,j,4);
        }

        LOOP8: for (j=4; j>0; j=j>>1) {
            elementLoop(work_array,j,8);
        }
        Max_8(work_array);


}
