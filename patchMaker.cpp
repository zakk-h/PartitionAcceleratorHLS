#include "patchMakerHeader.h"

void initWedgeSuperPoint(long (&wsp) [3][MAX_POINTS_IN_SUPERPOINT][3], long points[MAX_POINTS_PER_LAYER][3], int pointCount)
{
    wsp[2][0][0] = pointCount;
    wsp[2][1][0] = LONG_MAX;
    wsp[2][2][0] = LONG_MIN;

    // more efficient approach
    // instead of making a temp array and then transferring contents, add the values directly
    // simultaneously, you can determine the min and max, as opposed to doing it after the fact
initWedgeSP_loop:
    for (int i = 0; i < pointCount; i++)
    {
        for(int z = 0; z < 3; z++)
        {
            wsp[0][i][z] = points[i][z];
        }

        wsp[1][i][0] = points[i][2];

        if (points[i][2] < wsp[2][1][0])
            wsp[2][1][0] = points[i][2];
        if (points[i][2] > wsp[2][2][0])
            wsp[2][2][0] = points[i][2];
    }
}

// operator overloading not allowed in C, write separate method to check equality
int areWedgeSuperPointsEqual(long wsp1[3][MAX_POINTS_IN_SUPERPOINT][3], long wsp2[3][MAX_POINTS_IN_SUPERPOINT][3])
{
    //return (wsp1->min == wsp2->min) && (wsp1->max == wsp2->max);
    const long tolerance = static_cast<long>(0.0001 * INTEGER_FACTOR_CM);
    return (static_cast<long>(fabs(wsp1[2][1][0] - wsp2[2][1][0])) < tolerance) && (static_cast<long>(fabs(wsp1[2][2][0] - wsp2[2][2][0])) < tolerance);
}

void getParallelograms(WEDGE_PATCH)
{
    long z1_min = max(wp_superpoints[0][2][1][0], -1 * trapezoid_edges[0]);
    long z1_max = min(wp_superpoints[0][2][2][0], trapezoid_edges[0]);

    if (z1_min > z1_max)
    {
        z1_min = trapezoid_edges[0] + INTEGER_FACTOR_CM;
        z1_max = z1_min;
    }

    // the code now handles the case below
    // if (! wp->parallelogram_count <= wp->superpoint_count - 1 ) {
    //     printf("Instead of assigning a temp array, we are overwriting the first superpoint_count-1 elements in the parallelogam array. If the current number of elements in the array is greater than superpoint_count-1, then we will have remaining elements that need to be deleted to replicate the functionality correctly");
    //     //exit(8);
    // }
    wp_parameters[4][2][0] = 0; // we want to start at index 0 regardless and overwrite any old elements in the array to replicate the functionality of assigning a temp array.
getParallelograms_loop:
    for (int i = 1; i < static_cast<int>(wp_parameters[4][1][0]); i++)
    {
        long j = static_cast<long>(i) + 1;

        long z_j_min = wp_superpoints[i][2][1][0];
        long z_j_max = wp_superpoints[i][2][2][0];

        long a = straightLineProjectorFromLayerIJtoK(z1_min, z_j_max, 1, j, num_layers);
        long b = straightLineProjectorFromLayerIJtoK(z1_max, z_j_max, 1, j, num_layers);
        long c = straightLineProjectorFromLayerIJtoK(z1_min, z_j_min, 1, j, num_layers);
        long d = straightLineProjectorFromLayerIJtoK(z1_max, z_j_min, 1, j, num_layers);

        // directly assign the values to the array
        if (static_cast<int>(wp_parameters[4][2][0]) < MAX_PARALLELOGRAMS_PER_PATCH)
        {
            wp_parameters[0][static_cast<int>(wp_parameters[4][2][0])][0] = a;
            wp_parameters[0][static_cast<int>(wp_parameters[4][2][0])][1] = b;
            wp_parameters[0][static_cast<int>(wp_parameters[4][2][0])][2] = c;
            wp_parameters[0][static_cast<int>(wp_parameters[4][2][0])][3] = d;
            wp_parameters[0][static_cast<int>(wp_parameters[4][2][0])][4] = z1_min;
            wp_parameters[0][static_cast<int>(wp_parameters[4][2][0])][5] = z1_max;

            wp_parameters[4][2][0] += 1;
        }
    }
}

void wedgePatch_init(WEDGE_PATCH, long superpointsI[MAX_SUPERPOINTS_IN_PATCH][3][MAX_POINTS_IN_SUPERPOINT][3], long superpoint_count, long apexZ0I)
{
    wp_parameters[4][0][0] = apexZ0I;

    wp_parameters[1][0][0] = 0;
    wp_parameters[1][1][0] = 0;
    wp_parameters[1][2][0] = 0;
    wp_parameters[1][3][0] = 0;

    for (size_t i = 0; i < static_cast<int>(superpoint_count); i++)
    {   // size_t objects should only be non-negative and are more performant than ints
        // wp->superpoints is an array of arrays.
        for(int a = 0; a < 3; a++)
        {
            for(int b = 0; b < MAX_POINTS_IN_SUPERPOINT; b++)
            {
                for(int c = 0; c < 3; c++)
                {
                    wp_superpoints[i][a][b][c] = superpointsI[i][a][b][c];
                }
            }
        }
    }
    wp_parameters[4][1][0] = superpoint_count;

    getParallelograms(wp_superpoints, wp_parameters);
    // getParallelograms_v1(wp);
    get_acceptanceCorners(wp_superpoints, wp_parameters);
}

long straightLineProjectorFromLayerIJtoK(long z_i, long z_j, int i, int j, int k)
{
    long radius_i = 0;
    long radius_j = 0;
    long radius_k = 0;

    if (i == 0)
    {
        radius_i = 0;
    }
    else
    {
        radius_i = radii[i - 1];
    }
    if (j == 0)
    {
        radius_j = 0;
    }
    else
    {
        radius_j = radii[j - 1];
    }
    if (k == 0)
    {
        radius_k = 0;
    }
    else
    {
        radius_k = radii[k - 1];
    }

    float radii_leverArmF = ((float) (radius_k - radius_i)) / (float) (radius_j - radius_i);

    return z_i + static_cast<long>(z_j * radii_leverArmF) - static_cast<long>(z_i * radii_leverArmF);
}

