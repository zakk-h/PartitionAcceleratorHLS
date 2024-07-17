
#include <stdio.h>
#include <iostream>
#include <stdint.h>
#include "ap_int.h"

//#define N 16


//a1: input, positions of the nodes in layer above
//a2: input, positions of nodes in layer below
//laplacians: output, laplacian values (w/o tag)
//p1: input, prefactor for pos3, c1
//c3pos2: input
void singleNodeLaplacians(ap_int<12> a1[16], ap_int<12> a2[16], ap_int<20> laplacians[16][16], ap_int<20> laplaciansT[16][16], int16_t c3pos2){


	singleNodeLaplacians_label0:for(int i=0; i<16; i++){
#pragma HLS UNROLL

			int tag_prev = i<<4;
		singleNodeLaplacians_label1:for(int j=0; j<16; j++){
#pragma HLS UNROLL
				int temp = a1[i] + a2[j] - c3pos2;
				int temp1 = temp>>8;
				int tag = tag_prev + j;
				int temp2 = temp1 + tag;
				laplacians[i][j] = temp2;

				//laplacians[i][j] = temp;
				//laplaciansT[j][i] = temp;

				//laplacians[i][j] = temp2;
				laplaciansT[j][i] = temp2;

			}
	}

}


//allLaplacians: calculates the laplaian values for all nodes in parallel
void LaplacianCalc(const ap_int<12> c1coord[5][16], const ap_int<12> c2coord[5][16],const ap_int<12> c3coord[5][16], int c1, int c2, int c3, int c4, int* ans){

	ap_int<20> laplaciansIO[3][16][16][16];
	ap_int<20> laplaciansIO_T[3][16][16][16];
	#pragma HLS ARRAY_PARTITION variable=c1coord dim=1 complete
	#pragma HLS ARRAY_PARTITION variable=c1coord dim=2 complete
	#pragma HLS ARRAY_PARTITION variable=c2coord dim=1 complete
	#pragma HLS ARRAY_PARTITION variable=c2coord dim=2 complete
	#pragma HLS ARRAY_PARTITION variable=c3coord dim=1 complete
	#pragma HLS ARRAY_PARTITION variable=c3coord dim=2 complete

	#pragma HLS ARRAY_PARTITION variable=laplaciansIO dim=1 complete
	#pragma HLS ARRAY_PARTITION variable=laplaciansIO dim=2 complete
	#pragma HLS ARRAY_RESHAPE variable=laplaciansIO dim=3 complete
	#pragma HLS ARRAY_RESHAPE variable=laplaciansIO dim=4 complete

	#pragma HLS ARRAY_PARTITION variable=laplaciansIO_T dim=1 complete
	#pragma HLS ARRAY_PARTITION variable=laplaciansIO_T dim=2 complete
	#pragma HLS ARRAY_RESHAPE variable=laplaciansIO_T dim=3 complete
	#pragma HLS ARRAY_RESHAPE variable=laplaciansIO_T dim=4 complete

	allLaplacians_label2:for(int i=0; i<16; i++){
#pragma HLS UNROLL
		singleNodeLaplacians((ap_int<12>*)c1coord[0], (ap_int<12>*) c3coord[2], laplaciansIO[0][i], laplaciansIO_T[0][i], (ap_int<12>)c2coord[1][i]);
	}





	allLaplacians_label3:for(int i=0; i<16; i++){
#pragma HLS UNROLL
		singleNodeLaplacians((ap_int<12>*)c1coord[1], (ap_int<12>*) c3coord[3], laplaciansIO[1][i], laplaciansIO_T[1][i], (ap_int<12>)c2coord[2][i]);
	}

	allLaplacians_label4:for(int i=0; i<16; i++){
#pragma HLS UNROLL
		singleNodeLaplacians((ap_int<12>*)c1coord[2], (ap_int<12>*) c3coord[4], laplaciansIO[2][i], laplaciansIO_T[2][i], (ap_int<12>)c2coord[3][i]);
	}



	*ans = laplaciansIO[c1][c2][c3][c4] + laplaciansIO_T[c1][c3][c2][c4]; //variable input ensures synthesis is performed for all nodes
	return;
}
