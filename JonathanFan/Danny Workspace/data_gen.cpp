#include <iostream>
#include <vector>
#include <string>
#include <algorithm>
#include <fstream>

using namespace std;

const int  NUM_PARTICLES = 100;


int main(){
    
  ofstream myfile;
  myfile.open ("example.txt");
//j layer 
  for(int i=0;i<NUM_PARTICLES;i++){
    myfile<<rand()%1000+1<<" ";
    
  }
  myfile<<endl;
//k layer
for(int i=0;i<NUM_PARTICLES;i++){
    myfile<<rand()%1000+1<<" ";
    
  }
  myfile<<endl;


//i layer
for(int i=0;i<NUM_PARTICLES;i++){
    myfile<<rand()%1000+1<<" ";
    
  }
    myfile<<endl;


  myfile.close();
    return 0;
}