void getShadows(WEDGE_PATCH, long zTopMin, long zTopMax)
{
    long zTop_min;
    long zTop_max;
    if (num_layers - 1 < 0)
    {
        zTop_min = zTopMin;
        zTop_max = zTopMax;
    }
    else
    {
        zTop_min = max(zTopMin, -trapezoid_edges[num_layers - 1]);
        zTop_max = min(zTopMax, trapezoid_edges[num_layers - 1]);
    }

    long topL_jL[MAX_SUPERPOINTS_IN_PATCH - 1];
    long topL_jR[MAX_SUPERPOINTS_IN_PATCH - 1];
    long topR_jL[MAX_SUPERPOINTS_IN_PATCH - 1];
    long topR_jR[MAX_SUPERPOINTS_IN_PATCH - 1];
getShadows_loop:
    for (int i = 0; i < static_cast<int>(wp_parameters[4][1][0]) - 1; ++i)
    {
        int j = i + 1;
        long z_j_min = wp_superpoints[i][2][1][0];
        long z_j_max = wp_superpoints[i][2][2][0];

        topL_jL[i] = straightLineProjectorFromLayerIJtoK(zTop_min, z_j_min, num_layers, j, 1);
        topL_jR[i] = straightLineProjectorFromLayerIJtoK(zTop_min, z_j_max, num_layers, j, 1);
        topR_jL[i] = straightLineProjectorFromLayerIJtoK(zTop_max, z_j_min, num_layers, j, 1);
        topR_jR[i] = straightLineProjectorFromLayerIJtoK(zTop_max, z_j_max, num_layers, j, 1);
    }

    wp_parameters[1][0][0] = topL_jL[0];
    wp_parameters[1][1][0] = topL_jR[0];
    wp_parameters[1][2][0] = topR_jL[0];
    wp_parameters[1][3][0] = topR_jR[0];

    // finding max in each of the respective arrays and saving to designated instance variables
GSmaxFinding_loop:
    for (int i = 1; i < static_cast<int>(wp_parameters[4][1][0]) - 1; ++i)
    {
        if (topL_jL[i] > wp_parameters[1][0][0])
        {
            wp_parameters[1][0][0] = topL_jL[i];
        }
        if (topL_jR[i] < wp_parameters[1][1][0])
        {
            wp_parameters[1][1][0] = topL_jR[i];
        }
        if (topR_jL[i] > wp_parameters[1][2][0])
        {
            wp_parameters[1][2][0] = topR_jL[i];
        }
        if (topR_jR[i] < wp_parameters[1][3][0])
        {
            wp_parameters[1][3][0] = topR_jR[i];
        }
    }
}

void get_acceptanceCorners(WEDGE_PATCH)
{
    wp_parameters[3][2][0] = true;
    wp_parameters[3][1][0] = true;
    wp_parameters[3][0][0] = true;
    wp_parameters[3][3][0] = false;

    long a_corner_min = LONG_MAX;
    long b_corner_min = LONG_MAX;
    long c_corner_max = LONG_MIN;
    long d_corner_max = LONG_MIN;

    // getting min or max corners in all parallelograms
minMaxAcceptanceCorners_loop:
    for (int i = 0; i < static_cast<int>(wp_parameters[4][2][0]); ++i)
    {
        if (wp_parameters[0][i][0] < a_corner_min)
        {
            a_corner_min = wp_parameters[0][i][0];
        }
        if (wp_parameters[0][i][1] < b_corner_min)
        {
            b_corner_min = wp_parameters[0][i][1];
        }
        if (wp_parameters[0][i][2] > c_corner_max)
        {
            c_corner_max = wp_parameters[0][i][2];
        }
        if (wp_parameters[0][i][3] > d_corner_max)
        {
            d_corner_max = wp_parameters[0][i][3];
        }
    }

    // assigning to the size-2 corner arrays
    wp_parameters[2][0][0] = wp_parameters[0][0][4];
    wp_parameters[2][0][1] = a_corner_min;
    wp_parameters[2][1][0] = wp_parameters[0][0][5];
    wp_parameters[2][1][1] = b_corner_min;
    wp_parameters[2][2][0] = wp_parameters[0][0][4];
    wp_parameters[2][2][1] = c_corner_max;
    wp_parameters[2][3][0] = wp_parameters[0][0][5];
    wp_parameters[2][3][1] = d_corner_max;

    // the nth element of shadow_bottom is the same as the nth element in the corner lists in CPP
    if (a_corner_min != wp_parameters[0][num_layers - 2][0])
    {
        wp_parameters[3][2][0] = false;
        wp_parameters[3][1][0] = false;
    }
    if (b_corner_min != wp_parameters[0][num_layers - 2][1])
    {
        wp_parameters[3][2][0] = false;
        wp_parameters[3][1][0] = false;
    }
    if (c_corner_max != wp_parameters[0][num_layers - 2][2])
    {
        wp_parameters[3][2][0] = false;
        wp_parameters[3][0][0] = false;
    }
    if (d_corner_max != wp_parameters[0][num_layers - 2][3])
    {
        wp_parameters[3][2][0] = false;
        wp_parameters[3][0][0] = false;
    }

    // adjusting corners for triangle acceptance
    if (wp_parameters[2][2][1] > wp_parameters[2][0][1])
    {
        wp_parameters[3][3][0] = true;
        wp_parameters[2][2][1] = wp_parameters[2][1][1];
        wp_parameters[2][0][1] = wp_parameters[2][1][1];
    }

    if (wp_parameters[2][1][1] < wp_parameters[2][3][1])
    {
        wp_parameters[3][3][0] = true;
        wp_parameters[2][1][1] = wp_parameters[2][2][1];
        wp_parameters[2][3][1] = wp_parameters[2][2][1];
    }
}

void add_patch(WEDGE_PATCH, index_type &n_patches, GPATCHES)
{
    if (n_patches == 0)
    {
        //copy the patch directly
        for(int a = 0; a < MAX_SUPERPOINTS_IN_PATCH; a++)
        {
            for(int b = 0; b < 3; b++)
            {
                for(int c = 0; c < MAX_POINTS_IN_SUPERPOINT; c++)
                {
                    for(int d = 0; d < 3; d++)
                    {
                        patches_superpoints[0][a][b][c][d] = wp_superpoints[a][b][c][d];
                    }
                }
            }
        }

        for(int a = 0; a < 5; a++)
        {
            for(int b = 0; b < MAX_PARALLELOGRAMS_PER_PATCH; b++)
            {
                for(int c = 0; c < 6; c++)
                {
                    patches_parameters[0][a][b][c] = wp_parameters[a][b][c];
                }
            }
        }

        //cover->all_patches[0] = curr_patch;
        #if KEEP_DELETED_PATCHES == true
            cover->real_patch_list[0] = true;
        #endif
        n_patches = 1;
    }
    else
    {
        bool different = false;

        for (index_type i = 0; i < static_cast<int>(patches_parameters[n_patches - 1][4][1][0]); i++)
        {
            if ((patches_superpoints[n_patches - 1][i][2][1][0] != wp_superpoints[i][2][1][0]) ||
                (patches_superpoints[n_patches - 1][i][2][2][0] != wp_superpoints[i][2][2][0]))
            {
                different = true;
                break;
            }
        }

        // if the min and max are the same for each superpoint, don't add a patch
        if (different)
        {
            if (n_patches < MAX_PATCHES)
            {
                for(int a = 0; a < MAX_SUPERPOINTS_IN_PATCH; a++)
                {
                    for(int b = 0; b < 3; b++)
                    {
                        for(int c = 0; c < MAX_POINTS_IN_SUPERPOINT; c++)
                        {
                            for(int d = 0; d < 3; d++)
                            {
                                patches_superpoints[n_patches][a][b][c][d] = wp_superpoints[a][b][c][d];
                            }
                        }
                    }
                }

                for(int a = 0; a < 5; a++)
                {
                    for(int b = 0; b < MAX_PARALLELOGRAMS_PER_PATCH; b++)
                    {
                        for(int c = 0; c < 6; c++)
                        {
                            patches_parameters[n_patches][a][b][c] = wp_parameters[a][b][c];
                        }
                    }
                }
                //cover->all_patches[cover->n_patches] = curr_patch;
                #if KEEP_DELETED_PATCHES == true
                    cover->real_patch_list[cover->n_patches] = true;
                #endif
                n_patches += 1;
            }
        }
    }
}

