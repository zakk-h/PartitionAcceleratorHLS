#ifndef genfuncs
#define genfuncs

#include <cstdlib>
#include <cmath>
#include <iostream>
#include <vector>
#include <random>
#include <fstream>

const double pi = 3.1415965359;
const int numProducts = 10000;
const int numSignalParticles = 10;
const double pixelX = 0.00005;
const double pixelZ = 0.00005;

using namespace std;
using std::vector;
using std::abs;

void genParticleHits(vector<double> (&hitsvecs)[5][2], double phi0, double z0, double theta0, int q, double pT);

void phiSortHitsvecs(vector<double> (&hitsvec)[5][2]);

void genTotalHits(vector<double> (&hitsvec)[5][2]);

int getNumHits(ifstream& hitsfile);

void loadCSVhits_old(ifstream& hitsfile, double hitsarray[][10], int r);

void loadCSVhits(ifstream& hitsfile, vector<double> (&hitsvec)[5][2], int r);

void readHitFiles(vector<double> (&hitsvecs)[5][2]);

void embedSignalParticles(vector<double> (&hitsvecs)[5][2], vector<double> (&signalhits)[5][2]);



#endif
