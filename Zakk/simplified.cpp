// C++ imports
#include <stdio.h>
#include <iostream>
#include <stdint.h>
#include <assert.h>
#include <fstream>
#include <string>
#include <vector>
#include <algorithm>
#include <cmath>
#include <math.h>
#include <time.h>
#include <bitset>

// Vitis imports
#include "ap_int.h"
// #include "hls_stream.h"
// #include "hls_vector.h"

// Namespaces
using namespace std;

// Import math keywords
#define _USE_MATH_DEFINES

// Global Constants
#define totalLayers 5 // Each layer corresponds to the set of hits detected by a single sensor, default 5
#define defaultLayersQC totalLayers // Quality Control is written for 5 layers
#define middleLayers 3 // totalLayers-2, default 3
#define anchorLayer 1 // middle of middleLayers, default 1
#define adjacentLayers 2 // Each middle layer has 2 adjacent layers
#define numberOfNodes 16 // Each node corresponds to a "hit" picked up by a sensor; we assume that each layer has 16 hits for the sake of this project
#define adjacentNodes 16 // Each middle layer node has 16 adjacent nodes above and below
#define highestPower 4 // log_2(numberOfNodes)
#define coordinateParticle1 2
#define coordinateParticle2 3
#define acceptLink true 
#define rejectLink false
#define upLink 0
#define downLink 1
#define aboveLayerIndex 0
#define belowLayerIndex 1
#define killLaplacianValue -1
//#define killLaplacianValue 999999
#define indexTYPE std::uint8_t  // data type for array indices
#define fakeIndex 0xFF // initialization value of best found track = 255, since good track will be 0-15 (0-F in hex)
#define structTYPE ap_int<16> // data type for coded structure, laplacian + upLink + downLink
//#define structTYPE int
#define laplacianTYPE int // data type for laplacian and node (hit) coordinates
#define spacepointTYPE ap_int<32> // data type for 2D spacepoint coordinates (packed)
//#define spacepointTYPE int // data type for 2D spacepoint coordinates, separate X and Y
#define nWeightedCoordinates 5 // each coordinate has 3 weighted versions for laplacian calculation and 2 for slope calculation
#define eventPipelineStages 7 // number of events in pipeline
#define numberOfDirections 2 // rows and columns for upward layer and downward layer
#define nPixelDimensions 2 // for 2D pixels, X and Y coordinates of hit
#define nMetrics 2 // number of track quality metrics
#define rowDirection 0
#define columnDirection 1
#define combinedNodeProcessor false
#define inlineModules true
#define useDSPbyDecoding true
#define badMetric 10000

// Function prototypes
laplacianTYPE decodeXcoordinate(spacepointTYPE packedCoordinates);
laplacianTYPE decodeYcoordinate(spacepointTYPE packedCoordinates);

template<std::size_t weightsToUnpack>
void decodeCoordinates(spacepointTYPE coordinatesIn[totalLayers][nWeightedCoordinates][numberOfNodes], laplacianTYPE (& coordinatesOut)[totalLayers][weightsToUnpack][numberOfNodes][nPixelDimensions]);

#if useDSPbyDecoding == false
void singleNodeLaplacianCalculator(spacepointTYPE aboveNodeList[adjacentNodes], spacepointTYPE belowNodeList[adjacentNodes], spacepointTYPE inputNode, structTYPE (&nodeTriplets)[adjacentNodes][adjacentNodes]);
#elif useDSPbyDecoding == true
void singleNodeLaplacianCalculator(laplacianTYPE aboveNodeList[adjacentNodes][nPixelDimensions], laplacianTYPE belowNodeList[adjacentNodes][nPixelDimensions], laplacianTYPE inputNode[nPixelDimensions], structTYPE (&nodeTriplets)[adjacentNodes][adjacentNodes]);
#endif

void laplacianCalculator(spacepointTYPE coordinates[totalLayers][nWeightedCoordinates][numberOfNodes], structTYPE (& tripletMatrix)[middleLayers][numberOfNodes][adjacentNodes][adjacentNodes]);

void makeAdder(spacepointTYPE thisNode, spacepointTYPE inputNode, laplacianTYPE (& halfLaplacian)[nPixelDimensions]);
void makeAdder(laplacianTYPE thisNode[nPixelDimensions], laplacianTYPE inputNode[nPixelDimensions], laplacianTYPE (& halfLaplacian)[nPixelDimensions]);

#if useDSPbyDecoding == false
void makeHalfLaplacian(spacepointTYPE nodeList[adjacentNodes], laplacianTYPE inputNode[nPixelDimensions], laplacianTYPE (& halfLaplacian)[adjacentNodes][nPixelDimensions]);
#elif useDSPbyDecoding == true
void makeHalfLaplacian(laplacianTYPE nodeList[adjacentNodes][nPixelDimensions], laplacianTYPE inputNode[nPixelDimensions], laplacianTYPE (& halfLaplacian)[adjacentNodes][nPixelDimensions]);
#endif