void delete_patch(int index, index_type &n_patches, GPATCHES)
{
    if (index < 0 || index >= n_patches)
    {
        return;
    }
    #if KEEP_DELETED_PATCHES == true
        cover->real_patch_list[index] = false;
    #endif
    for (index_type i = index; i < n_patches - 1; i++)
    {
        for(int a = 0; a < MAX_SUPERPOINTS_IN_PATCH; a++)
        {
            for(int b = 0; b < 3; b++)
            {
                for(int c = 0; c < MAX_POINTS_IN_SUPERPOINT; c++)
                {
                    for(int d = 0; d < 3; d++)
                    {
                        patches_superpoints[i][a][b][c][d] = patches_superpoints[i + 1][a][b][c][d];
                    }
                }
            }
        }

        for(int a = 0; a < 5; a++)
        {
            for(int b = 0; b < MAX_PARALLELOGRAMS_PER_PATCH; b++)
            {
                for(int c = 0; c < 6; c++)
                {
                    patches_parameters[i][a][b][c] = patches_parameters[i + 1][a][b][c];
                }
            }
        }
        #if KEEP_DELETED_PATCHES == true
            cover->real_patch_list[i] = cover->real_patch_list[i + 1];
        #endif
    }

    // resetting the last elements

    memset(&patches_superpoints[n_patches - 1], 0, sizeof(patches_superpoints[n_patches - 1]));
    memset(&patches_parameters[n_patches - 1], 0, sizeof(patches_parameters[n_patches - 1]));
    #if KEEP_DELETED_PATCHES == true
        cover->real_patch_list[cover->n_patches - 1] = false;
    #endif

    n_patches -= 1;
}

// can't provide default parameters
index_type get_index_from_z(int layer, long z_value, GDARRAY)
{
    // c doesn't support string comparison directly, using integer comparison for effiency
    // CLOSEST = 11, ABOVE = 12, BELOW = 13
    long minVal = LONG_MAX;
    index_type index = 0;
getIndexFromZ_loop:
    for (index_type i = 0; i < GDn_points[layer]; i++)
    {
        long diff = static_cast<long>(fabs(GDarray[layer][i][2] - z_value)); // absolute difference
        if (diff < minVal)
        {
            minVal = diff;
            index = i;
        }
    }

    //alignment always equals closest so we can just return index
    return index;
}

void makePatches_ShadowQuilt_fromEdges(long apexZ0, int stop, int ppl, bool leftRight, index_type &n_patches, GDARRAY, GPATCHES) // TOP-LEVEL FUNCTION FOR VITIS
{
    bool fix42 = true;
    apexZ0 = trapezoid_edges[0];
    long saved_apexZ0;
shadowQuilt_loop:
    while (apexZ0 > -1 * trapezoid_edges[0]) //consider how this works when we are expanding instead of retracting the trapezoid_edges
    {
        apexZ0 = solveNextColumn(apexZ0, stop, ppl, leftRight, fix42, saved_apexZ0, n_patches, GDarray, GDn_points, patches_superpoints, patches_parameters);
        saved_apexZ0 = apexZ0;
    }
}

long solveNextColumn(long apexZ0, int stop, int ppl, bool leftRight, bool fix42, long saved_apexZ0, index_type &n_patches, GDARRAY, GPATCHES)
{
    long z_top_min = -1 * top_layer_lim;

    long complementary_apexZ0 = 0;
    index_type first_row_count = 0;
    long c_corner = LONG_MAX;

    long z_top_max = top_layer_lim;

    if (n_patches > 0)
    {
        z_top_max = min(z_top_max, straightLineProjectorFromLayerIJtoK(-1 * beam_axis_lim, apexZ0, 0, 1, num_layers // includes passing a pointer to the last patch
                        ));
    }

    index_type nPatchesInColumn = 0;
    long projectionOfCornerToBeam = 0;
    //returnArray[6] = {nPatchesInColumn, c_corner, projectionOfCornerToBeam, z_top_min, z_top_max, complementary_apexZ0}
    //remove nPatchesInColumn once debugging finishes
solveNextColumn_loop:
    while(getSolveNextColumnWhileConditional(c_corner, nPatchesInColumn, projectionOfCornerToBeam))
    {
        solveNextPatchPair(apexZ0, stop, ppl, leftRight, fix42, saved_apexZ0, nPatchesInColumn, c_corner, projectionOfCornerToBeam, z_top_min, z_top_max, complementary_apexZ0, n_patches, GDarray, GDn_points, patches_superpoints, patches_parameters);
    }

    apexZ0 = patches_parameters[n_patches - 1][2][3][0];
    apexZ0 = saved_apexZ0;
    #if PRINT_OUTS == true
        printf("'=======================================================  z1_Align: %ld\n", apexZ0);
    #endif

    return apexZ0;
}

bool getSolveNextColumnWhileConditional(long c_corner, int nPatchesInColumn,
                                        long projectionOfCornerToBeam) { return (c_corner > -1 * trapezoid_edges[num_layers - 1]) && (nPatchesInColumn < 100000000) && (projectionOfCornerToBeam < beam_axis_lim); }

