#include <iostream>
#include <vector>
#include <string>
#include <algorithm>
#include <fstream>
#include <sstream> //istringstream
#include <chrono>  // for high_resolution_clock
using namespace std;

const int NUM_PARTICLES=100;
int matrix[NUM_PARTICLES][NUM_PARTICLES];

void readFile(){
     ifstream inputFile;
    inputFile.open("matrix.txt");
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
            matrix[count][i]=stoi(lineStream,&sz);
        }
        count++;
    
    }


}

bool myComparison(const pair<int,int> &a,const pair<int,int> &b)
{
       return abs(a.second)<abs(b.second);
}
//store the column min
pair<int,int> cols[NUM_PARTICLES];

void dropHalf(){
    for(int col=0;col<NUM_PARTICLES;col++){
        int min=matrix[0][col];
        for(int r=1;r<NUM_PARTICLES;r++){
            if(matrix[r][col]<min){
                min=matrix[r][col];
            }
        }
        cols[col].first=col;
        cols[col].second=min;
    }
    //sort the column min 
    sort(cols,cols+NUM_PARTICLES,myComparison);
    //<col index, col min laplacian>
    
    /*Here we take two parameters, the beginning of the
    array and the length n upto which we want the array to
    be sorted*/
    
}

void saveResult(){
    ofstream myfile;
    myfile.open ("Result.txt");
    //j layer 
    for(int i=0;i<NUM_PARTICLES/2;i++){
       
        myfile<<cols[i].first<<" "<<cols[i].second;
        
        myfile<<endl;
     
    }
    
    myfile.close();
}

int main(){


    // Record start time
    auto start = std::chrono::high_resolution_clock::now();
    int num_runs=10000;
    for(int i=0;i<num_runs;i++){
        readFile();
        dropHalf();
        //saveResult();
    }
   

    // Record end time
    auto finish = std::chrono::high_resolution_clock::now();
    std::chrono::duration<double> elapsed = finish - start;
    std::cout << "Elapsed time: " << elapsed.count()/num_runs << " s\n";
    saveResult();
    return 0;
}

