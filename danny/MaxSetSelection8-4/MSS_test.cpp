#include <iostream>
#include <fstream>
#include <string>
#include "MSS.h"
#include <ap_int.h>

using namespace std;


ap_int<12> k_list[16]={16,15,14,13,12,11,10,9,8,7,6,5,4,3,2,1};
ap_int<12> matrix[100][16];


void  generateArray(){
    for (int i=0; i<16; i++){
        k_list[i]= (ap_int<12>) rand()%200+1;
        if(k_list[i]<0){
            k_list[i]=-k_list[i];
        }
    }
}

//Currently not used
void generateMatrix(){
    for (int i=0; i<100; i++){
        for(int j=0;j<16;j++){
            ap_int<12> l= (ap_int<12>) rand()%4000+1; 
            matrix[i][j]=l;
        }
    }
}

void print_array(ap_int<12> * ptr,int len){
    cout<<"START PRINT"<<endl;
    ap_int<12>* p=ptr;
    for (int i=0; i<len; i++) {
        cout<< *p <<" ";
        p++;
    }
    cout<<"END PRINT"<<endl;
}

int main ()
{
    generateArray();
    ap_int<12>* work_array=k_list;
    cout<<"START INPUT work_array"<<endl;
    print_array(work_array,16);
	MSS(work_array);
    cout<<"START RESULT"<<endl;
    print_array(work_array,16);
    return 0;
}