void solveNextPatchPair(long apexZ0, int stop, int ppl, bool leftRight, bool fix42, long &saved_apexZ0, int &nPatchesInColumn, long &c_corner, long &projectionOfCornerToBeam, long &z_top_min, long &z_top_max, long &complementary_apexZ0, index_type &n_patches, GDARRAY, GPATCHES)
{
    nPatchesInColumn++;
    #if PRINT_OUTS == true
        printf("%ld %d %ld %d\n", apexZ0, ppl, z_top_max, leftRight);
    #endif

    makePatch_alignedToLine(apexZ0, z_top_max, ppl, false, false, n_patches, GDarray, GDn_points, patches_superpoints, patches_parameters);

    index_type lastPatchIndex = n_patches - 1;

    #if PRINT_OUTS == true
        printf("top layer from %ld to %ld z_top_max: %ld\n",
                patches_superpoints[lastPatchIndex][num_layers - 1][2][2][0],
                patches_superpoints[lastPatchIndex][num_layers - 1][2][1][0],
                z_top_max);
        printf("original: [%ld, %ld] for patch %d\n",
                patches_parameters[lastPatchIndex][2][0][0],
                patches_parameters[lastPatchIndex][2][0][1],
                n_patches);
        printf("original: [%ld, %ld]\n",
                patches_parameters[lastPatchIndex][2][1][0],
                patches_parameters[lastPatchIndex][2][1][1]);

        printf("original: [%ld, %ld]\n",
                patches_parameters[lastPatchIndex][2][2][0],
                patches_parameters[lastPatchIndex][2][2][1]);

        printf("original: [%ld, %ld]\n",
                patches_parameters[lastPatchIndex][2][3][0],
                patches_parameters[lastPatchIndex][2][3][1]);

        for (index_type i = 1; i < static_cast<int>(patches_parameters[lastPatchIndex][4][1][0]) - 1; i++)
        {
            index_type j = i + 1;
            printf("%d superpoint: %ld %ld shadowTop from L1Max: %ld %ld from L1 min: %ld %ld\n",
                    j,
                    patches_superpoints[lastPatchIndex][i][2][1][0],
                    patches_superpoints[lastPatchIndex][i][2][2][0],
                    straightLineProjectorFromLayerIJtoK(patches_superpoints[lastPatchIndex][0][2][2][0], patches_superpoints[lastPatchIndex][i][2][1][0], 1, j, num_layers),
                    straightLineProjectorFromLayerIJtoK(patches_superpoints[lastPatchIndex][0][2][2][0], patches_superpoints[lastPatchIndex][i][2][2][0], 1, j, num_layers),
                    straightLineProjectorFromLayerIJtoK(patches_superpoints[lastPatchIndex][0][2][1][0], patches_superpoints[lastPatchIndex][i][2][1][0], 1, j, num_layers),
                    straightLineProjectorFromLayerIJtoK(patches_superpoints[lastPatchIndex][0][2][1][0], patches_superpoints[lastPatchIndex][i][2][2][0], 1, j, num_layers));
        }
    #endif

    long original_c = patches_parameters[lastPatchIndex][2][2][1];
    long original_d = patches_parameters[lastPatchIndex][2][3][1];

    c_corner = original_c;

    bool repeat_patch = false;
    bool repeat_original = false;

    // code written assuming number of layers is 5.
    /*
    if (cover->n_patches > 2) {
        int thirdLastPatchIndex = lastPatchIndex - 2;
        repeat_original = (cover->patches[lastPatchIndex].superpoints[num_layers - 1] == cover->patches[thirdLastPatchIndex].superpoints[num_layers - 1]) &&
                (cover->patches[lastPatchIndex].superpoints[0] == cover->patches[thirdLastPatchIndex].superpoints[0]) &&
                (cover->patches[lastPatchIndex].superpoints[1] == cover->patches[thirdLastPatchIndex].superpoints[1]) &&
                (cover->patches[lastPatchIndex].superpoints[2] == cover->patches[thirdLastPatchIndex].superpoints[2]) &&
                (cover->patches[lastPatchIndex].superpoints[3] == cover->patches[thirdLastPatchIndex].superpoints[3]);
    }
    */
    // dynamic version below
    if (n_patches > 2)
    {
        index_type thirdLastPatchIndex = lastPatchIndex - 2;
        repeat_original = true; // assume they are the same initially
    superPointEqualCheck_loop:
        for (index_type i = 0; i < MAX_SUPERPOINTS_IN_PATCH; i++)
        { // iterating over the first (five) superpoints
            if (!areWedgeSuperPointsEqual(patches_superpoints[lastPatchIndex][i], patches_superpoints[thirdLastPatchIndex][i]))
            {
                repeat_original = false; // if any pair of superpoints don't match, set to false
                break;                   // no need to check further if a mismatch is found
            }
        }
    }

    long seed_apexZ0 = apexZ0;
    projectionOfCornerToBeam = straightLineProjectorFromLayerIJtoK(patches_parameters[lastPatchIndex][2][2][1], patches_parameters[lastPatchIndex][2][2][0], num_layers, 1, 0);
    bool squarePatch_alternate1 = (patches_parameters[lastPatchIndex][2][0][1] > z_top_max) && (patches_parameters[lastPatchIndex][2][1][1] > z_top_max) && (patches_parameters[lastPatchIndex][3][0][0]);
    bool squarePatch_alternate2 = (patches_parameters[lastPatchIndex][2][0][1] > z_top_max) && (patches_parameters[lastPatchIndex][3][0][0]);

    bool notChoppedPatch = (patches_parameters[lastPatchIndex][3][2][0]) || squarePatch_alternate1 || squarePatch_alternate2;
    bool madeComplementaryPatch = false;

    int nPatchesAtOriginal = n_patches;
    #if PRINT_OUTS == true
    printf("squareAcceptance: %d triangleAcceptance: %d projectionOfCornerToBeam: %ld notChoppedPatch %d\n",
           patches_parameters[lastPatchIndex][3][2][0], patches_parameters[lastPatchIndex][3][3][0],projectionOfCornerToBeam, notChoppedPatch);
    #endif

    if (!notChoppedPatch && (patches_parameters[lastPatchIndex][2][2][1] > -1 * trapezoid_edges[num_layers - 1]) && ((projectionOfCornerToBeam < beam_axis_lim)))
    {
        complementary_apexZ0 = patches_superpoints[lastPatchIndex][0][2][1][0];
        if (patches_parameters[lastPatchIndex][3][3][0] && !repeat_original)
        {
            z_top_min = patches_parameters[lastPatchIndex][2][3][1];
        }
        else
        {
            #if PRINT_OUTS == true
                printf("z_top_min before: %ld superpoints[self.env.num_layers-1][2][1][0]: %ld\n", z_top_min, patches_superpoints[lastPatchIndex][num_layers - 1][2][1][0]);
            #endif
                z_top_min = max(-1 * top_layer_lim, patches_superpoints[lastPatchIndex][num_layers - 1][2][1][0]);

        }

        makePatch_alignedToLine(complementary_apexZ0, z_top_min, ppl, true, false, n_patches, GDarray, GDn_points, patches_superpoints, patches_parameters);
        // updating the last patch index because makePatch_alignedToLine will add more patches to the patches array. Should revisit after writing method
        // makePatch_alignedToLine will call the add patch method, so we must get a new last patch index.
        lastPatchIndex = n_patches - 1;

        madeComplementaryPatch = true;
        #if PRINT_OUTS == true
            printf("complementary: [%ld, %ld] for z_top_min: %ld\n", patches_parameters[lastPatchIndex][2][0][0], patches_parameters[lastPatchIndex][2][0][1], z_top_min);
            printf("complementary: [%ld, %ld] for patch %d\n", patches_parameters[lastPatchIndex][2][1][0], patches_parameters[lastPatchIndex][2][1][1], n_patches);
            printf("complementary: [%ld, %ld]\n", patches_parameters[lastPatchIndex][2][2][0], patches_parameters[lastPatchIndex][2][2][1]);
            printf("complementary: [%ld, %ld]\n", patches_parameters[lastPatchIndex][2][3][0], patches_parameters[lastPatchIndex][2][3][1]);
        #endif

        long complementary_a = patches_parameters[lastPatchIndex][2][0][1];
        long complementary_b = patches_parameters[lastPatchIndex][2][1][1];

        long white_space_height = max(original_c - complementary_a, original_d - complementary_b);
        long previous_white_space_height = -1 * INTEGER_FACTOR_CM;
        int counter = 0;
        int counterUpshift = 0;
        index_type current_z_top_index = -1;
        long previous_z_top_min = -999 * INTEGER_FACTOR_CM;
    solvePatchPair_loop:
        while (getSolveNextPatchPairWhileCondition(lastPatchIndex, repeat_patch, repeat_original, white_space_height,
                                                   previous_white_space_height, current_z_top_index, GDarray, GDn_points, patches_superpoints, patches_parameters))
        {
            solveComplmentaryPatch(previous_white_space_height, ppl, fix42, nPatchesAtOriginal, previous_z_top_min, complementary_apexZ0, white_space_height, lastPatchIndex, original_c, original_d, complementary_a, complementary_b, current_z_top_index, counter, counterUpshift, z_top_min, repeat_patch, repeat_original, n_patches, GDarray, GDn_points, patches_superpoints, patches_parameters);
        }

    }

    lastPatchIndex = n_patches - 1; // just to keep fresh in case we use it
    c_corner = patches_parameters[lastPatchIndex][2][2][1];

    projectionOfCornerToBeam = straightLineProjectorFromLayerIJtoK(c_corner, patches_parameters[lastPatchIndex][2][2][0], num_layers, 1, 0);

    saved_apexZ0 = patches_parameters[lastPatchIndex][2][2][0];

    if (madeComplementaryPatch) // Create separate function for this
    {
        makeThirdPatch(lastPatchIndex, z_top_min, z_top_max, complementary_apexZ0, apexZ0, ppl, n_patches, GDarray, GDn_points, patches_superpoints, patches_parameters);
    }

    z_top_max = c_corner;
    #if PRINT_OUTS == true
        printf("+++++++++++++++++++++++ c_corner: %ld\n", c_corner);
    #endif
}

