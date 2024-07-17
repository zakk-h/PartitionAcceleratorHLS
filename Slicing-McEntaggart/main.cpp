// main.cpp
// 7/14
// Gen hits, bin and slice them, need to work on functions to analyze
// 7/19
// when putting together analysis funcs header, change everything to signal
// particles instead of target particles

#include <string>
#include <sstream>
#include <iostream>
#include <fstream>
#include <vector>
#include <ctime>
#include "slicingfuncs.h"
#include "genfuncs.h"

using namespace std;

int main() {
    int numRuns = 100; // initialize number of runs
    int numHitsTotal[numZbins][5];
    int numMissedHitsTotal[numZbins][4];
    int numSignalsFoundTotal = 0;
    int numSignalsTotal = numRuns * numSignalParticles;
    int numSignalsFoundTotalZbins[numZbins];        // z-binned versions of above 2 variables
    int numSignalsTotalZbins[numZbins];
    int numSkippedParticles = 0;
    // initialize missed hit info file for analysis
    ofstream missfile("output/missedsignalinfo.txt");
    missfile << "Format: 3 slices, 15 lines for each missed particle\n";
    missfile << "See function writeSignalInfo in 'slicingfuncs.cpp' for format.\n";
    missfile << "each line: [0] = signal hit, [1-16] = slice hits\n";
    missfile.close();
    for (int run = 0; run < numRuns; ++run) {
        cout << "Running set " << run + 1 << " of " << numRuns <<  "... \n";
        vector<double> hitsvecs[5][2]; // vector of coordinate of hits, index 1 = which layer, index 2 = phi or z
        genTotalHits(hitsvecs);
        //readHitFiles(hitsvecs);

        vector<double> signalhits[5][2];
        embedSignalParticles(hitsvecs,signalhits);
        //phiSortHitsvecs(hitsvecs);

        vector<double> zbinvecs[numZbins][5][2];
        fillZbins(zbinvecs,hitsvecs);
        phiSortZbinvecs(zbinvecs);
        removeDuplicateHits(zbinvecs);

        vector<double> indices[numZbins][5];
        vector<double> slicedzbinvecs[numZbins][5][16][2];
        indexslicer(zbinvecs,indices,slicedzbinvecs);

        // analysis
        
        // hits in each zbin
        for (int i = 0; i < numZbins; ++i) {
            for (int r = 0; r < 5; ++r) {
                numHitsTotal[i][r] += zbinvecs[i][r][0].size();
            }
        }

        // % missed hits
        for (int i = 0; i < numZbins; ++i) {
            for (int r = 1; r < 5; ++r) {   // start at r=1 because we expect no missed hits at r=0
                int numMissedHits = 0;
                for (int j = 0; j < indices[i][r].size(); ++j) {
                    int nextcindex;
                    if (j == indices[i][r].size() - 1) {
                        nextcindex = zbinvecs[i][r][0].size() + indices[i][r][0];
                    }
                    else {nextcindex = indices[i][r][j+1];}
                    int thiscindex = indices[i][r][j];
                    if (nextcindex - thiscindex > 16) {
                        numMissedHits += nextcindex - thiscindex - 16;
                    }
                }
                numMissedHitsTotal[i][r-1] += numMissedHits;
            }
        }

        // get zbins for each signal particle from its hit at layer 4
        // sometimes this gives a negative bin for the particle. don't have
        // time to investigate this so i just exclude them in the next loop
        int signalzbins[numSignalParticles];
        for (int p = 0; p < numSignalParticles; ++p) {
            signalzbins[p] = (int) (4 * (1-signalhits[4][1][p])) + 1;
        }
        

        // checking for missed tracks
        // check in slicedzbinvecs if the signal particle got captured in a bin
        // look for layer 0 hit first, then check the rest of the slice
        // checking jth, (j+1)th, and (j+2)th bins at most
        for (int p = 0; p < numSignalParticles; ++p) {
            int i = signalzbins[p];
            if (abs(signalhits[4][0][p] - signalhits[3][0][p]) > 0.002) {++numSkippedParticles; continue;}
            if (i < 0 or i > 9) {++numSkippedParticles; continue;}     // skip this particle if it is behaving weird 
            ++numSignalsTotalZbins[i];
            int j = 0;
            while (slicedzbinvecs[i][0][15][0][j] < signalhits[0][0][p]) {
                if (j == slicedzbinvecs[i][0][0][0].size() - 1) {break;}
                ++j;
            }
            int count = 0;
            for (int b = 0; b < 3; ++b) {       // check in the next 3 bins at most
                int a = 0;
                if (j + b >= slicedzbinvecs[i][0][0][0].size()) {a = slicedzbinvecs[i][0][0][0].size();}
                if (slicedzbinvecs[i][0][0][0][j+b-a] > signalhits[0][0][p]) {break;} // break if the signal cannot be in this slice
                count = 0;
                for (int m = 0; m < 16; ++m) {
                    if (slicedzbinvecs[i][0][m][0][j+b-a] == signalhits[0][0][p] 
                        and slicedzbinvecs[i][0][m][1][j+b-a] == signalhits[0][1][p]) {++count; break;}
                }
                for (int m = 0; m < 16; ++m) {
                    if (slicedzbinvecs[i][1][m][0][j+b-a] == signalhits[1][0][p]
                        and slicedzbinvecs[i][1][m][1][j+b-a] == signalhits[1][1][p]) {++count; break;}
                }
                for (int m = 0; m < 16; ++m) {
                    if (slicedzbinvecs[i][2][m][0][j+b-a] == signalhits[2][0][p]
                        and slicedzbinvecs[i][2][m][1][j+b-a] == signalhits[2][1][p]) {++count; break;}
                }
                for (int m = 0; m < 16; ++m) {
                    if (slicedzbinvecs[i][3][m][0][j+b-a] == signalhits[3][0][p]
                        and slicedzbinvecs[i][3][m][1][j+b-a] == signalhits[3][1][p]) {++count; break;}
                }
                for (int m = 0; m < 16; ++m) {
                    if (slicedzbinvecs[i][4][m][0][j+b-a] == signalhits[4][0][p]
                        and slicedzbinvecs[i][4][m][1][j+b-a] == signalhits[4][1][p]) {++count; break;}
                }
                if (count == 5) {++numSignalsFoundTotal; ++numSignalsFoundTotalZbins[i]; break;}
            }
            //cout << "Particle " << p << ", bin " << i << ", slice " << j << ": count " << count << endl;
            if (count != 5) {writeSignalInfo(signalhits,slicedzbinvecs,p,i,j);}
        }

        cout << "Done. # skipped particles so far: " << numSkippedParticles;
        cout << ". Live efficiency: " << 100.0 * numSignalsFoundTotal / ((run + 1) * numSignalParticles - numSkippedParticles)
             << "%\n";
    
        //testing
        /*
        for (int r = 0; r < 5; ++r) {
            for (int j = 279; j < 282; ++j) {
                cout << "Bin 5, slice " << j << ", r " << r << ": " << slicedzbinvecs[5][r][0][0][j];
                for (int m = 1; m < 16; ++m) {
                    cout << "," << slicedzbinvecs[5][r][m][0][j];
                }
                cout << endl;
            }
        }
        */
        /*
        for (int p = 0; p < numSignalParticles; ++p) {
            for (int r = 0; r < 5; ++r) {
                cout << signalhits[r][0][p] << ",";
            }
            cout << endl;
        }
        */
        /* // write phi vals in each slice to a file
        ofstream sfile("output/slicefile.txt");
        for (int j = 0; j < 5; ++j) {
            for (int r = 0; r < 5; ++r) {
                sfile << slicedzbinvecs[1][r][0][0][j];
                for (int m = 1; m < 16; ++m) {
                    sfile << "," << slicedzbinvecs[1][r][m][0][j];
                }
                sfile << endl;
            }
        }
        sfile.close();
        */


    }


    ofstream mfile("output/metrics.txt");
    mfile << "Hits in each zbin at layers 0,1,2,3,4\n";
    for (int i = 0; i < numZbins; ++i) {
        mfile << "Bin " << i << ": " << numHitsTotal[i][0] / numRuns;
        for (int r = 1; r < 5; ++r) {
            mfile << "," << numHitsTotal[i][r] / numRuns;
        }
        mfile << endl;
    }
    mfile << "\nMissed hit % in each zbin at layers 1,2,3,4\n";
    for (int i = 0; i < numZbins; ++i) {
        mfile << "Bin " << i << ": " << 100.0 * numMissedHitsTotal[i][0] / numHitsTotal[i][1] << "%";
        for (int r = 2; r < 5; ++r) {
            mfile << ", " << 100.0 * numMissedHitsTotal[i][r-1] / numHitsTotal[i][r] << "%";
        }
        mfile << endl;
    }
    mfile << "\nOverall signal particle capture efficiency:\n";
    numSignalsTotal -= numSkippedParticles;
    mfile << 100.0 * numSignalsFoundTotal / numSignalsTotal << "%\n";
    mfile << "\nSignal particle capture efficiency by z-bin:\n";
    for (int i = 0; i < numZbins; ++i) {
        mfile << "Bin " << i << ": ";
        if (numSignalsTotalZbins[i] == 0) {mfile << "None\n";}
        else {
            mfile << 100.0 * numSignalsFoundTotalZbins[i]
                    / numSignalsTotalZbins[i] << "% (" << 
                    numSignalsFoundTotalZbins[i] << " / " <<
                    numSignalsTotalZbins[i] << ")\n";
        }
    }
    mfile.close();
}
