#include <cstdlib>
#include <cmath>
#include <iostream>
#include <vector>
#include <random>
#include <fstream>
#include <string>
#include <sstream>
#include "genfuncs.h"

using namespace std;
using std::vector;
using std::abs;

int getNumHits(ifstream& hitsfile) {
  string line;
  getline(hitsfile,line);
  getline(hitsfile,line);
  return stoi(line);
}

// fill array of hits at radius r (pre-allocated), each row contains phi,z
// r should be 0,1,2,3,4 corresponding to inner,...,outer radii
void loadCSVhits_old(ifstream& hitsfile, double hitsarray[][10], int r) {
  string line,field;

  getline(hitsfile,line);
  stringstream ss(line);
  int i = 0;
  while (getline(ss,field,',')) {
    hitsarray[i][2*r] = stod(field);
    i++;
  }
  getline(hitsfile,line);
  stringstream ss2(line);
  i = 0;
  while (getline(ss2,field,',')) {
    hitsarray[i][2*r+1] = stod(field);
    i++;
  }
}


void loadCSVhits(ifstream& hitsfile, vector<double> (&hitsvec)[5][2], int r) {
    string line,field;
    getline(hitsfile,line);
    getline(hitsfile,line);
  
    getline(hitsfile,line);
    stringstream ss(line);
    int i = 0;
    while (getline(ss,field,',')) {
        hitsvec[r][0].push_back(stod(field));
        i++;
    }
    getline(hitsfile,line);
    stringstream ss2(line);
    i = 0;
    while (getline(ss2,field,',')) {
        hitsvec[r][1].push_back(stod(field));
        i++;
    }
}


void readHitFiles(vector<double> (&hitsvecs)[5][2]) {
    ifstream hitsfile_5("../generation/hitsfile_5cm.txt");
    ifstream hitsfile_10("../generation/hitsfile_10cm.txt");
    ifstream hitsfile_15("../generation/hitsfile_15cm.txt");
    ifstream hitsfile_20("../generation/hitsfile_20cm.txt");
    ifstream hitsfile_25("../generation/hitsfile_25cm.txt");

    loadCSVhits(hitsfile_5,hitsvecs,0);
    loadCSVhits(hitsfile_10,hitsvecs,1);
    loadCSVhits(hitsfile_15,hitsvecs,2);
    loadCSVhits(hitsfile_20,hitsvecs,3);
    loadCSVhits(hitsfile_25,hitsvecs,4);

    hitsfile_5.close();
    hitsfile_10.close();
    hitsfile_15.close();
    hitsfile_20.close();
    hitsfile_25.close();
}

// generate all hits from a particle, given its initial parameters
void genParticleHits(vector<double> (&hitsvecs)[5][2], double phi0, double z0, double theta0, int q, double pT) {
    double p[3] = { cos(phi0), sin(phi0), cos(theta0)/sin(theta0) }; // cartesian momentum 3-vector divided by pT
    double h[3] = { 0, 0, z0 }; // hit locations, draw circle of curvature from here. initialize where particle originates
    bool ascending = true;
    bool atod = false;
    int r = 0; // on which layer 1-5, 0 means inside layer 1
    double c[2]; // x,y coordinates of center of curvature
    while (1) {
        double roc = pT / 0.6; // radius of curvature
        if (roc < 0.025) { break; }
        if (q == 1) { c[0] = h[0] - p[1] * roc; c[1] = h[1] + p[0] * roc; }
        else { c[0] = h[0] + p[1] * roc; c[1] = h[1] - p[0] * roc;}
        double cr = sqrt(c[0]*c[0] + c[1]*c[1]); // r,phi coordinates of center of curvature
        double cphi;
        if (c[0] != 0) { cphi = atan(c[1] / c[0]); }
        else if (c[1] > 0) { cphi = pi / 2; }
        else { cphi = 3 * pi / 2; }
        if (c[0] < 0) { cphi += pi; }
        if (cphi < 0) { cphi += 2*pi; }
        if (ascending) { // update r for next hit
            if (r == 5) { ascending = false; atod = true;}
            else { ++r; }
        }
        else {
            if (r == 1) {ascending = true; }
            else { --r; }
        }
        double rr = 0.05*r; // real hit radius, in m. r-coord of hit
        double arg = (rr*rr + cr*cr - roc*roc) / (2*rr*cr);
        if (arg > 1.0 or arg < -1.0) { // particle doesn't reach that layer, so make it loop back
            if (ascending) { --r; ascending = false; }
            else { ++r; ascending = true; }
            rr = 0.05*r;
            arg = (rr*rr + cr*cr - roc*roc) / (2*rr*cr);
        }
        double delphi = acos(arg);
        if ( (q == 1 and ascending) or (q == -1 and !ascending) ) { delphi = -delphi; }
        double hphi = cphi + delphi; // phi-coord of hit
        if (hphi < 0) { hphi += 2*pi; }
        else if (hphi > 2*pi) { hphi -= 2*pi; }
        // law of cosines to find phi-distance traversed by particle between hits
        // xphi (phi-distance) to be used to find how far particle traveled in z
        double nhx = rr * cos(hphi); // next hit x,y
        double nhy = rr * sin(hphi);
        double c2 = (nhx - h[0]) * (nhx - h[0]) + (nhy - h[1]) * (nhy - h[1]);
        double a2 = (c[0] - h[0]) * (c[0] - h[0]) + (c[1] - h[1]) * (c[1] - h[1]);
        double b2 = (c[0] - nhx) * (c[0] - nhx) + (c[1] - nhy) * (c[1] - nhy);
        double xphi = acos( (a2 + b2 - c2) / (2 * sqrt(a2 * b2)) );
        if (atod) { xphi = 2*pi - xphi; } // if ascending to descending, it takes the long way around the circle
        atod = false;
        h[0] = nhx; // update particle location
        h[1] = nhy;
        h[2] += roc * xphi * p[2];
        if (h[2] > 1.0 or h[2] < -1.0) { break; } // break loop when particle exits detector
        double norm = sqrt( (c[0] - h[0]) * (c[0] - h[0]) + (c[1] - h[1]) * (c[1] - h[1]) );
        if (q == 1) { // update particle momentum direction
            p[0] = (c[1] - h[1]) / norm;
            p[1] = -(c[0] - h[0]) / norm;
        }
        else {
            p[0] = -(c[1] - h[1]) / norm;
            p[1] = (c[0] - h[0]) / norm;
        }
        // add to hitsvecs, round with pixel sizes
        hitsvecs[r-1][0].push_back( (int (hphi*rr/pixelX)) * pixelX/rr ); 
        hitsvecs[r-1][1].push_back( (int (h[2]/pixelZ)) * pixelZ );
        pT -= 0.001; // implement momentum loss 
        if (pT < 0) { break; }
    }
}

