#include <string>
#include <sstream>
#include <iostream>
#include <fstream>
#include <vector>
#include "slicingfuncs.h"

using namespace std;




// fill two vectors for each zbin containing phi and z for each hit
// array of vectors: (which zbin, which radius, phi or z vector)
// hits array [rows][cols] has columns (phi_5, z_5, phi_10, z_10, phi_15, z_15 ...)
void fillZbins_old(vector<double> (&zbinvecs)[numZbins][5][2], double hitsarray[][10], int numRows) {
  ofstream fout("output/binedges.txt");
  fout << "bin, re, le\n";
  double re, le, zmaxr, zmaxl; // right/left edge [0,2.5] for each bin, right/left zbounds for each r
  double l = 2.5;
  for (int i = 0; i < numZbins; ++i) {
      re = l/(double(2*numZbins)) * (2*i+1-overlapZ);
      if (re > 2.45) {re = 2.45;}
      if (re < 0.05) {re = 0.05;}
      le = l/(double(2*numZbins)) * (2*i+1+overlapZ);
      if (le > 2.45) {le = 2.45;}
      if (le < 0.05) {le = 0.05;}
      fout << i << "," << re << "," << le << endl;

      for (int r = 0; r < 5; ++r) {
          // calculate right/left zbounds
          double rr = 0.05*(r+1); // r is the index, rr is the real radius
          if (re >= 0.25 and re <= 2.25) {zmaxr = 0.15 + rr/0.25*(1.1-re);}
          else if (re < 0.25) {zmaxr = 0.15 + rr*0.85/re;}
          else if (re > 2.25) {zmaxr = 0.15 + rr*1.15/(2.5-re);}
          if (le >= 0.25 and le <= 2.25) {zmaxl = -0.15 + rr/0.25*(1.4-le);}
          else if (le < 0.25) {zmaxl = -0.15 + rr*1.15/le;}
          else if (le > 2.25) {zmaxl = -0.15 + rr*0.85/(le-2.5);}

          // fill array of vectors
          for (int j = 0; j < numRows; ++j) {
              if (hitsarray[j][2*r] == 0.0 and hitsarray[j][2*r+1] == 0.0) {break;}
              else if (hitsarray[j][2*r+1] < zmaxr and hitsarray[j][2*r+1] > zmaxl) {
                  zbinvecs[i][r][0].push_back(hitsarray[j][2*r]);
                  zbinvecs[i][r][1].push_back(hitsarray[j][2*r+1]);
              }
          }
      }
  }
  fout.close();

}


void fillZbins(vector<double> (&zbinvecs)[numZbins][5][2], vector<double> (&hitsvecs)[5][2]) {
    double re, le, zmaxr, zmaxl; // right/left edge [0,2.5] for each bin, right/left zbounds for each r
    double l = 2.5;
    for (int i = 0; i < numZbins; ++i) {
        re = l/(double(2*numZbins)) * (2*i+1-overlapZ);
        if (re > 2.45) {re = 2.45;}
        if (re < 0.05) {re = 0.05;}
        le = l/(double(2*numZbins)) * (2*i+1+overlapZ);
        if (le > 2.45) {le = 2.45;}
        if (le < 0.05) {le = 0.05;}

        for (int r = 0; r < numZbins; ++r) {
            double rr = 0.05*(r+1); // r is the index, rr is the real radius
            if (re >= 0.25 and re <= 2.25) {zmaxr = 0.15 + rr/0.25*(1.1-re);}
            else if (re < 0.25) {zmaxr = 0.15 + rr*0.85/re;}
            else if (re > 2.25) {zmaxr = 0.15 + rr*1.15/(2.5-re);}
            if (le >= 0.25 and le <= 2.25) {zmaxl = -0.15 + rr/0.25*(1.4-le);}
            else if (le < 0.25) {zmaxl = -0.15 + rr*1.15/le;}
            else if (le > 2.25) {zmaxl = -0.15 + rr*0.85/(le-2.5);}

            for (int j = 0; j < hitsvecs[r][0].size(); ++j) {
                if (hitsvecs[r][1][j] < zmaxr and hitsvecs[r][1][j] > zmaxl) {
                    zbinvecs[i][r][0].push_back(hitsvecs[r][0][j]);
                    zbinvecs[i][r][1].push_back(hitsvecs[r][1][j]);
                }
            }
        }
    }
}

