#include <iostream>
#include <vector>
#include <string>
#include <algorithm>
#include <fstream>
#include <sstream> //istringstream
using namespace std;


const int  NUM_PARTICLES = 100;
int layer1[NUM_PARTICLES];
int layer2[NUM_PARTICLES];
int layer3[NUM_PARTICLES];

void readFile(){
    ifstream inputFile;
    inputFile.open("example.txt");
    int l = 0;
    string line;
    vector <string> vec;
    int count=0;
    while(getline(inputFile,line)){
        istringstream iss(line);
        string lineStream;
        string::size_type sz;
    
        for(int i=0;i<NUM_PARTICLES;i++){
            getline(iss,lineStream,' ');
            if(count==0) layer1[i]=stoi(lineStream,&sz);
            else if(count==1) layer2[i]=stoi(lineStream,&sz);
            else if (count==2) layer3[i]=stoi(lineStream,&sz);
        }
        count++;
    
    }

}

//row k, column j
int matrix[NUM_PARTICLES][NUM_PARTICLES];

void calculate_laplacian(int mid_indx){
    //layer 1 is the k layer, layer 3 is the j layer 
    //laplacian calcualted using (k-i)-(i-j)
    int mid=layer2[mid_indx];
    for(int k=0;k<NUM_PARTICLES;k++){
        for(int j=0;j<NUM_PARTICLES;j++){
            matrix[k][j]= (layer1[k]-mid) - (mid - layer3[j]);
        }
    }
}

void writeFile(){
    ofstream myfile;
    myfile.open ("matrix.txt");
    //j layer 
    for(int i=0;i<NUM_PARTICLES;i++){
        for(int j=0;j<NUM_PARTICLES;j++){
            myfile<<matrix[i][j]<<" ";
        }
        myfile<<endl;
     
    }
    
    myfile.close();
}

int main(){

    //values to be stored in arrays layer1,layer2,layer3
    readFile();

    //evaluating current node 'mid_layer_index' at the mid layer 
    int mid_layer_index=0;
    //values to be stored in matrix 
    calculate_laplacian(mid_layer_index);

    writeFile();
    
    return 0;
}