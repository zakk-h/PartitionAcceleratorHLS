#include <stdio.h>
#include <math.h>

void exchange(int array[], int a, int b){
    int temp = array[a];
    array[a] = array[b];
    array[b] = temp;
}

//inputs:int[] array for which the minimum element is to be found, int power (where the array is of length 2^power)
//output: modified array with lowest element at array[0]
void minFinder(int array[], int power){
    int length = 1<<power;
    for(int i=0; i<power; i++){
        int increment = 2<<i;
        int halfIncrement = increment/2;
        for(int j=0; j<length; j+= increment){
            if(array[j] > array[j+halfIncrement]){
                exchange(array, j, j+halfIncrement);
            }
            //printf("%d, %d", j, j+halfIncrement);
            //printf("\n");
        }
        //printf("\n");
        
    }
}