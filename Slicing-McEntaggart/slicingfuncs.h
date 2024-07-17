#ifndef slicingfuncs
#define slicingfuncs

using namespace std;

const int numZbins = 10;
const double overlapZ = 1;
const int sliceSeparation = 12;
const double pi2 = 2*3.14159265359;

void fillZbins_old(vector<double> (&zbinvecs)[numZbins][5][2], double hitsarray[][10], int numRows);

void fillZbins(vector<double> (&zbinvecs)[numZbins][5][2], vector<double> (&hitsvecs)[5][2]);

void phiSortZbinvecs(vector<double> (&zbinvecs)[numZbins][5][2]);

void writeZbinfile(ofstream& zfile, vector<double> (&zbinvecs)[numZbins][5][2], int bin);

vector<double*> getSliceCvals(vector<double> (&zbinvecs)[numZbins][5][2], int i, int j, int maxpasses);

void indexslicer(vector<double> (&zbinvecs)[numZbins][5][2], vector<double> (&indices)[numZbins][5],
                 vector<double> (&slicedzbinvecs)[numZbins][5][16][2]);

double getMidpoint(vector<double> (&zbinvecs)[numZbins][5][2], int i, int r, int k);

void removeDuplicateHits(vector<double> (&zbinvecs)[numZbins][5][2]);

void writeSignalInfo(vector<double> (&signalhits)[5][2], vector<double> (&slicehits)[numZbins][5][16][2],
                     int p, int i, int j);

#endif