// bubble sort phi vector and shuffle z vector the same way to keep events in the same index
void phiSortHitsvecs(vector<double> (&hitsvecs)[5][2]) {
    for (int r = 0; r < 5; ++r) {
        for (int i = 0; i < hitsvecs[r][0].size()-1; i++) {
            for (int j = 0; j < hitsvecs[r][0].size()-i-1; j++) {
                if (hitsvecs[r][0][j] > hitsvecs[r][0][j+1]) {
                double temp = hitsvecs[r][0][j];
                hitsvecs[r][0][j] = hitsvecs[r][0][j+1];
                hitsvecs[r][0][j+1] = temp;
                temp = hitsvecs[r][1][j];
                hitsvecs[r][1][j] = hitsvecs[r][1][j+1];
                hitsvecs[r][1][j+1] = temp;
                }
            }
        }
    }
}

// fills hitsvec[which layer][phi or z] with hits from numProducts particles
void genTotalHits(vector<double> (&hitsvecs)[5][2]) {
    random_device dev;
    mt19937 generator(dev());
    uniform_real_distribution<double> distribution(0.0,1.0);
    for (int i = 0; i < numProducts; i++) {
        double phi0 = 2*pi*distribution(generator);
        double z0 = 0.15*2.0*(distribution(generator)-0.5);
        // double eta = 2.1*2.0*(distribution(generator)-0.5);
        double eta = 2.09*distribution(generator) + 0.01; // cut: eta > 0.01
        if (distribution(generator) > 0.5) {eta = -eta;}
        double theta0 = 2*atan(exp(-eta));
        double pT2 = -log(1.0-distribution(generator))/16.0;
        double pT = sqrt(pT2);
        int q = 1;
        if (distribution(generator) > 0.5) {  // random charge
            q = -1;
        }

        genParticleHits(hitsvecs,phi0,z0,theta0,q,pT);
    }
}


void embedSignalParticles(vector<double> (&hitsvecs)[5][2], vector<double> (&signalhits)[5][2]) {
    random_device dev;
    mt19937 generator(dev());
    uniform_real_distribution<double> distribution(0.0,1.0);
    // generate hits from signal particles and place in signalhits
    for (int p = 0; p < numSignalParticles; ++p) {
        double phi0 = 2*pi*distribution(generator);
        double z0 = 0.15*2.0*(distribution(generator)-0.5);
        // double eta = 2.1*2.0*(distribution(generator)-0.5);
        // uniformly distribute eta in (0.01,1.93)
        // higher eta particles might exit detector before reaching outer layers (only record 4 hits
        // or less), so we would need to exclude them before adding their hits to signalhits
        double eta = 1.92*distribution(generator) + 0.01; // cut: eta > 0.01
        if (distribution(generator) > 0.5) {eta = -eta;}
        double theta0 = 2*atan(exp(-eta));
        double pT = 10; // pT fixed at 10 GeV
        int q = 1;
        if (distribution(generator) > 0.5) {  // random charge
            q = -1;
        }

        genParticleHits(hitsvecs,phi0,z0,theta0,q,pT);
        genParticleHits(signalhits,phi0,z0,theta0,q,pT);
    }

}