void phiSortZbinvecs(vector<double> (&zbinvecs)[numZbins][5][2]) {
    for (int i = 0; i < numZbins; ++i) {
        for (int r = 0; r < 5; ++r) {
            if (zbinvecs[i][r][0].size() == 0) {break;}
            for (int k = 0; k < zbinvecs[i][r][0].size()-1; ++k) {
                for (int l = 0; l < zbinvecs[i][r][0].size()-k-1; ++l) {
                    if (zbinvecs[i][r][0][l] > zbinvecs[i][r][0][l+1]) {
                        double temp = zbinvecs[i][r][0][l];
                        zbinvecs[i][r][0][l] = zbinvecs[i][r][0][l+1];
                        zbinvecs[i][r][0][l+1] = temp;
                        temp = zbinvecs[i][r][1][l];
                        zbinvecs[i][r][1][l] = zbinvecs[i][r][1][l+1];
                        zbinvecs[i][r][1][l+1] = temp;
                    }
                }
            }
        }
    }
}

// write hits in each zbin to a different file, bins 0 to numZbins-1
void writeZbinfile(ofstream& zfile, vector<double> (&zbinvecs)[numZbins][5][2], int bin) {
    zfile << "r,phi,z" << endl;
    for (int r = 0; r < 5; ++r) {
        for (int i = 0; i < zbinvecs[bin][r][0].size(); ++i) {
            zfile << 0.05*(r+1) << "," << zbinvecs[bin][r][0][i] << "," << zbinvecs[bin][r][1][i] << endl;
        }
    }
}

// (OLD) this functin runs for each slice
// returns vector (size 10) of pointers to central phi,z of each layer
// size 10 vector simulates 5x2 array
// i = zbin index, j = slice index
// needs to be updated to include sliceSeparation instead of 16
vector<double*> getSliceCvals(vector<double> (&zbinvecs)[numZbins][5][2], int i, int j, int maxpasses) {
    int indices[5] = { j * 16 };
    vector<double*> return_ptrs;
    for (int r = 1; r < 5; ++r) {
        if (zbinvecs[i][r][0].size() == 0) {
            return_ptrs.push_back(nullptr);
            return_ptrs.push_back(nullptr);
            break;
        }
        double scaling = (1.0 * zbinvecs[i][r][0].size()) / (1.0 * zbinvecs[i][0][0].size());
        indices[r] = int(j * scaling * 16);
        for (int pass; pass < maxpasses; ++pass) {
            indices[r] += (int) (zbinvecs[i][0][0][j*16] - zbinvecs[i][r][0][indices[r]]) 
                        * zbinvecs[i][r][0].size() * 1.0 / (6.28318530718);
        }
    }
    for (int r = 0; r < 5; ++r) {
        return_ptrs.push_back(&zbinvecs[i][r][0][indices[r]]);
        return_ptrs.push_back(&zbinvecs[i][r][1][indices[r]]);
    }
    return return_ptrs;
}