void makeAbs(laplacianTYPE laplacian[adjacentNodes][nPixelDimensions], laplacianTYPE (& absLaplacian)[adjacentNodes]);

structTYPE tripletEncode(indexTYPE aboveNodeIndex, indexTYPE belowNodeIndex, laplacianTYPE Laplacian);

// Function definitions
laplacianTYPE decodeXcoordinate(spacepointTYPE packedCoordinates) {
    return (laplacianTYPE) (((packedCoordinates & 0xFFFF0000) >> 16) & 0x0000FFFF);
}

laplacianTYPE decodeYcoordinate(spacepointTYPE packedCoordinates) {
    return (laplacianTYPE) (packedCoordinates & 0x0000FFFF);
}

#if useDSPbyDecoding == false
void makeAdder(spacepointTYPE thisNode, spacepointTYPE inputNode, laplacianTYPE (& halfLaplacian)[nPixelDimensions]){
    #pragma HLS INLINE
    halfLaplacian[0] = decodeXcoordinate(thisNode) + decodeXcoordinate(inputNode);
    halfLaplacian[1] = decodeYcoordinate(thisNode) + decodeYcoordinate(inputNode);
    return;
}
#elif useDSPbyDecoding == true
void makeAdder(laplacianTYPE thisNode[nPixelDimensions], laplacianTYPE inputNode[nPixelDimensions], laplacianTYPE (& halfLaplacian)[nPixelDimensions]){
    #pragma HLS INLINE
    halfLaplacian[0] = thisNode[0] + inputNode[0];
    halfLaplacian[1] = thisNode[1] + inputNode[1];
    return;
}
#endif

