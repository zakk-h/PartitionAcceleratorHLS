#include "DummyGlobalCommunication.h"
#include <cstdio>
#include <iostream>
#include <vector>
#include <string>
#include <array>
#include <algorithm>
#include <fstream>

void visualizeMatrix(bool (&matrix)[5][16][2][16])
{
	for(int i = 0; i<5; i++)
			{
				for(int j = 0; j<16;j++)
				{
					printf("\n");
					printf("\nNode [%i][%i]", int(i), int(j));
					for(int x = 0; x<2; x++)
					{
						printf("\n");
						for(int y = 0; y<16;y++)
						{
							printf("%i ", int(matrix[i][j][x][y]));
						}
					}
				}
			}
}

int main(){
	bool testMatrix[5][16][2][16] = {{{{false}}}};
	/*
	for(int i =0; i<16; i++)
	{
		testMatrix[4][i][1][15] = true;
	}
	*/
	for(int i = 0; i<16; i++){
		testMatrix[3][15][0][i] = true;
	}
	visualizeMatrix(testMatrix);
	pruneGlobalMatrix(testMatrix);
	printf("\n Updated Matrix:");
	visualizeMatrix(testMatrix);
	return 0;
}

