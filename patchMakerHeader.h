// gdb bin/ProcessInput
// run < CPP/wedgeData_v3_128.txt
// bt
#define VITIS_SYNTHESIS false
#define PRINT_OUTS false

#include <stdio.h>
#include <limits.h>
#include <stdlib.h>
#include <assert.h>
#include <string.h>
#include <stdbool.h>
#include <float.h>
#include <math.h>
#include <algorithm>
#include <iostream>

#if VITIS_SYNTHESIS == false
    using namespace std;
    #include <iostream>
    #include <fstream>
    #include <string>
    #include <vector>
    #include <regex>
    #include <set>
    #include <ios>
    #include <iomanip>
    #include <numeric>
#endif


#define KEEP_DELETED_PATCHES false
//make conversion ratio to micron macro

#define min(X, Y) ((X) < (Y) ? (X) : (Y))
#define max(X, Y) ((X) < (Y) ? (Y) : (X))

#define index_type int //change to unsigned int once it is verified that there are no errors

#define MAX_LAYERS 5
#define MAX_POINTS_IN_EVENT 512
#define MAX_POINTS_PER_LAYER 256    // max size of vector of points "vect" in CPP. equivalent to MAX_POINTS_PER_DATASET
#define MAX_POINTS_FOR_DATASET MAX_POINTS_PER_LAYER    // max size of vector of points "vect" in CPP

#define MAX_POINTS_IN_LINE MAX_LAYERS // a point on the line is calculated for each layer in the environment.
#define MAX_POINTS_IN_SUPERPOINT 16
#define MAX_SUPERPOINTS_IN_PATCH 5
#define MAX_PARALLELOGRAMS_PER_PATCH MAX_LAYERS - 1 // layer 1 is a vertical ribbon, the other 4 layers are sloping, so each intersects with layer 1 to make a parallelogram
#define MAX_PATCHES 32                              // upper bound, 14-18 average.
// #define MAX_LINES __ //only used in visualization
//#define MAX_SUPERPOINTS_IN_COVER (MAX_PATCHES * MAX_SUPERPOINTS_IN_PATCH)

//constant from environment that have been pulled out of structure
#define num_layers 5
#define top_layer_lim (50 * INTEGER_FACTOR_CM)
#define beam_axis_lim (15 * INTEGER_FACTOR_CM)

#define INTEGER_FACTOR_CM 1000000
#define INTEGER_FACTOR_RAD (pow(10, 7))

#define WEDGE_PATCH long (&wp_superpoints) [MAX_SUPERPOINTS_IN_PATCH][3][MAX_POINTS_IN_SUPERPOINT][3], long (&wp_parameters) [5][MAX_PARALLELOGRAMS_PER_PATCH][6]
#define GDARRAY std::array<std::array<std::array<long, 3>, MAX_POINTS_FOR_DATASET>, MAX_LAYERS> &GDarray, int (&GDn_points) [MAX_LAYERS]
#define GPATCHES long (&patches_superpoints) [MAX_PATCHES][MAX_SUPERPOINTS_IN_PATCH][3][MAX_POINTS_IN_SUPERPOINT][3], long (&patches_parameters) [MAX_PATCHES][5][MAX_PARALLELOGRAMS_PER_PATCH][6]
/*
std::array<std::array<std::array<long, 3>, MAX_POINTS_FOR_DATASET>, MAX_LAYERS> GDarray;
int GDn_points[MAX_LAYERS];

long patches_superpoints[MAX_PATCHES][MAX_SUPERPOINTS_IN_PATCH][3][MAX_POINTS_IN_SUPERPOINT][3];
long patches_parameters[MAX_PATCHES][5][MAX_PARALLELOGRAMS_PER_PATCH][6];

index_type n_patches = 0;
 */

const long radii[MAX_LAYERS] = {5 * INTEGER_FACTOR_CM, 10 * INTEGER_FACTOR_CM, 15 * INTEGER_FACTOR_CM, 20 * INTEGER_FACTOR_CM, 25 * INTEGER_FACTOR_CM};
//const float radii_leverArm[MAX_LAYERS-1] = {1, 1.333333, 2, 4};
const long int trapezoid_edges[MAX_LAYERS] = {static_cast<long>(22.0001 * INTEGER_FACTOR_CM),
                                              static_cast<long>(29.0001 * INTEGER_FACTOR_CM),
                                              static_cast<long>(36.0001 * INTEGER_FACTOR_CM),
                                              static_cast<long>(43.0001 * INTEGER_FACTOR_CM),
                                              static_cast<long>(50.0001 * INTEGER_FACTOR_CM)};
/* Deprecate Point struct into array of longs: {layer_num, phi, z}
typedef struct
{
    index_type layer_num;
    long int radius;
    long int phi;
    long int z;
} Point;
 */

/* Deprecated into two global array structures
typedef struct
{
    std::array<std::array<std::array<long, 3>, MAX_POINTS_FOR_DATASET>, MAX_LAYERS> array; // 3D array of points
    int n_points[MAX_LAYERS];                        // number of points in each layer of the array
    //index_type total_points; //not used
} DataSet;
*/

/* Deprecate Point struct into array of longs: {shadow_bottomL_jR, long shadow_bottomR_jR, long shadow_bottomL_jL, long shadow_bottomR_jL, z1_min, z1_max}
typedef struct
{
    long layer_num;

    long shadow_bottomL_jR;
    long shadow_bottomR_jR;
    long shadow_bottomL_jL;
    long shadow_bottomR_jL;

    long z1_min;
    long z1_max;
} Parallelogram;
*/