#if useDSPbyDecoding == false
void makeHalfLaplacian(spacepointTYPE nodeList[adjacentNodes], laplacianTYPE inputNode[nPixelDimensions], laplacianTYPE (& halfLaplacian)[adjacentNodes][nPixelDimensions]) {
#elif useDSPbyDecoding == true
void makeHalfLaplacian(laplacianTYPE nodeList[adjacentNodes][nPixelDimensions], laplacianTYPE inputNode[nPixelDimensions], laplacianTYPE (& halfLaplacian)[adjacentNodes][nPixelDimensions]) {
#endif
    #pragma HLS INLINE OFF
    makeHalfLaplacianLoop: for (indexTYPE nodeIndex = 0; nodeIndex < adjacentNodes; nodeIndex++) {
        #pragma HLS UNROLL
        #if useDSPbyDecoding == false
            halfLaplacian[nodeIndex][0] = decodeXcoordinate(nodeList[nodeIndex]) + inputNode[0];
            halfLaplacian[nodeIndex][1] = decodeYcoordinate(nodeList[nodeIndex]) + inputNode[1];
        #elif useDSPbyDecoding == true
            halfLaplacian[nodeIndex][0] = nodeList[nodeIndex][0] + inputNode[0];
            halfLaplacian[nodeIndex][1] = nodeList[nodeIndex][1] + inputNode[1];
        #endif
    }
    return;
}

void makeAbs(laplacianTYPE laplacian[adjacentNodes][nPixelDimensions], laplacianTYPE (& absLaplacian)[adjacentNodes]) {
    #pragma HLS INLINE
    makeAbsLoop: for (indexTYPE nodeIndex = 0; nodeIndex < adjacentNodes; nodeIndex++) {
        #pragma HLS UNROLL
        absLaplacian[nodeIndex] = std::abs(laplacian[nodeIndex][0]) + std::abs(laplacian[nodeIndex][1]);
    }
    return;
}

#if useDSPbyDecoding == false
void singleNodeLaplacianCalculator(spacepointTYPE aboveNodeList[adjacentNodes], spacepointTYPE belowNodeList[adjacentNodes], spacepointTYPE inputNode, structTYPE (&nodeTriplets)[adjacentNodes][adjacentNodes]) {
#elif useDSPbyDecoding == true
void singleNodeLaplacianCalculator(laplacianTYPE aboveNodeList[adjacentNodes][nPixelDimensions], laplacianTYPE belowNodeList[adjacentNodes][nPixelDimensions], laplacianTYPE inputNode[nPixelDimensions], structTYPE (&nodeTriplets)[adjacentNodes][adjacentNodes]) {
#endif
    #pragma HLS INLINE OFF
    laplacianTYPE halfLaplacian[adjacentNodes][nPixelDimensions];
    #pragma HLS array_partition variable=halfLaplacian complete dim=0
    laplacianTYPE laplacian[adjacentNodes][nPixelDimensions];
    #pragma HLS array_partition variable=laplacian complete dim=0
    laplacianTYPE absLaplacian[adjacentNodes][adjacentNodes];
    #pragma HLS array_partition variable=absLaplacian complete dim=0

    SNLCaboveNodeLoop: for (indexTYPE aboveNodeIndex = 0; aboveNodeIndex < adjacentNodes; aboveNodeIndex++) {
        #pragma HLS PIPELINE
        makeAdder(aboveNodeList[aboveNodeIndex], inputNode, halfLaplacian[aboveNodeIndex]);
        makeHalfLaplacian(belowNodeList, halfLaplacian[aboveNodeIndex], laplacian);
        makeAbs(laplacian, absLaplacian[aboveNodeIndex]);
    }
    SNLCaboveLoopEncode: for (indexTYPE aboveNodeIndex = 0; aboveNodeIndex < adjacentNodes; aboveNodeIndex++) {
        #pragma HLS UNROLL
        SNLCbelowLoopEncode: for (indexTYPE belowNodeIndex = 0; belowNodeIndex < adjacentNodes; belowNodeIndex++) {
            #pragma HLS UNROLL
            nodeTriplets[aboveNodeIndex][belowNodeIndex] = tripletEncode(aboveNodeIndex, belowNodeIndex, absLaplacian[aboveNodeIndex][belowNodeIndex]); // Bit encode the node indices and Laplacian into a structTYPE that represents the triplet, Store the triplet in the corresponding array position
        }
    }
    return;
}

structTYPE tripletEncode(indexTYPE aboveNodeIndex, indexTYPE belowNodeIndex, laplacianTYPE Laplacian){
    #pragma HLS INLINE
    return (((structTYPE)Laplacian) << 8) | ((structTYPE)aboveNodeIndex) | (((structTYPE)belowNodeIndex) << 4);
}

template<std::size_t weightsToUnpack>
void decodeCoordinates(spacepointTYPE coordinatesIn[totalLayers][nWeightedCoordinates][numberOfNodes], laplacianTYPE (& coordinatesOut)[totalLayers][weightsToUnpack][numberOfNodes][nPixelDimensions]) {
    #pragma HLS INLINE OFF
    dCLayerLoop: for (indexTYPE layer = 0; layer < totalLayers; layer++) {
        #pragma HLS UNROLL
        dCweightLoop: for (indexTYPE weightIndex = 0; weightIndex < weightsToUnpack; weightIndex++) {
            #pragma HLS UNROLL
            dCNodeLoop: for (indexTYPE nodeIndex = 0; nodeIndex < numberOfNodes; nodeIndex++) {
                #pragma HLS UNROLL
                coordinatesOut[layer][weightIndex][nodeIndex][0] = decodeXcoordinate(coordinatesIn[layer][weightIndex][nodeIndex]);
                coordinatesOut[layer][weightIndex][nodeIndex][1] = decodeYcoordinate(coordinatesIn[layer][weightIndex][nodeIndex]);
            } // end nodeLoop
        } // end weightLoop
    } // end layerLoop
}

void laplacianCalculator(spacepointTYPE coordinates[totalLayers][nWeightedCoordinates][numberOfNodes], structTYPE (& tripletMatrix)[middleLayers][numberOfNodes][adjacentNodes][adjacentNodes]) {
    #pragma HLS INLINE OFF
    #if useDSPbyDecoding == true
        laplacianTYPE decodedCoordinates[totalLayers][nWeightedCoordinates-2][numberOfNodes][nPixelDimensions];
        #pragma HLS ARRAY_PARTITION variable=decodedCoordinates dim=0 complete
        decodeCoordinates<nWeightedCoordinates-2>(coordinates, decodedCoordinates); // do not need the weighted coordinates for first derivatives, only need those for 2nd derivatives
    #endif
    // Loop through only the middle layers because the uppermost and lowermost layers are not associated with triplets
    LaplacianLayerLoop: for (indexTYPE middleLayer = 0; middleLayer < middleLayers; middleLayer++) {
        #pragma HLS UNROLL
        LaplacianNodeLoop: for (indexTYPE nodeIndex = 0; nodeIndex < numberOfNodes; nodeIndex++) {
            #pragma HLS UNROLL
            #if useDSPbyDecoding == false
                singleNodeLaplacianCalculator(coordinates[middleLayer+2][2], coordinates[middleLayer][0], coordinates[middleLayer+1][1][nodeIndex], tripletMatrix[middleLayer][nodeIndex]);
            #elif useDSPbyDecoding == true
                singleNodeLaplacianCalculator(decodedCoordinates[middleLayer+2][2], decodedCoordinates[middleLayer][0], decodedCoordinates[middleLayer+1][1][nodeIndex], tripletMatrix[middleLayer][nodeIndex]);
            #endif
        } // end nodeLoop
    } // end layerLoop
}