bool getSolveNextPatchPairWhileCondition(int lastPatchIndex, bool repeat_patch, bool repeat_original,
                                         long white_space_height, long previous_white_space_height,
                                         int current_z_top_index, GDARRAY, GPATCHES) {
    return !(white_space_height <= static_cast<long>(0.0000005 * INTEGER_FACTOR_CM) && (previous_white_space_height >= 0)) && (fabs(white_space_height) > static_cast<long>(0.000005 * INTEGER_FACTOR_CM)) &&
               ((patches_parameters[lastPatchIndex][2][2][1] > -1 * trapezoid_edges[num_layers - 1]) ||
                    (white_space_height > static_cast<long>(0.000005 * INTEGER_FACTOR_CM))) &&
               (current_z_top_index < (int)(GDn_points[num_layers - 1])) &&
               !(repeat_patch) && !(repeat_original);
}

void makeThirdPatch(index_type lastPatchIndex, long z_top_min, long z_top_max, long complementary_apexZ0, long apexZ0, int ppl, index_type &n_patches, GDARRAY, GPATCHES)
{
    index_type secondLastPatchIndex = lastPatchIndex - 1;

    // modifying patches, not adding patches, so index variables do not need to be updated.
    getShadows(patches_superpoints[lastPatchIndex], patches_parameters[lastPatchIndex], z_top_min, z_top_max);
    getShadows(patches_superpoints[secondLastPatchIndex], patches_parameters[secondLastPatchIndex], z_top_min, z_top_max);

    long original_topR_jL = patches_parameters[secondLastPatchIndex][1][2][0];
    bool originalPartialTop = (original_topR_jL > complementary_apexZ0) && (original_topR_jL < apexZ0) &&
                                (fabs(straightLineProjectorFromLayerIJtoK(original_topR_jL, z_top_max, 1, num_layers, 0)) < 20 * beam_axis_lim);

    long original_topL_jL = patches_parameters[secondLastPatchIndex][1][0][0];

    bool originalPartialBottom = (original_topL_jL > complementary_apexZ0) && ((original_topL_jL - apexZ0) < static_cast<long>(-0.0001 * INTEGER_FACTOR_CM)) &&
                                    (fabs(straightLineProjectorFromLayerIJtoK(original_topL_jL,z_top_min, 1, num_layers, 0)) < 20 * beam_axis_lim);

    long complementary_topR_jR = patches_parameters[lastPatchIndex][1][3][0];

    bool complementaryPartialTop = ((complementary_topR_jR - complementary_apexZ0) > static_cast<long>(0.00005 * INTEGER_FACTOR_CM)) && (complementary_topR_jR < apexZ0) && // The use of 0.00005 is "hack" to prevent a couple of wedges from creating extra patches,
                                    (fabs(straightLineProjectorFromLayerIJtoK(complementary_topR_jR, z_top_max, 1, num_layers, 0)) < 20 * beam_axis_lim);

    long complementary_topL_jR = patches_parameters[lastPatchIndex][1][1][0];

    bool complementaryPartialBottom = (complementary_topL_jR > complementary_apexZ0) && ((complementary_topL_jR - apexZ0) < static_cast<long>(-0.0001 * INTEGER_FACTOR_CM)) &&
                                        (fabs(straightLineProjectorFromLayerIJtoK(complementary_topL_jR,z_top_min, 1, num_layers, 0)) < 20 * beam_axis_lim);

    long horizontalShiftTop = original_topR_jL - complementary_topR_jR;
    long horizontalShiftBottom = original_topL_jL - complementary_topL_jR;

    long complementary_topR_jL = patches_parameters[lastPatchIndex][1][2][0];
    long complementary_topL_jL = patches_parameters[lastPatchIndex][1][0][0];
    long original_topR_jR = patches_parameters[secondLastPatchIndex][1][3][0];
    long original_topL_jR = patches_parameters[secondLastPatchIndex][1][1][0];

    long horizontalOverlapTop = max(complementary_topR_jL - original_topR_jL, complementary_topR_jR - original_topR_jR);
    long horizontalOverlapBottom = max(complementary_topL_jL - original_topL_jL, complementary_topL_jR - original_topL_jR);

    horizontalOverlapTop = -1 * INTEGER_FACTOR_CM;
    horizontalOverlapBottom = -1 * INTEGER_FACTOR_CM;
    long newGapTop = static_cast<long>(-0.000001 * INTEGER_FACTOR_CM);
    long newGapBottom = static_cast<long>(-0.000001 * INTEGER_FACTOR_CM);

    bool makeHorizontallyShiftedPatch = false;
    long shifted_Align = apexZ0;
    bool doShiftedPatch = true;

    long newZtop = 0;

    long z0_original_bCorner = straightLineProjectorFromLayerIJtoK(apexZ0, z_top_max, 1, num_layers, 0);
    long z0_complementary_cCorner = straightLineProjectorFromLayerIJtoK(complementary_apexZ0,z_top_min, 1, num_layers, 0);
    bool shiftOriginal = true;

    if (z0_original_bCorner < 0)
    {
        shiftOriginal = false;
        shifted_Align = complementary_apexZ0;
    }

    if (z0_complementary_cCorner > 0)
    {
        shiftOriginal = true;
        shifted_Align = apexZ0;
    }

    //if (horizontalShiftTop > 0 || horizontalShiftBottom > 0)
    if (horizontalShiftTop > static_cast<long>(0.000001*INTEGER_FACTOR_CM) || horizontalShiftBottom > 0) // NOTE THAT horizontalShiftTop > 0.000001 is a "hack" to avoid infinite loop from Wedge 42 in this condition and the next
    {
        #if PRINT_OUTS == true
            printf("originalPartialTop: %d complementaryPartialTop: %d originalPartialBottom: %d complementaryPartialBottom: %d %ld %ld %ld %ld horizontalOverlapTop: %ld horizontalOverlapBottom: %ld\n",
                originalPartialTop, complementaryPartialTop, originalPartialBottom, complementaryPartialBottom,
                original_topR_jL, original_topL_jL, complementary_topR_jR, complementary_topL_jR,
                horizontalOverlapTop, horizontalOverlapBottom);
        #endif
    }
thirdPatch_loop:
    while ((((horizontalShiftTop > static_cast<long>(0.000001*INTEGER_FACTOR_CM)) && originalPartialTop && complementaryPartialTop) || ((horizontalShiftBottom > static_cast<long>(0.000001*INTEGER_FACTOR_CM)) && originalPartialBottom && complementaryPartialBottom)) && doShiftedPatch && (horizontalOverlapTop <= 0) && (horizontalOverlapBottom <= 0) && ((newGapTop <= 0) || (newGapBottom <= 0)))
    {
        #if PRINT_OUTS == true
            printf("horizontalShifts: %ld %ld shifted_Align: %ld\n", horizontalShiftTop, horizontalShiftBottom, shifted_Align);
        #endif

        newZtop = z_top_max;

        if (shiftOriginal)
        {
            shifted_Align -= max(horizontalShiftTop, horizontalShiftBottom);
        }
        else
        {
            shifted_Align += max(horizontalShiftTop, horizontalShiftBottom);
            newZtop = z_top_min;
        }

        if (makeHorizontallyShiftedPatch)
        {
            delete_patch(n_patches - 1, n_patches, patches_superpoints, patches_parameters);
            // decrement n_patches is handled by delete_patch
        }

        makePatch_alignedToLine(shifted_Align, newZtop, ppl, !shiftOriginal, false, n_patches, GDarray, GDn_points, patches_superpoints, patches_parameters);

        getShadows(patches_superpoints[n_patches - 1], patches_parameters[n_patches - 1], z_top_min, z_top_max);

        if (shiftOriginal)
        {
            original_topR_jL = patches_parameters[n_patches - 1][1][2][0];
            original_topL_jL = patches_parameters[n_patches - 1][1][0][0];
            original_topR_jR = patches_parameters[n_patches - 1][1][3][0];
            original_topL_jR = patches_parameters[n_patches - 1][1][1][0];
        }
        else
        {
            complementary_topR_jR = patches_parameters[n_patches - 1][1][3][0];
            complementary_topL_jR = patches_parameters[n_patches - 1][1][1][0];
            complementary_topR_jL = patches_parameters[n_patches - 1][1][2][0];
            complementary_topL_jL = patches_parameters[n_patches - 1][1][0][0];
        }

        horizontalShiftTop = original_topR_jL - complementary_topR_jR;
        horizontalShiftBottom = original_topL_jL - complementary_topL_jR;

        if (shiftOriginal && straightLineProjectorFromLayerIJtoK(original_topR_jR, z_top_max, 1, num_layers, 0) < beam_axis_lim)
        {
            horizontalOverlapTop = max(complementary_topR_jL - original_topR_jL, complementary_topR_jR - original_topR_jR);
            horizontalOverlapBottom = max(complementary_topL_jL - original_topL_jL, complementary_topL_jR - original_topL_jR);
            #if PRINT_OUTS == true
                printf(" horizontalOverlapTop: %ld horizontalOverlapBottom: %ld\n", horizontalOverlapTop, horizontalOverlapBottom);
            #endif
        }
        #if PRINT_OUTS == true
            printf("original_topR_jL: %ld complementary_topR_jR %ld original_topL_jL %ld complementary_topL_jR %ld shiftOriginal %d\n",
                original_topR_jL, complementary_topR_jR, original_topL_jL, complementary_topL_jR, shiftOriginal);
        #endif

        makeHorizontallyShiftedPatch = true;
        #if PRINT_OUTS == true
            printf("updated_horizontalShifts: %ld %ld shifted_Align: %ld\n", horizontalShiftTop, horizontalShiftBottom, shifted_Align);
        #endif
    }
    if (makeHorizontallyShiftedPatch)
    {
        if ((straightLineProjectorFromLayerIJtoK(shifted_Align, newZtop, 1, num_layers, 0) > beam_axis_lim) && shiftOriginal)
        {
            if (n_patches > 2)
            {
                delete_patch(n_patches - 3, n_patches, patches_superpoints, patches_parameters);
            }
        }
    }
}