/* Deprecate wedgeSuperPoint struct into array of longs: {{{3}, {3}, {3}...}, {{1}, {1}, {1}....}, {{pC}, {min}, {max}}}
 * {points, {z_values}, {{pC}, {min}, {max}}}
typedef struct
{
    long points[MAX_POINTS_IN_SUPERPOINT][3];
    long z_values[MAX_POINTS_IN_SUPERPOINT];
    long point_count;
    long min;
    long max;
} wedgeSuperPoint;
*/

/* Deprecate wedgePatch struct into two multidimensional arrays of longs:
 * patch_superpoints -> holds superpoints parameter
 *
 * patch_parameters -> {parallelograms,
 * {{shadow_fromTopToInnermost_topL_jL}, {shadow_fromTopToInnermost_topL_jR}, {shadow_fromTopToInnermost_topR_jL}, {shadow_fromTopToInnermost_topR_jR}},
 * {a_corner, b_corner, c_corner, d_corner},
 * {{flatBottom}, {flatTop}, {squareAcceptance}, {triangleAcceptance}},
 * {{apexZ0}, {superpoint_count}, {parallelogram_count}}}
 *
 * long patch_superpoints[MAX_SUPERPOINTS_IN_PATCH][3][MAX_POINTS_IN_SUPERPOINT][3]
 * long patch_parameters[5][MAX_PARALLELOGRAMS_PER_PATCH][6]
typedef struct
{
    long apexZ0;

    long shadow_fromTopToInnermost_topL_jL;
    long shadow_fromTopToInnermost_topL_jR;
    long shadow_fromTopToInnermost_topR_jL;
    long shadow_fromTopToInnermost_topR_jR;

    long a_corner[2];
    long b_corner[2];
    long c_corner[2];
    long d_corner[2];

    long superpoints[MAX_SUPERPOINTS_IN_PATCH][3][MAX_POINTS_IN_SUPERPOINT][3]; //changed to direct assignment as opposed to pointer
    long superpoint_count;

    long flatBottom;
    long flatTop;

    long squareAcceptance;
    long triangleAcceptance;

    long parallelograms[MAX_PARALLELOGRAMS_PER_PATCH][6];
    long parallelogram_count;
} wedgePatch;
*/


void initWedgeSuperPoint(long (&wsp) [3][MAX_POINTS_IN_SUPERPOINT][3], long points[MAX_POINTS_PER_LAYER][3], int pointCount);
int areWedgeSuperPointsEqual(long wsp1[3][MAX_POINTS_IN_SUPERPOINT][3], long wsp2[3][MAX_POINTS_IN_SUPERPOINT][3]);
void wedgePatch_init(WEDGE_PATCH, long superpointsI[MAX_SUPERPOINTS_IN_PATCH][3][MAX_POINTS_IN_SUPERPOINT][3], long superpoint_count, long apexZ0I);
long straightLineProjectorFromLayerIJtoK(long z_i, long z_j, int i, int j, int k);
void getParallelograms(WEDGE_PATCH);
void getShadows(WEDGE_PATCH, long zTopMin, long zTopMax);
void get_acceptanceCorners(WEDGE_PATCH);
void add_patch(WEDGE_PATCH, index_type &n_patches, GPATCHES);
void delete_patch(int index, index_type &n_patches, GPATCHES);
index_type get_index_from_z(int layer, long z_value, GDARRAY);
void makePatches_ShadowQuilt_fromEdges(long apexZ0, int stop, int ppl, bool leftRight, index_type &n_patches, GDARRAY, GPATCHES);
long solveNextColumn(long apexZ0, int stop, int ppl, bool leftRight, bool fix42, long saved_apexZ0, index_type &n_patches, GDARRAY, GPATCHES);
void solveNextPatchPair(long apexZ0, int stop, int ppl, bool leftRight, bool fix42, long &saved_apexZ0, int &nPatchesInColumn, long &c_corner, long &projectionOfCornerToBeam, long &z_top_min, long &z_top_max, long &complementary_apexZ0, index_type &n_patches, GDARRAY, GPATCHES);
void makeThirdPatch(int lastPatchIndex, long z_top_min, long z_top_max, long complementary_apexZ0, long apexZ0, int ppl, index_type &n_patches, GDARRAY, GPATCHES);
void solveComplmentaryPatch(long &previous_white_space_height, int ppl, bool fix42, int nPatchesAtOriginal, long &previous_z_top_min, long complementary_apexZ0, long &white_space_height, index_type &lastPatchIndex, long original_c, long original_d, long &complementary_a, long &complementary_b, index_type &current_z_top_index, int &counter, int &counterUpshift, long &z_top_min, bool &repeat_patch, bool &repeat_original, index_type &n_patches, GDARRAY, GPATCHES);
void makePatch_alignedToLine(long apexZ0, long z_top, int &ppl, bool leftRight, bool float_middleLayers_ppl, index_type &n_patches, GDARRAY, GPATCHES);
void makeSuperPoint_alignedToLine(int i, long z_top, long apexZ0, float float_middleLayers_ppl, int &ppl, int original_ppl, bool leftRight, long alignmentAccuracy, long init_patch[MAX_LAYERS][3][MAX_POINTS_IN_SUPERPOINT][3], index_type &init_patch_size, GDARRAY);
bool getSolveNextPatchPairWhileCondition(int lastPatchIndex, bool repeat_patch, bool repeat_original,
                                         long white_space_height, long previous_white_space_height,
                                         int current_z_top_index, GDARRAY, GPATCHES);

bool getSolveNextColumnWhileConditional(long c_corner, int nPatchesInColumn, long projectionOfCornerToBeam);
