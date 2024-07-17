#include <iostream>
#include <fstream>
#include <string>
#include "MinFinder.h"
#include <ap_int.h>
#include <math.h>
#include <time.h>

using namespace std;


ap_uint<20> k_list[16]={100,30,2,4,5,6,7,8,9,10,11,12,13,14,15,16};
ap_uint<20> matrix[16][16];


ap_uint<20> encode(ap_uint<4> i,ap_uint<4> j,ap_uint<12> l){
    return  (ap_uint<20>) (((ap_uint<20>) l )<<8) | ((ap_uint<20>) i )  | (((ap_uint<20>) j )<<4);
}

ap_uint<12> decodeLapl(ap_uint<20> full){
    return (ap_uint<12>) ((full>>8)& 4095);
}

void  generateArray(){
    for (int i=0; i<16; i++){
    	ap_uint<12> l= (ap_uint<12>) rand()%200+1;
    	//Assume first row index 0.
    	k_list[i]=encode( ((ap_uint<4>) 0), ((ap_uint<4>) i),l);
        if(k_list[i]<0){
            k_list[i]=-k_list[i];
        }
    }
}

void generateMatrix(){
    for (int i=0; i<16; i++){
        for(int j=0;j<16;j++){
            ap_uint<12> l= (ap_uint<12>) rand()%200+1;
            matrix[i][j]=encode( ((ap_uint<4>) i), ((ap_uint<4>) j),l);
        }
    }
}
void printMatrix(ap_uint<20>  mat[16][16]){
     for (int i=0; i<16; i++){
        for(int j=0;j<16;j++){
           cout<< mat[i][j]<<" ";
        }
        cout<<endl;
    }
}

void print_array(ap_uint<20>* arr){
    for (int i=0; i<16; i++) {
        cout<< *arr <<" ";
        arr++;
    }
}

void printDecodedMatrix(ap_uint<20>  mat[16][16]){
     for (int i=0; i<16; i++){
        for(int j=0;j<16;j++){
           cout<< decodeLapl(mat[i][j])<<" ";
        }
        cout<<endl;
    }
}
void printDecodedArray(ap_uint<20>* arr){
    for (int i=0; i<16; i++) {
        cout<< decodeLapl(*arr) <<" ";
        arr++;
    }
}

void test_copy(ap_uint<20> m[16][16]){
  //by rows
  ap_uint<20> matrix_copy[16][16];
  copy(&m[0][0], &m[0][0]+16*16,&matrix_copy[0][0]);
  printMatrix(matrix_copy);
}

void minVerify(ap_uint<20>* arr){
	int min=INT_MAX;
	for (int i=0; i<16; i++) {
		if(decodeLapl(arr[i])<min){
			min=decodeLapl(arr[i]);
		}
	}
	cout<< "min is: " <<min <<endl;

}





int main ()
{
    //i =1, j=1 l=20
//     ap_uint<20> full=1+1*16+20*256;
//     ap_uint<4> i= (ap_uint<4>) full&15;
//     ap_uint<4>  j= (ap_uint<4>) ((full>>4) & 15);
//     ap_uint<12> l=(ap_uint<12>) ((full>>8)& 4095);
//     ap_uint<20> recombine=  (((ap_uint<20>) l )<<8) | ((ap_uint<20>) i )  | (((ap_uint<20>) j )<<4);
//     cout<<"Test Bit Masking"<<endl;
//     cout<<"full is: "<<full<<endl;
//     cout<<"i is: "<<i<<endl;
//     cout<<"j is: "<<j<<endl;
//     cout<<"l is: "<<l<<endl;
//     cout<<"recombine is: "<<recombine<<endl;
//     cout<<"END Test Bit Masking"<<endl;
//
//    cout<<"test Encode"<<endl;
//    cout<<"value is :"<<encode(i,j,l)<<endl;
//    cout<<"Finish test Encode"<<endl;
//
//     cout<<"Print Matrix"<<endl;
//     generateMatrix();
//     cout<<"finish matrix Gen"<<endl;
//     cout<<"===========================MATRIX with 20 bit======================="<<endl;
//     printMatrix(matrix);
//     cout<<"===========================MATRIX with decoded Laplacian======================="<<endl;
//     printDecodedMatrix(matrix);



    //  cout<<"Test Row Extract 0"<<endl;
    //  ap_uint<12>* test_array=matrix_to_row(matrix,0);
    //  cout<<"finish Row Extract 0"<<endl;
    //  //cout<<"test dereference pointer"<<test_array<<endl;
    //  print_array(test_array);
    //  cout<<"Finish print "<<endl;

//	 srand(time(0));
//     generateArray();
//     ap_uint<20>* work_array=k_list;
//     cout<<"START INPUT encoded work_array"<<endl;
//     print_array(work_array);
//     cout<<"END INPUT work_array"<<endl;
//     cout<<"START INPUT decoded work_array"<<endl;
//	 printDecodedArray(work_array);
//	 cout<<"END INPUT work_array"<<endl;
//
//     MinFinder_20(work_array);
//
//     cout<<"START RESULT"<<endl;
//     cout<<"START INPUT encoded work_array"<<endl;
//	  print_array(work_array);
//	  cout<<"END INPUT work_array"<<endl;
//	  cout<<"START INPUT decoded work_array"<<endl;
//	 printDecodedArray(work_array);
//	 cout<<"END INPUT work_array"<<endl;

	for(int i=0;i<10;i++){
		 srand(i);
		 generateArray();
		 ap_uint<20>* work_array=k_list;
		 cout<<"START INPUT encoded work_array"<<endl;
		 print_array(work_array);
		 cout<<"END INPUT work_array"<<endl;
		 cout<<"START INPUT decoded work_array"<<endl;
		 printDecodedArray(work_array);
		 cout<<"END INPUT work_array"<<endl;

		 MinFinder_20(work_array);

		 cout<<"START RESULT"<<endl;
		 cout<<"START INPUT encoded work_array"<<endl;
		 print_array(work_array);
		 cout<<"END INPUT work_array"<<endl;
		 cout<<"START INPUT encoded work_array"<<endl;
		 printDecodedArray(work_array);
		 cout<<"END INPUT work_array"<<endl;
		 cout<<"the first element in the output: "<<decodeLapl(work_array[0])<<endl;
		 minVerify(work_array);
		 cout<<"====================================================="<<endl;

	}



    return 0;
}