void solveComplmentaryPatch(long &previous_white_space_height, int ppl, bool fix42, int nPatchesAtOriginal, long &previous_z_top_min, long complementary_apexZ0, long &white_space_height, index_type &lastPatchIndex, long original_c, long original_d, long &complementary_a, long &complementary_b, index_type &current_z_top_index, int &counter, int &counterUpshift, long &z_top_min, bool &repeat_patch, bool &repeat_original, index_type &n_patches, GDARRAY, GPATCHES)
{
    #if PRINT_OUTS == true
        printf("\n");
    #endif
    if (n_patches > 2)
    {
        index_type secondLastPatchIndex = lastPatchIndex - 1;
        #if PRINT_OUTS == true
            printf("original c: %ld %ld || original d: %ld %ld\n",
                original_c, patches_parameters[secondLastPatchIndex][2][2][1],
                original_d, patches_parameters[secondLastPatchIndex][2][3][1]);
        #endif
    }
    #if PRINT_OUTS == true
        printf("complementary_a: %ld %ld || complementary_b: %ld %ld\n",
            complementary_a, patches_parameters[lastPatchIndex][2][0][1],
            complementary_b, patches_parameters[lastPatchIndex][2][1][1]);
    #endif

    current_z_top_index = get_index_from_z(num_layers - 1,z_top_min, GDarray, GDn_points);
    #if PRINT_OUTS == true
        printf("current white_space_height: %ld\n", white_space_height);
        printf("counter: %d counterUpshift: %d\n", counter, counterUpshift);
        printf("orig_ztop: %d orig_z_top_min: %ld\n", current_z_top_index,z_top_min);
    #endif

    index_type current_z_i_index[MAX_LAYERS];
    index_type new_z_i_index[MAX_LAYERS];

    for (index_type i = 0; i < num_layers; i++)
    {
        current_z_i_index[i] = get_index_from_z(i, straightLineProjectorFromLayerIJtoK(complementary_apexZ0,z_top_min, 1, num_layers, i + 1), GDarray, GDn_points);
    }

    if (z_top_min == previous_z_top_min)
    {
        current_z_top_index += 1;
        for (index_type i = 0; i < num_layers; i++)
        {
            new_z_i_index[i] = current_z_i_index[i] + 1;
        }
    }

    previous_z_top_min = z_top_min;

    if (white_space_height < 0)
    {
        counter += 1;
        current_z_top_index -= 1;
        for (index_type i = 0; i < num_layers; i++)
        {
            new_z_i_index[i] = current_z_i_index[i] - 1;
        }
    }
    else
    {
        counterUpshift += 1;
        current_z_top_index += 1;
        for (index_type i = 0; i < num_layers; i++)
        {
            new_z_i_index[i] = current_z_i_index[i] + 1;
        }
    }

    current_z_top_index = min(current_z_top_index, GDn_points[num_layers - 1] - 1); // n_points is an array of the sizes of each element of 'array'

    for (index_type i = 0; i < num_layers; i++)
    {
        new_z_i_index[i] = min(new_z_i_index[i], (float)GDn_points[i] - 1);
    }

    for (index_type i = 0; i < num_layers; i++)
    {
        new_z_i_index[i] = max(new_z_i_index[i], 0.0f);
    }
    long new_z_i[MAX_LAYERS];

    for (index_type i = 0; i < num_layers; i++)
    {
        new_z_i[i] = GDarray[i][new_z_i_index[i]][2];
    }

    long new_z_i_atTop[MAX_LAYERS - 1]; // note: the size is MAX_LAYERS - 1 because the loop starts from 1
    for (index_type i = 1; i < num_layers; i++)
    {
        new_z_i_atTop[i - 1] = straightLineProjectorFromLayerIJtoK(complementary_apexZ0,
                                                                    new_z_i[i],
                                                                    1,
                                                                    i + 1,
                                                                    num_layers);
    }

    index_type layerWithSmallestShift = 0;
    long layerSMin = LONG_MAX;

    for (index_type i = 0; i < num_layers - 1; i++)
    {
        if (static_cast<long>(fabs(new_z_i_atTop[i] - previous_z_top_min)) < layerSMin)
        { // fabs is for floats. abs is only int
            layerSMin = static_cast<long>(fabs(new_z_i_atTop[i] - previous_z_top_min));
            layerWithSmallestShift = i;
        }
    }

    layerWithSmallestShift += 1;

    for (index_type i = 0; i < num_layers - 1; i++)
    {
        #if PRINT_OUTS == true
            printf("%u new_z_i_atTop: %ld shift_i_ztop: %ld layerWithSmallestShift: %u\n",
                i + 1, new_z_i_atTop[i], new_z_i_atTop[i] - previous_z_top_min, layerWithSmallestShift + 1);
        #endif
    }

    z_top_min = GDarray[num_layers - 1][current_z_top_index][2];
    z_top_min = new_z_i_atTop[layerWithSmallestShift - 1];

    if (fabs(z_top_min - previous_z_top_min) < static_cast<long>(0.000001 * INTEGER_FACTOR_CM))
    {
        z_top_min = GDarray[num_layers - 1][current_z_top_index][2];
    }

    if (fabs(z_top_min - previous_z_top_min) < static_cast<long>(0.000001 * INTEGER_FACTOR_CM))
    {
        z_top_min = GDarray[num_layers - 2][current_z_top_index][2];
    }

    if (fabs(z_top_min - previous_z_top_min) < static_cast<long>(0.000001 * INTEGER_FACTOR_CM))
    {
        z_top_min = GDarray[num_layers - 3][current_z_top_index][2];
    }

    if ((static_cast<long long>(z_top_min - previous_z_top_min) * static_cast<long long>(white_space_height)) < 0)
    {
        z_top_min = new_z_i_atTop[num_layers - 2];
    }
    #if PRINT_OUTS == true
        printf(" new_def_z_top_min_diff: %ld\n", z_top_min - GDarray[num_layers - 1][current_z_top_index][2]);

        printf(" new_ztop_index: %d new_z_i_index: ", current_z_top_index);
        for (index_type i = 0; i < num_layers; i++)
        {
            printf("%u ", new_z_i_index[i]);
        }
        printf("new_z_top_min: %ld shift_ztop: %ld\n", z_top_min, z_top_min - previous_z_top_min);
    #endif

    int nPatchesAtComplementary = n_patches;
    lastPatchIndex = n_patches - 1; // this may have already been updated at the end of the last call, but just to be sure
    if (nPatchesAtComplementary > nPatchesAtOriginal)
    {
        #if PRINT_OUTS == true
            printf("deleted complementary: [%ld, %ld] for patch %d\n",
                    patches_parameters[lastPatchIndex][2][0][0],
                    patches_parameters[lastPatchIndex][2][0][1],
                    n_patches);
            printf("deleted complementary: [%ld, %ld]\n",
                    patches_parameters[lastPatchIndex][2][1][0],
                    patches_parameters[lastPatchIndex][2][1][1]);
            printf("deleted complementary: [%ld, %ld]\n",
                    patches_parameters[lastPatchIndex][2][2][0],
                    patches_parameters[lastPatchIndex][2][2][1]);
            printf("deleted complementary: [%ld, %ld]\n",
                    patches_parameters[lastPatchIndex][2][3][0],
                    patches_parameters[lastPatchIndex][2][3][1]);
        #endif

        // Call delete_patch to remove the last patch
        delete_patch(lastPatchIndex, n_patches, patches_superpoints, patches_parameters);
        // no need to manually decrement n_patches, delete_patch will handle it
    }
    lastPatchIndex = n_patches - 1; // lastPatchIndex has changed because of the delete patch
    // it may be not needed to update lastPatchIndex, but for now, I did it, so it wouldn't be forgotten later.

    // call makePatch_alignedToLine to add a new patch based on the complementary apex and top z values.
    makePatch_alignedToLine(complementary_apexZ0, z_top_min, ppl, true, false, n_patches, GDarray, GDn_points, patches_superpoints, patches_parameters);
    // update the lastPatchIndex to point to the newly added patch.
    lastPatchIndex = n_patches - 1;

    // retrieve the a and b corner values from the latest patch.
    complementary_a = patches_parameters[lastPatchIndex][2][0][1];
    complementary_b = patches_parameters[lastPatchIndex][2][1][1];

    // update the previous white space height for the next iteration.
    previous_white_space_height = white_space_height;
    // calculate the new white space height based on the original and complementary corners.
    white_space_height = max(original_c - complementary_a, original_d - complementary_b);
    #if PRINT_OUTS == true
        printf("complementary_a: %ld %ld || complementary_b: %ld %ld new z_top_min: %ld\n",
                complementary_a, patches_parameters[lastPatchIndex][2][0][1],
                complementary_b, patches_parameters[lastPatchIndex][2][1][1],z_top_min);
        printf("new white_space_height: %ld\n", white_space_height);
        printf("adjusted complementary: [%ld, %ld] for z_top_min: %ld\n",
               patches_parameters[lastPatchIndex][2][0][0], patches_parameters[lastPatchIndex][2][0][1],z_top_min);
        printf("adjusted complementary: [%ld, %ld] for patch %d\n",
               patches_parameters[lastPatchIndex][2][1][0], patches_parameters[lastPatchIndex][2][1][1], n_patches);
        printf("adjusted complementary: [%ld, %ld]\n",
               patches_parameters[lastPatchIndex][2][2][0], patches_parameters[lastPatchIndex][2][2][1]);
        printf("adjusted complementary: [%ld, %ld]\n",
               patches_parameters[lastPatchIndex][2][3][0], patches_parameters[lastPatchIndex][2][3][1]);
    #endif

    if ((n_patches > 3) && fix42)
    {
        index_type lastPatchIdx = n_patches - 1;
        index_type thirdLastPatchIdx = lastPatchIdx - 2;

        // checking if the superpoints of the last and third last patches are the same
        bool repeat_patch = true;
        // turned this into a for loop, dynamic. if ((patches[patches.size() - 1].superpoints[env.num_layers - 1] == patches[patches.size() - 3].superpoints[env.num_layers - 1]) && (patches[patches.size() - 1].superpoints[0] == patches[patches.size() - 3].superpoints[0]) && (patches[patches.size() - 1].superpoints[1] == patches[patches.size() - 3].superpoints[1]) && (patches[patches.size() - 1].superpoints[2] == patches[patches.size() - 3].superpoints[2]) && (patches[patches.size() - 1].superpoints[3] == patches[patches.size() - 3].superpoints[3]))
        // that code checked 0 to 4
    superpointEqualCheck_2_loop:
        for (index_type i = 0; i < num_layers; i++)
        {
            if (!areWedgeSuperPointsEqual(patches_superpoints[lastPatchIdx][i], patches_superpoints[thirdLastPatchIdx][i]))
            {
                repeat_patch = false;
                break;
            }
        }

        if (repeat_patch)
        {
            #if PRINT_OUTS == true
                printf("%ld %ld repeat_patch: %d\n",
                    patches_superpoints[lastPatchIdx][num_layers - 1][2][1][0],
                    patches_superpoints[lastPatchIdx][num_layers - 1][2][2][0],
                    repeat_patch);
            #endif

            delete_patch(lastPatchIdx, n_patches, patches_superpoints, patches_parameters);

            current_z_top_index -= 1;

            z_top_min = GDarray[num_layers - 1][current_z_top_index][2];
            z_top_min = new_z_i_atTop[layerWithSmallestShift - 1];

            makePatch_alignedToLine(complementary_apexZ0, z_top_min, ppl, true, false, n_patches, GDarray, GDn_points, patches_superpoints, patches_parameters);
        }
    }
}

