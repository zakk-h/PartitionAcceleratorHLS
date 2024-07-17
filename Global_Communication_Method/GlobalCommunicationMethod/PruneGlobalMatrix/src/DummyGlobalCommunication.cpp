const int I = 5;
const int J = 4;
const int X = 2;
const int Y = 4;
#include <iostream>
#include <vector>
#include <string>
#include <algorithm>
#include <fstream>

void pruneGlobalMatrix(bool (&dummyMatrix)[I][J][X][Y]){
	#pragma HLS array_partition variable=dummyMatrix complete dim=0
	for(int i = 1; i<=I-2; i++)
		{
			#pragma HLS unroll
			for(int j = 0; j<J;j++)
			{
				#pragma HLS unroll
				for(int y = 0; y<Y; y++)
				{
					#pragma HLS unroll
					bool val = dummyMatrix[i+1][y][1][j] && dummyMatrix[i][j][0][y];
					dummyMatrix[i][j][0][y] = val;
					dummyMatrix[i+1][y][1][j] = val;
				}
			}
		}
}