void indexslicer(vector<double> (&zbinvecs)[numZbins][5][2], vector<double> (&indices)[numZbins][5],
                 vector<double> (&slicedzbinvecs)[numZbins][5][16][2]) {
    for (int i = 0; i < numZbins; ++i) {
        for (int j = 0; j < zbinvecs[i][0][0].size(); j+=sliceSeparation) {       // sliceSeparation = 16 for no overlap in layer 0
            double cphival = zbinvecs[i][0][0][j];            
            indices[i][0].push_back(j);
            for (int r = 1; r < 5; ++r) {
                if (zbinvecs[i][r][0].size() == 0) {break;}
                int k = zbinvecs[i][r][0].size() * j / zbinvecs[i][0][0].size();
                double slicemidpoint = getMidpoint(zbinvecs,i,r,k);
                if (slicemidpoint < cphival) {
                    while (slicemidpoint < cphival) {
                        if (k == zbinvecs[i][r][0].size() - 1) {break;}
                        ++k;
                        slicemidpoint = getMidpoint(zbinvecs,i,r,k);
                    }
                }
                else if (slicemidpoint > cphival) {
                    while (slicemidpoint > cphival) {
                        if (k == 0) {break;}
                        --k;
                        slicemidpoint = getMidpoint(zbinvecs,i,r,k); 
                    }
                }
                indices[i][r].push_back(k);
            }
        }

        for (int j = 0; j < indices[i][0].size(); ++j) {                        // fill slicedzbinvecs
            for (int r = 0; r < 5; ++r) {
                //cout << "slice " << j << ", layer " << r << ", size of indices = " << indices[i][r].size() << endl;
                if (zbinvecs[i][r][0].size() == 0) {break;}
                int k = indices[i][r][j];
                for (int m = -8; m < 8; m++) {
                    int a = 0;
                    if (k + m < 0) {a = zbinvecs[i][r][0].size();} // set the index to be within 0,size-1
                    else if (k + m >= zbinvecs[i][r][0].size()) {a = -zbinvecs[i][r][0].size();}
                    slicedzbinvecs[i][r][m+8][0].push_back(zbinvecs[i][r][0][k+m+a]);
                    slicedzbinvecs[i][r][m+8][1].push_back(zbinvecs[i][r][1][k+m+a]);
                }
            }
        }
    }
}

// get midpoint of slice edges
// if statements to handle cases near phi = 0 or phi = 2pi
// could avoid if statements by padding start and end of zbinvecs
double getMidpoint(vector<double> (&zbinvecs)[numZbins][5][2], int i, int r, int k) {
    int size = zbinvecs[i][r][0].size();
    if (k < 8) {
        return (zbinvecs[i][r][0][k+7] + zbinvecs[i][r][0][size+k-8] - pi2) / 2.0;
    }
    else if (k > size - 8) {
        return (zbinvecs[i][r][0][k-8] + zbinvecs[i][r][0][k+7-size] + pi2) / 2.0;
    }
    else {
        return (zbinvecs[i][r][0][k-8] + zbinvecs[i][r][0][k+7]) / 2.0;
    }
}

void removeDuplicateHits(vector<double> (&zbinvecs)[numZbins][5][2]) {
    for (int i = 0; i < numZbins; ++i) {
        for (int r = 0; r < 5; ++r) {
            if (zbinvecs[i][r][0].size() == 0) {break;}
            for (int k = 0; k < zbinvecs[i][r][0].size()-1; ++k) {
                if (zbinvecs[i][r][0][k] == zbinvecs[i][r][0][k+1] and zbinvecs[i][r][1][k] == zbinvecs[i][r][1][k+1]) {
                    vector<double>::iterator it0 = zbinvecs[i][r][0].begin();
                    vector<double>::iterator it1 = zbinvecs[i][r][1].begin();
                    it0 += k;
                    it1 += k;
                    zbinvecs[i][r][0].erase(it0);
                    zbinvecs[i][r][1].erase(it1);
                }
            }
        }
    }
}

// write hit info for 2 slices, useful for missed signals
// format: for each slice, print 10 lines, 1 for each layer phi, 1 for each layer z, containing 17 entries
// [0-4] - signal hit phi, [1-16] slice j hits phi
// [5-9] - signal hit z, [1-16] slice j hits z
// [10-14] - signal hit phi, [1-16] slice j+1 hits phi
// [15-19] - signal hit z, [1-16] slice j+1 hits z
void writeSignalInfo(vector<double> (&signalhits)[5][2], vector<double> (&slicehits)[numZbins][5][16][2],
                     int p, int i, int j) {
    ofstream outfile("output/missedsignalinfo.txt", ios_base::app);
    for (int b = 0; b < 2; ++b) {
        int a = 0;
        if (j + b >= slicehits[i][0][0][0].size()) {a = slicehits[i][0][0][0].size();}
        for (int r = 0; r < 5; ++r) {
            outfile << signalhits[r][0][p];
            for (int m = 0; m < 16; ++m) {
                outfile << "," << slicehits[i][r][m][0][j+b-a];
            }
            outfile << endl;
        }
        for (int r = 0; r < 5; ++r) {
            outfile << signalhits[r][1][p];
            for (int m = 0; m < 16; ++m) {
                outfile << "," << slicehits[i][r][m][1][j+b-a];
            }
            outfile << endl;
        }
    }
    outfile.close();
}
