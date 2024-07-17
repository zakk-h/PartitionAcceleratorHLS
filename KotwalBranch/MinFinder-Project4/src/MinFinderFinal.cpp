#include <stdio.h>
#include <math.h>

void exchange(int array[16], int a, int b){
#pragma HLS INLINE
    int temp = array[a];
    array[a] = array[b];
    array[b] = temp;
}

void minLoop(int array[], int length, int incr){
#pragma HLS INLINE
	int halfIncr = incr/2;
	for(int i=0; i<length; i+= incr){
		if(array[i] > array[i+halfIncr]){
			exchange(array, i, i+halfIncr);
		}
	}
}
//inputs:int[] array for which the minimum element is to be found, int power (where the array is of length 2^power)
//output: modified array with lowest element at array[0]
void minfinder(int array[16]){
#pragma HLS ARRAY_PARTITION variable=array complete
#pragma HLS PIPELINE II=4
	int power = 3;
	int length = 1 << power;
	if(power >= 1){
		minLoop(array, length, 2);
	}
	if(power >= 2){
		minLoop(array, length, 4);
	}
	if(power >= 3){
		minLoop(array, length, 8);
	}
	if(power >= 4){
		minLoop(array, length, 16);
	}
}

