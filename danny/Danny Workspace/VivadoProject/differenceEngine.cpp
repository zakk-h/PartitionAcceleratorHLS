#include "differenceEngine.h"
#include <cmath>
#ifndef __SYNTHESIS__
#include <cstdio>
#endif
#include <ap_int.h>

void CalculateLaplacian(ap_int<12> j_list[16], ap_int<12> k_list[16],ap_int<12> b, ap_int<12> Laplacian_list[256]){
    ap_int<8> count =0;
    ap_int<12> c = 2*b;

    for(int j=0;j<16;j++){
        #pragma HLS UNROLL
        for(int k=0;k<16;k++){
            #pragma HLS UNROLL
            Laplacian_list[count]=j_list[j]+k_list[k]-c;
            count=count+1;
        } 
    }
}