void makePatch_alignedToLine(long apexZ0, long z_top, int &ppl, bool leftRight, bool float_middleLayers_ppl, index_type &n_patches, GDARRAY, GPATCHES)
{
    long init_patch[MAX_LAYERS][3][MAX_POINTS_IN_SUPERPOINT][3]; // correct

    for(int a = 0; a < MAX_LAYERS; a++)
	{
		for(int b = 0; b < 3; b++)
		{
			for(int c = 0; c < MAX_POINTS_IN_SUPERPOINT; c++)
			{
				for(int d = 0; d < 3; d++)
				{
					init_patch[a][b][c][d] = 0;
				}
			}
		}
	}

    int original_ppl = ppl;
    long alignmentAccuracy = static_cast<long>(0.00001 * INTEGER_FACTOR_CM);
    // Point row_data[MAX_LAYERS][MAX_POINTS_FOR_DATASET];
    index_type init_patch_size = 0;
makeSuperpoint_loop:
    for (index_type i = 0; i < num_layers; i++)
    {
        makeSuperPoint_alignedToLine(i, z_top, apexZ0, float_middleLayers_ppl, ppl, original_ppl, leftRight,  alignmentAccuracy, init_patch, init_patch_size, GDarray, GDn_points);
    }

    // once all points are added to patch new_patch, add the entire patch to the cover (first init it)
    long NPpatches_superpoints[MAX_SUPERPOINTS_IN_PATCH][3][MAX_POINTS_IN_SUPERPOINT][3];
    for(int b = 0; b < MAX_SUPERPOINTS_IN_PATCH; b++)
	{
		for(int c = 0; c < 3; c++)
		{
			for(int d = 0; d < MAX_POINTS_IN_SUPERPOINT; d++)
			{
				for(int e = 0; e < 3; e++)
				{
					NPpatches_superpoints[b][c][d][e] = 0;
				}
			}
		}
	}
    long NPpatches_parameters[5][MAX_PARALLELOGRAMS_PER_PATCH][6];
    for(int b = 0; b < 5; b++)
	{
		for(int c = 0; c < MAX_PARALLELOGRAMS_PER_PATCH; c++)
		{
			for(int d = 0; d < 6; d++)
			{
				NPpatches_parameters[b][c][d] = 0;
			}
		}
	}
    //new_patch will disappear from memory once makePatch_alignedToLine terminates, so we don't want wedgePatch_init to point superpoints to it.
    //init_patch will also disappear for the same scope reasons
    wedgePatch_init(NPpatches_superpoints, NPpatches_parameters, init_patch, init_patch_size, apexZ0);
    //indeed, add_patch is working fine as it is copying the values over: cover->patches[cover->n_patches] = *curr_patch;
    //doesn't matter how wedgePatch_init works since we're dereferencing the patch to store by value in an array belonging to cover.
    add_patch(NPpatches_superpoints, NPpatches_parameters, n_patches, patches_superpoints, patches_parameters);
}

