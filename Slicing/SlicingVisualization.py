from math import cos, sin
import math
import cv2
import numpy as np
import random


'''program to create slices of data and visualize the program'''

class InfoCache:
    '''creates a structure to store the slice, Lyaer, poitnerNUmber, and Coordnites'''
    def __init__(self, Slice, Layer, PointNumber, Coordinates):
        self.Slice = Slice
        self.Layer = Layer
        self.Pointnumber = PointNumber
        self.Coordinates = Coordinates

#bubblesort, same as in Slicing.cpp
def assign(InputArray, LayerRadii):
    '''Creates the list of InfoCaches and assigns values from Input Arrays int othe InfoCaches'''
    SliceCapacity = 0
    SliceTracker = 0
    CircleCapacity = 0
    CircleTracker = 0
    Layer = LayerRadii[0]
    MAX_POINTS = 16
    CIRCLE_MAX = 10000
    
    #split the input array into subarrays size of the CIRCLE_MAX, or how many cirlces there are to hold
    chunks = [InputArray[x:x+CIRCLE_MAX] for x in range(0, len(InputArray), CIRCLE_MAX)]
    #iterate through all the subarrays, and 
    for k in range(len(chunks)):
        #sort using bubble sort the inputed array
        InputArrayLen = len(chunks[k])
        for i in range(InputArrayLen - 1):
            for j in range(0, InputArrayLen-i-1):
                if(chunks[k][j] > chunks[k][j + 1]): 
                    InputArray[k*CIRCLE_MAX + j], InputArray[k*CIRCLE_MAX + j + 1] = InputArray[k*CIRCLE_MAX + j + 1], InputArray[k*CIRCLE_MAX + j]
                    chunks[k][j], chunks[k][j + 1] = chunks[k][j + 1], chunks[k][j]
                
    
    #Initalize the list of InfoCaches 
    
    InfoCacheList = []
    InputArrayLen = len(InputArray)
    #Sorts all of the datapoints into InfoCache structures to be added to the INfoCacheList
    for i in range(InputArrayLen):
        if(SliceCapacity >= MAX_POINTS):
            SliceCapacity = 0
            SliceTracker += 1
        if(CircleCapacity >= CIRCLE_MAX):
            CircleCapacity = 0
            CircleTracker += 1
            Layer = LayerRadii[CircleTracker]
        InfoCacheList.append(InfoCache(SliceTracker, Layer, i, InputArray[i]))
        SliceCapacity += 1
        CircleCapacity += 1

    #Initalize the Image to be made
    img = np.zeros((1000, 1000, 3), dtype="uint8")
    window_name = 'Image'
    center_coordinates = (500, 500)
    color = (255, 133, 233)
    thickness = 2
    #Make all of the cirlces first
    for i in range(len(LayerRadii)):
        radius = LayerRadii[i] * 10
        color = (255, 133 + radius*.5, 233 - radius*.5)
        image = cv2.circle(img, center_coordinates, radius, color, thickness)
        cv2.line(img, center_coordinates, (500 + radius,500),(255, 255, 255),1)
    
    #Print all of the lines
    SliceTracker = 0
    for i in range(len(InfoCacheList)):
        radius = InfoCacheList[i].Layer*10 
        color = (255, 133 + radius*.5, 233 - radius*.5)
        if(SliceTracker != InfoCacheList[i].Slice):
            x = 500 + cos(InfoCacheList[i].Coordinates)*radius
            y = 500 + sin(InfoCacheList[i].Coordinates)*radius
            cv2.line(img, center_coordinates,(int(x),int(y)),color,1)
            SliceTracker = InfoCacheList[i].Slice
        
    cv2.imshow(window_name, image)
    cv2.waitKey(0)
    cv2.destroyAllWindows()
def randomArrayGenerator(CircleCount, InputArray):
    for i in range(10000 * CircleCount):
        value = random.random()
        scaled_value = value * 2 * math.pi
        InputArray.append(scaled_value)
    return InputArray

if __name__ == "__main__":
    layerRadii = [5, 10, 15,20,25] # in centimeters
    InputArray = []
    InputArray = randomArrayGenerator(len(layerRadii), InputArray)
    assign(InputArray, layerRadii)
    print("Works and Prints")