void makeSuperPoint_alignedToLine(int i, long z_top, long apexZ0, float float_middleLayers_ppl, int &ppl, int original_ppl, bool leftRight, long alignmentAccuracy, long init_patch[MAX_LAYERS][3][MAX_POINTS_IN_SUPERPOINT][3], index_type &init_patch_size, GDARRAY)
{
    long y = radii[i];
    long row_list[MAX_POINTS_PER_LAYER];
    int row_list_size = 0;
rowListSet_loop:
    for (index_type j = 0; j < GDn_points[i]; j++)
    {
        row_list[row_list_size++] = GDarray[i][j][2];
    }

    long r_max = radii[num_layers - 1];
    long projectionToRow = static_cast<long>((z_top - apexZ0) * ((y - radii[0]) / (float) (r_max - radii[0])) + apexZ0);

    int start_index = 0;
    long start_value = LONG_MAX;
start_value_loop:
    for (index_type j = 0; j < row_list_size; j++)
    {
        if (fabs(row_list[j] - projectionToRow) < fabs(start_value))
        {
            start_index = j;
            start_value = row_list[j] - projectionToRow;
        }
    }

    int left_bound = 0;
    long lbVal = LONG_MAX;
    int right_bound = 0;
    long rbVal = LONG_MAX;
LRdiscovery_loop:
    for (index_type j = 0; j < row_list_size; j++)
    {
        if (static_cast<long>(fabs((row_list[j] + trapezoid_edges[i]))) < lbVal)
        {
            left_bound = j;
            lbVal = static_cast<long>(fabs((row_list[j] + trapezoid_edges[i])));
        }

        if (static_cast<long>(fabs((row_list[j] - trapezoid_edges[i]))) < rbVal)
        {
            right_bound = j;
            rbVal = static_cast<long>(fabs((row_list[j] - trapezoid_edges[i])));
        }
    }

    if (float_middleLayers_ppl && i != 0 && i != num_layers - 1)
    {
        ppl = original_ppl * 2 - 1;
    }
    else
    {
        ppl = original_ppl;
    }

    static long temp[MAX_POINTS_PER_LAYER][3]; // check
    int temp_size = 0;

    if (leftRight)
    {
        if (start_index != 0 && start_value > alignmentAccuracy)
        {
            start_index -= 1;
        }
        // making and adding a new vector that is a subset of "row_data" or array, going from right+1-ppl to right+1?
        if ((start_index + ppl) > (right_bound + 1))
        {
            for (index_type j = right_bound + 1 - ppl; j <= right_bound; j++)
            {
                for(int z = 0; z < 3; z++)
                {
                    temp[temp_size][z] = GDarray[i][j][z];
                }
                temp_size++;
            }
            // similarly
        }
        else
        {
            for (index_type j = start_index; j < start_index + ppl; j++)
            {
                for(int z = 0; z < 3; z++)
                {
                    temp[temp_size][z] = GDarray[i][j][z];
                }
                temp_size++;
            }
        }
    }
    else
    {
        if (start_index != row_list_size - 1)
        {
            #if PRINT_OUTS == true
                printf("row %d start_index %d start_value %ld z: %ld\n", i + 1, start_index, start_value, row_list[start_index]);
            #endif
            if (start_value < -1 * alignmentAccuracy)
            {
                start_index += 1;
                start_value = row_list[start_index] - projectionToRow;
                #if PRINT_OUTS == true
                    printf("row %d updated start_index %d start_value %ld z: %ld\n", i + 1, start_index, start_value, row_list[start_index]);
                #endif
            }
        }
        // similarly adding subset of 'array' which represents row_data
        if ((start_index - ppl + 1) < left_bound)
        {
            for (index_type j = left_bound; j < left_bound + ppl; j++)
            {
                for(int z = 0; z < 3; z++)
                {
                    temp[temp_size][z] = GDarray[i][j][z];
                }
                temp_size++;
            }
            // similarly
        }
        else
        {
            for (index_type j = start_index - ppl + 1; j <= start_index; j++)
            {
                for(int z = 0; z < 3; z++)
                {
                    temp[temp_size][z] = GDarray[i][j][z];
                }
                temp_size++;
            }
        }
    }
    // passing in address to an uninitialized WedgeSuperPoint structure in the init_patch array with the points from temp to initialize it.
    initWedgeSuperPoint(init_patch[init_patch_size++], temp, temp_size);
}



