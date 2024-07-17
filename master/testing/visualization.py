import matplotlib.pyplot as plt
from matplotlib.backends.backend_pdf import PdfPages
import numpy as np
from PyPDF2 import PdfMerger
import os
from os import listdir
from os.path import isfile, join
import datetime
import time


def visualize(outcome, layerRadii, middleNodes=None, curvedNode=None, magnetic_field=None):
    # graph that plots in polar coordinates with cartesian overlay (no negative y, but have negative and positive x)
    # have underlay in red that gives the true paths based on predetermined input data
    # overlay the results of running the algorithm on top of that in black
    # append graph to file (will have file with may graphs)

    #potentially assume that each pixel is only 25/2 microns in width to fit in positive y axis
    f = open("./MM_file.txt", "r")
    phiPixelIndices = []
    zPixelIndices = []
    # generalize all straight lines to curved line code as parameter 
    # embed 1 curved line and run 100 times (on random data and random node embedding), then 2 curved lines 100 times, no straight lines 100 times
   
    # 67 is the number of lines in MM
    # 5 is the number of layers
    # 16 is the number of coordinates in a layer

    # read scaling factor from file

    scaling_factor = int(f.readline())
    pixelWidth = float(f.readline())

    
    for line in range(5):
        layerIndexList = list(f.readline()[1:-3].split(", ")) # change to philayerindex list
        for coordinate in range(16):
            layerIndexList[coordinate] = int(layerIndexList[coordinate])
        phiPixelIndices.append(layerIndexList)

    for line in range(2):
        f.readline()

    for line in range(5):
        layerIndexList = list(f.readline()[1:-3].split(", ")) # change to zlayerindex llist
        for coordinate in range(16):
            layerIndexList[coordinate] = int(layerIndexList[coordinate])
        zPixelIndices.append(layerIndexList)
    

    xCoordinates = []
    yCoordinates = []
    #12566 is the max pixel index
    for layer in range(len(phiPixelIndices)):
        xLayerCoordinates = []
        yLayerCoordinates = []
        for coordinate in phiPixelIndices[layer]:
            theta = ((coordinate)/scaling_factor) + np.pi/2 # TODO: make this a smaller vertical pie splice; central value should be 90 degrees, and starting point is 90-theta and end point is 90+theta
            radius = layerRadii[layer]
            x = radius*np.cos(theta)
            y = radius*np.sin(theta)
            xCoordinates.append(x)
            yCoordinates.append(y)
            #xLayerCoordinates.append(x)
            #yLayerCoordinates.append(y)

        #xCoordinates.append(xLayerCoordinates)
        #yCoordinates.append(yLayerCoordinates)
    
    fig = plt.figure(figsize=(16, 4))

    ax = fig.add_subplot(1, 2, 1)
    plt.subplots_adjust(bottom=0.2)
    #plt.subplot(1, 2, 1)
    ax.scatter(xCoordinates, yCoordinates, s=14)
    ax.set_xlabel('x (cm)', fontsize=16)
    ax.set_ylabel('y (cm)', fontsize=16)
    ax.set_ylim(0, 27)
    ax.set_xlim(-1, 1)
    ax.set_xticks([-1, -0.5, 0, 0.5, 1])
    ax.tick_params(axis='both', labelsize=16)

    #TODO: might have to do the lines and MM calculation here

    # 1 curved lines in the middle
    TwoxCoordinates = []
    TwoyCoordinates = []
    #12566 is the max pixel index
    c = open("Curved.txt", "r")
    
    layerRadii = [5,10,15,20,25]
    curveRadius = (100/6)*100
    curvedLineXCoordinates = []
    curvedLineYCoordinates = []

    for layer in range(5):
        xLayerCoordinates = []
        yLayerCoordinates = []
        

        curvedCoordinates = list(c.readline()[:-1].split(", "))

        curvedCoordinate1 = int(curvedCoordinates[0])

        #print(phiPixelIndices)

        for coordinate in range(len(phiPixelIndices[layer])):
            if phiPixelIndices[layer][coordinate] == curvedCoordinate1:
                theta = (phiPixelIndices[layer][coordinate]/scaling_factor) + np.pi/2
                #radius = layerRadii[layer]
                #x = radius*np.cos(theta)
                #y = radius*np.sin(theta)
            else:
                continue

            radius = layerRadii[layer]
            x = radius*np.cos(theta)
            y = radius*np.sin(theta)
            #xCoordinates.append(x)
            #yCoordinates.append(y)
            curvedLineXCoordinates.append(x)
            curvedLineYCoordinates.append(y)
            xLayerCoordinates.append(x)
            yLayerCoordinates.append(y)
            #break

        TwoxCoordinates.append(xLayerCoordinates)
        TwoyCoordinates.append(yLayerCoordinates)
    
    #print(TwoxCoordinates, TwoyCoordinates)
    ax.scatter(curvedLineXCoordinates, curvedLineYCoordinates, s=25, c='r')
    ax.plot(TwoxCoordinates, TwoyCoordinates, 'b')
    #plt.show()

    #for partial paths (links), the coordinates need to be its own list, like each line is in the 16 straight line implementation, and passing these to plot will give us straight lines
    for line in range(4):
        f.readline()

    MM = []
    for line in range(16):
        layerIndexList = []
        if line < 9:
            layerIndexList = list(f.readline()[7:-3].split(" "))

        else:
            layerIndexList = list(f.readline()[8:-3].split(" "))
        
        MM.append(layerIndexList)

        
        #for coordinate in range(16):
        #    layerIndexList[coordinate] = int(layerIndexList[coordinate])
        #phiPixelIndices.append(layerIndexList)

    
    for line in range(2):
        f.readline()
    
    for line in range(16):
        layerIndexList = []
        if line < 9:
            layerIndexList = list(f.readline()[7:-3].split(" "))

        else:
            layerIndexList = list(f.readline()[8:-3].split(" "))
        
        MM.append(layerIndexList)

    
    for line in range(2):
        f.readline()
    
    

    
    for line in range(16):
        layerIndexList = []
        if line < 9:
            layerIndexList = list(f.readline()[7:-3].split(" "))

        else:
            layerIndexList = list(f.readline()[8:-3].split(" "))
        
        MM.append(layerIndexList)

    #print("MM: ", MM)


    #plt.plot(ZeroxCoordinates, ZeroyCoordinates, 'r')
    # this only gives lines that have nodes that line up exactly (i.e. a line through the node 6 in each layer)
    # TODO: in the cases where a node doesn't have 11 or 10 and 01, turn all the links for that node to 00; for the nodes that had either 10 or 01 but not both, look at the corresponding node and turn the corresponding link to 0. Then turn that node's links to 00.

    # might be able to replace all this code to another call to pruneglobalmatrix
    """
    
    for node in range(len(MM)):
        # have to check the adjacent nodes for these top cases as well
        
        if '11' in MM[node] and node < 16:
            adjacentNode = MM[node].index('11')
            if '11' in MM[16+adjacentNode] or ('10' in MM[16+adjacentNode] and '01' in MM[16+adjacentNode]):
                pass
            else:
                MM[node][adjacentNode] = '00'
                MM[16+adjacentNode] = ['00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00']
        
        elif '10' in MM[node] and '01' in MM[node] and node < 16:
            adjacentNode = MM[node].index('10')
            if '11' in MM[16+adjacentNode] or ('10' in MM[16+adjacentNode] and '01' in MM[16+adjacentNode]):
                pass
            else:
                MM[node][adjacentNode] = '00'
                MM[16+adjacentNode] = ['00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00']
                adjacentNode = MM[node].index('01')
                MM[node][adjacentNode] = '00'
           
        
        elif '11' in MM[node] and node >= 16 and node < 32:
            adjacentNode = MM[node].index('11')
            if ('11' in MM[32+adjacentNode] or ('10' in MM[32+adjacentNode] and '01' in MM[32+adjacentNode])) and ('11' in MM[adjacentNode] or ('10' in MM[adjacentNode] and '01' in MM[adjacentNode])):
                
                pass
            else:
                MM[node][adjacentNode] = '00'
                MM[32+adjacentNode] = ['00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00']
                MM[adjacentNode] = ['00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00']
        
        
        elif '10' in MM[node] and '01' in MM[node] and node >= 16 and node < 32:
            print("HI1")
            adjacentNode = MM[node].index('10')
            if '11' in MM[32+adjacentNode] or ('10' in MM[32+adjacentNode] and '01' in MM[32+adjacentNode]):
                pass
            else:
                MM[node][adjacentNode] = '00'
                MM[32+adjacentNode] = ['00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00']
                MM[adjacentNode] = ['00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00']
                continue
            
            adjacentNode = MM[node].index('01')
            if '11' in MM[adjacentNode] or ('10' in MM[adjacentNode] and '01' in MM[adjacentNode]):
                pass
            else:
                MM[node][adjacentNode] = '00'
                MM[32+adjacentNode] = ['00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00']
                MM[adjacentNode] = ['00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00']
        
        elif '11' in MM[node] and node >=32:
            adjacentNode = MM[node].index('11')
            if '11' in MM[16+adjacentNode] or ('10' in MM[16+adjacentNode] and '01' in MM[16+adjacentNode]):
                pass
            else:
                MM[node][adjacentNode] = '00'
                MM[16+adjacentNode] = ['00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00']

        elif '10' in MM[node] and '01' in MM[node] and node >=32:
            adjacentNode = MM[node].index('01')
            if '11' in MM[16+adjacentNode] or ('10' in MM[16+adjacentNode] and '01' in MM[16+adjacentNode]):
                pass
            else:
                MM[node][adjacentNode] = '00'
                MM[16+adjacentNode] = ['00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00']
                adjacentNode = MM[node].index('10')
                MM[node][adjacentNode] = '00'
                
        
        elif '01' in MM[node] and node < 16:
            print("HI")
            print(MM[node])
            for adjacentNode in range(len(MM[node])):
                MM[node][adjacentNode] = '00'
            print(MM[node])
        

        elif '10' in MM[node] and node <16:
            print("HI")
            # get index of 10 to find nodein middleLayer 2 that corresponds, then turn all of that node's links to 00
            adjacentNode = MM[node].index('10')
            MM[node][adjacentNode] = '00'
            MM[16+adjacentNode] = ['00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00']
        elif '01' in MM[node] and node >= 16 and node < 32:
            print("HI")
            adjacentNode = MM[node].index('01')
            MM[node][adjacentNode] = '00'
            MM[adjacentNode] = ['00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00']
        elif '10' in MM[node] and node >= 16 and node < 32:
            print("HI")
            adjacentNode = MM[node].index('10')
            MM[node][adjacentNode] = '00'
            MM[32+adjacentNode] = ['00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00']
        elif '01' in MM[node] and node >=32:
            print("HI")
            adjacentNode = MM[node].index('01')
            MM[node][adjacentNode] = '00'
            MM[adjacentNode+16] = ['00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00']
        elif '10' in MM[node] and node >= 32:
            print("HI")
            for adjacentNode in range(len(MM[node])):
                MM[node][adjacentNode] = '00'
            print(MM[node])

    """

    # TODO: make this work for z (looks like its exactly the same, so instead of aboveX/Y we have z/r)
    #       so in this case, we will just reinterpret the meaning of x/y to mean z/r, so this code doesnt
    #       so this code doesnt have to change at all.

    for middleLayer in range(3):
        for node in range(16):
            if '11' in MM[node+(middleLayer)*16] or ('01' in MM[node+(middleLayer)*16] and '10' in MM[node+(middleLayer)*16]):
                for adjacentNode in range(16):
                    if middleLayer == 0:
                        if MM[node+(middleLayer)*16][adjacentNode][0] == '1' and ('10' in MM[adjacentNode+(middleLayer+1)*16] or '11' in MM[adjacentNode+(middleLayer+1)*16]):
                            # access x,y of layer above (if middlelayer 1, if we have a 1, )
                            # if we are layer 1, above layer is layer 2
                            # this is for above layer
                            #print("hello")
                            thisXCoordinates = []
                            thisYCoordinates = []
                            aboveXCoordinates = []
                            aboveYCoordinates = []
                            belowXCoordinates = []
                            belowYCoordinates = []
                            MMxCoordinates = []
                            MMyCoordinates = []
                            thisXCoordinates.append(xCoordinates[node+(middleLayer+1)*16])
                            thisYCoordinates.append(yCoordinates[node+(middleLayer+1)*16])
                            aboveXCoordinates.append(xCoordinates[adjacentNode+(middleLayer+2)*16])
                            aboveYCoordinates.append(yCoordinates[adjacentNode+(middleLayer+2)*16])
                            MMxCoordinates.append(thisXCoordinates)
                            MMxCoordinates.append(aboveXCoordinates)
                            MMyCoordinates.append(thisYCoordinates)
                            MMyCoordinates.append(aboveYCoordinates)
                            #print(MMxCoordinates)
                            #print(MMyCoordinates)

                            ax.plot(MMxCoordinates, MMyCoordinates, 'r')
                            #plt.show()
                        if MM[node+(middleLayer)*16][adjacentNode][1] == '1':
                            thisXCoordinates = []
                            thisYCoordinates = []
                            aboveXCoordinates = []
                            aboveYCoordinates = []
                            belowXCoordinates = []
                            belowYCoordinates = []
                            MMxCoordinates = []
                            MMyCoordinates = []
                            thisXCoordinates.append(xCoordinates[node+(middleLayer+1)*16])
                            thisYCoordinates.append(yCoordinates[node+(middleLayer+1)*16])
                            belowXCoordinates.append(xCoordinates[adjacentNode+(middleLayer)*16])
                            belowYCoordinates.append(yCoordinates[adjacentNode+(middleLayer)*16])
                            MMxCoordinates.append(belowXCoordinates)
                            MMxCoordinates.append(thisXCoordinates)
                            MMyCoordinates.append(belowYCoordinates)
                            MMyCoordinates.append(thisYCoordinates)
                            #print(MMxCoordinates)
                            #print(MMyCoordinates)

                            ax.plot(MMxCoordinates, MMyCoordinates, 'r')
                            #plt.show()
                        else:
                            pass

                    elif middleLayer == 1:
                        if MM[node+(middleLayer)*16][adjacentNode][0] == '1' and ('10' in MM[adjacentNode+(middleLayer+1)*16] or '11' in MM[adjacentNode+(middleLayer+1)*16]):
                            # access x,y of layer above (if middlelayer 1, if we have a 1, )
                            # if we are layer 1, above layer is layer 2
                            # this is for above layer
                            #print("hello")
                            thisXCoordinates = []
                            thisYCoordinates = []
                            aboveXCoordinates = []
                            aboveYCoordinates = []
                            belowXCoordinates = []
                            belowYCoordinates = []
                            MMxCoordinates = []
                            MMyCoordinates = []
                            thisXCoordinates.append(xCoordinates[node+(middleLayer+1)*16])
                            thisYCoordinates.append(yCoordinates[node+(middleLayer+1)*16])
                            aboveXCoordinates.append(xCoordinates[adjacentNode+(middleLayer+2)*16])
                            aboveYCoordinates.append(yCoordinates[adjacentNode+(middleLayer+2)*16])
                            MMxCoordinates.append(thisXCoordinates)
                            MMxCoordinates.append(aboveXCoordinates)
                            MMyCoordinates.append(thisYCoordinates)
                            MMyCoordinates.append(aboveYCoordinates)
                            ax.plot(MMxCoordinates, MMyCoordinates, 'r')
                            #plt.show()
                        if MM[node+(middleLayer)*16][adjacentNode][1] == '1' and ('01' in MM[adjacentNode+(middleLayer-1)*16] or '11' in MM[adjacentNode+(middleLayer-1)*16]):
                            thisXCoordinates = []
                            thisYCoordinates = []
                            aboveXCoordinates = []
                            aboveYCoordinates = []
                            belowXCoordinates = []
                            belowYCoordinates = []
                            MMxCoordinates = []
                            MMyCoordinates = []
                            thisXCoordinates.append(xCoordinates[node+(middleLayer+1)*16])
                            thisYCoordinates.append(yCoordinates[node+(middleLayer+1)*16])
                            belowXCoordinates.append(xCoordinates[adjacentNode+(middleLayer)*16])
                            belowYCoordinates.append(yCoordinates[adjacentNode+(middleLayer)*16])
                            MMxCoordinates.append(belowXCoordinates)
                            MMxCoordinates.append(thisXCoordinates)
                            MMyCoordinates.append(belowYCoordinates)
                            MMyCoordinates.append(thisYCoordinates)

                            ax.plot(MMxCoordinates, MMyCoordinates, 'r')
                            #plt.show()
                        else:
                            pass
                    elif middleLayer == 2:
                        if MM[node+(middleLayer)*16][adjacentNode][0] == '1':
                            # access x,y of layer above (if middlelayer 1, if we have a 1, )
                            # if we are layer 1, above layer is layer 2
                            # this is for above layer
                            #print("hello")
                            thisXCoordinates = []
                            thisYCoordinates = []
                            aboveXCoordinates = []
                            aboveYCoordinates = []
                            belowXCoordinates = []
                            belowYCoordinates = []
                            MMxCoordinates = []
                            MMyCoordinates = []
                            thisXCoordinates.append(xCoordinates[node+(middleLayer+1)*16])
                            thisYCoordinates.append(yCoordinates[node+(middleLayer+1)*16])
                            aboveXCoordinates.append(xCoordinates[adjacentNode+(middleLayer+2)*16])
                            aboveYCoordinates.append(yCoordinates[adjacentNode+(middleLayer+2)*16])
                            MMxCoordinates.append(thisXCoordinates)
                            MMxCoordinates.append(aboveXCoordinates)
                            MMyCoordinates.append(thisYCoordinates)
                            MMyCoordinates.append(aboveYCoordinates)

                            ax.plot(MMxCoordinates, MMyCoordinates, 'r')
                            #plt.show()
                        if MM[node+(middleLayer)*16][adjacentNode][1] == '1' and ('01' in MM[adjacentNode+(middleLayer-1)*16] or '11' in MM[adjacentNode+(middleLayer-1)*16]):
                            thisXCoordinates = []
                            thisYCoordinates = []
                            aboveXCoordinates = []
                            aboveYCoordinates = []
                            belowXCoordinates = []
                            belowYCoordinates = []
                            MMxCoordinates = []
                            MMyCoordinates = []
                            thisXCoordinates.append(xCoordinates[node+(middleLayer+1)*16])
                            thisYCoordinates.append(yCoordinates[node+(middleLayer+1)*16])
                            belowXCoordinates.append(xCoordinates[adjacentNode+(middleLayer)*16])
                            belowYCoordinates.append(yCoordinates[adjacentNode+(middleLayer)*16])
                            MMxCoordinates.append(belowXCoordinates)
                            MMxCoordinates.append(thisXCoordinates)
                            MMyCoordinates.append(belowYCoordinates)
                            MMyCoordinates.append(thisYCoordinates)

                            ax.plot(MMxCoordinates, MMyCoordinates, 'r', linewidth=1)
                            #plt.show()
                        else:
                            pass
    #plt.show()

    xCoordinates = []
    yCoordinates = []
    #12566 is the max pixel index
    for layer in range(len(phiPixelIndices)):
        xLayerCoordinates = []
        yLayerCoordinates = []
        for coordinate in zPixelIndices[layer]:
            z = coordinate/scaling_factor * layerRadii[0]
            radius = layerRadii[layer]
            x = z
            y = radius
            xCoordinates.append(x)
            yCoordinates.append(y)
            #xLayerCoordinates.append(x)
            #yLayerCoordinates.append(y)

        #xCoordinates.append(xLayerCoordinates)
        #yCoordinates.append(yLayerCoordinates)
    


    ax = fig.add_subplot(1, 2, 2)
    ax.scatter(xCoordinates, yCoordinates, s=14)
    ax.set_xlabel('z (cm)', fontsize=16)
    ax.set_ylabel('r (cm)', fontsize=16)
    ax.set_ylim(0, 27)
    ax.set_xlim(-25, 25)
    ax.tick_params(axis='both', labelsize=16)


    # 1 curved lines in the middle but z coordinates
    TwoxCoordinates = []
    TwoyCoordinates = []
    #12566 is the max pixel index
    c = open("Curved.txt", "r")
    
    layerRadii = [5,10,15,20,25]
    curveRadius = (100/6)*100
    curvedLineXCoordinates = []
    curvedLineYCoordinates = []

    for layer in range(5):
        xLayerCoordinates = []
        yLayerCoordinates = []
        

        curvedCoordinates = list(c.readline()[:-1].split(", "))

        curvedCoordinate1 = int(curvedCoordinates[1]) # this might have to be done earlier, in the same line as the first coordinate

        #print(phiPixelIndices)


        for coordinate in range(len(zPixelIndices[layer])):
            if zPixelIndices[layer][coordinate] == curvedCoordinate1:
                z = curvedCoordinate1 #(zPixelIndices[layer][coordinate]/scaling_factor) + np.pi/2
                #radius = layerRadii[layer]
                #x = radius*np.cos(theta)
                #y = radius*np.sin(theta)
            else:
                continue
            
            #print("z: ", z)
            x = z/scaling_factor * layerRadii[0]
            #print("x: ", x)
            y = layerRadii[layer]
            

            #xCoordinates.append(x)
            #yCoordinates.append(y)
            curvedLineXCoordinates.append(x)
            curvedLineYCoordinates.append(y)
            xLayerCoordinates.append(x)
            yLayerCoordinates.append(y)
            #break

        TwoxCoordinates.append(xLayerCoordinates)
        TwoyCoordinates.append(yLayerCoordinates)
    
    #print(TwoxCoordinates, TwoyCoordinates)
    ax.scatter(curvedLineXCoordinates, curvedLineYCoordinates, c='r', s=25)
    ax.plot(TwoxCoordinates, TwoyCoordinates, 'b')
    #plt.show()

    
    #plt.plot(ZeroxCoordinates, ZeroyCoordinates, 'r')
    # this only gives lines that have nodes that line up exactly (i.e. a line through the node 6 in each layer)
    # TODO: in the cases where a node doesn't have 11 or 10 and 01, turn all the links for that node to 00; for the nodes that had either 10 or 01 but not both, look at the corresponding node and turn the corresponding link to 0. Then turn that node's links to 00.

    # might be able to replace all this code to another call to pruneglobalmatrix
    """
    
    for node in range(len(MM)):
        # have to check the adjacent nodes for these top cases as well
        
        if '11' in MM[node] and node < 16:
            adjacentNode = MM[node].index('11')
            if '11' in MM[16+adjacentNode] or ('10' in MM[16+adjacentNode] and '01' in MM[16+adjacentNode]):
                pass
            else:
                MM[node][adjacentNode] = '00'
                MM[16+adjacentNode] = ['00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00']
        
        elif '10' in MM[node] and '01' in MM[node] and node < 16:
            adjacentNode = MM[node].index('10')
            if '11' in MM[16+adjacentNode] or ('10' in MM[16+adjacentNode] and '01' in MM[16+adjacentNode]):
                pass
            else:
                MM[node][adjacentNode] = '00'
                MM[16+adjacentNode] = ['00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00']
                adjacentNode = MM[node].index('01')
                MM[node][adjacentNode] = '00'
           
        
        elif '11' in MM[node] and node >= 16 and node < 32:
            adjacentNode = MM[node].index('11')
            if ('11' in MM[32+adjacentNode] or ('10' in MM[32+adjacentNode] and '01' in MM[32+adjacentNode])) and ('11' in MM[adjacentNode] or ('10' in MM[adjacentNode] and '01' in MM[adjacentNode])):
                
                pass
            else:
                MM[node][adjacentNode] = '00'
                MM[32+adjacentNode] = ['00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00']
                MM[adjacentNode] = ['00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00']
        
        
        elif '10' in MM[node] and '01' in MM[node] and node >= 16 and node < 32:
            print("HI1")
            adjacentNode = MM[node].index('10')
            if '11' in MM[32+adjacentNode] or ('10' in MM[32+adjacentNode] and '01' in MM[32+adjacentNode]):
                pass
            else:
                MM[node][adjacentNode] = '00'
                MM[32+adjacentNode] = ['00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00']
                MM[adjacentNode] = ['00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00']
                continue
            
            adjacentNode = MM[node].index('01')
            if '11' in MM[adjacentNode] or ('10' in MM[adjacentNode] and '01' in MM[adjacentNode]):
                pass
            else:
                MM[node][adjacentNode] = '00'
                MM[32+adjacentNode] = ['00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00']
                MM[adjacentNode] = ['00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00']
        
        elif '11' in MM[node] and node >=32:
            adjacentNode = MM[node].index('11')
            if '11' in MM[16+adjacentNode] or ('10' in MM[16+adjacentNode] and '01' in MM[16+adjacentNode]):
                pass
            else:
                MM[node][adjacentNode] = '00'
                MM[16+adjacentNode] = ['00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00']

        elif '10' in MM[node] and '01' in MM[node] and node >=32:
            adjacentNode = MM[node].index('01')
            if '11' in MM[16+adjacentNode] or ('10' in MM[16+adjacentNode] and '01' in MM[16+adjacentNode]):
                pass
            else:
                MM[node][adjacentNode] = '00'
                MM[16+adjacentNode] = ['00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00']
                adjacentNode = MM[node].index('10')
                MM[node][adjacentNode] = '00'
                
        
        elif '01' in MM[node] and node < 16:
            print("HI")
            print(MM[node])
            for adjacentNode in range(len(MM[node])):
                MM[node][adjacentNode] = '00'
            print(MM[node])
        

        elif '10' in MM[node] and node <16:
            print("HI")
            # get index of 10 to find nodein middleLayer 2 that corresponds, then turn all of that node's links to 00
            adjacentNode = MM[node].index('10')
            MM[node][adjacentNode] = '00'
            MM[16+adjacentNode] = ['00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00']
        elif '01' in MM[node] and node >= 16 and node < 32:
            print("HI")
            adjacentNode = MM[node].index('01')
            MM[node][adjacentNode] = '00'
            MM[adjacentNode] = ['00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00']
        elif '10' in MM[node] and node >= 16 and node < 32:
            print("HI")
            adjacentNode = MM[node].index('10')
            MM[node][adjacentNode] = '00'
            MM[32+adjacentNode] = ['00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00']
        elif '01' in MM[node] and node >=32:
            print("HI")
            adjacentNode = MM[node].index('01')
            MM[node][adjacentNode] = '00'
            MM[adjacentNode+16] = ['00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00', '00']
        elif '10' in MM[node] and node >= 32:
            print("HI")
            for adjacentNode in range(len(MM[node])):
                MM[node][adjacentNode] = '00'
            print(MM[node])

    """

    # TODO: make this work for z (looks like its exactly the same, so instead of aboveX/Y we have z/r)
    #       so in this case, we will just reinterpret the meaning of x/y to mean z/r, so this code doesnt
    #       so this code doesnt have to change at all.

    for middleLayer in range(3):
        for node in range(16):
            if '11' in MM[node+(middleLayer)*16] or ('01' in MM[node+(middleLayer)*16] and '10' in MM[node+(middleLayer)*16]):
                for adjacentNode in range(16):
                    if middleLayer == 0:
                        if MM[node+(middleLayer)*16][adjacentNode][0] == '1' and ('10' in MM[adjacentNode+(middleLayer+1)*16] or '11' in MM[adjacentNode+(middleLayer+1)*16]):
                            # access x,y of layer above (if middlelayer 1, if we have a 1, )
                            # if we are layer 1, above layer is layer 2
                            # this is for above layer
                            #print("hello")
                            thisXCoordinates = []
                            thisYCoordinates = []
                            aboveXCoordinates = []
                            aboveYCoordinates = []
                            belowXCoordinates = []
                            belowYCoordinates = []
                            MMxCoordinates = []
                            MMyCoordinates = []
                            thisXCoordinates.append(xCoordinates[node+(middleLayer+1)*16])
                            thisYCoordinates.append(yCoordinates[node+(middleLayer+1)*16])
                            aboveXCoordinates.append(xCoordinates[adjacentNode+(middleLayer+2)*16])
                            aboveYCoordinates.append(yCoordinates[adjacentNode+(middleLayer+2)*16])
                            MMxCoordinates.append(thisXCoordinates)
                            MMxCoordinates.append(aboveXCoordinates)
                            MMyCoordinates.append(thisYCoordinates)
                            MMyCoordinates.append(aboveYCoordinates)
                            #print(MMxCoordinates)
                            #print(MMyCoordinates)

                            ax.plot(MMxCoordinates, MMyCoordinates, 'r')
                            #ax.show()
                        if MM[node+(middleLayer)*16][adjacentNode][1] == '1':
                            thisXCoordinates = []
                            thisYCoordinates = []
                            aboveXCoordinates = []
                            aboveYCoordinates = []
                            belowXCoordinates = []
                            belowYCoordinates = []
                            MMxCoordinates = []
                            MMyCoordinates = []
                            thisXCoordinates.append(xCoordinates[node+(middleLayer+1)*16])
                            thisYCoordinates.append(yCoordinates[node+(middleLayer+1)*16])
                            belowXCoordinates.append(xCoordinates[adjacentNode+(middleLayer)*16])
                            belowYCoordinates.append(yCoordinates[adjacentNode+(middleLayer)*16])
                            MMxCoordinates.append(belowXCoordinates)
                            MMxCoordinates.append(thisXCoordinates)
                            MMyCoordinates.append(belowYCoordinates)
                            MMyCoordinates.append(thisYCoordinates)
                            #print(MMxCoordinates)
                            #print(MMyCoordinates)

                            ax.plot(MMxCoordinates, MMyCoordinates, 'r')
                            #ax.show()
                        else:
                            pass

                    elif middleLayer == 1:
                        if MM[node+(middleLayer)*16][adjacentNode][0] == '1' and ('10' in MM[adjacentNode+(middleLayer+1)*16] or '11' in MM[adjacentNode+(middleLayer+1)*16]):
                            # access x,y of layer above (if middlelayer 1, if we have a 1, )
                            # if we are layer 1, above layer is layer 2
                            # this is for above layer
                            #print("hello")
                            thisXCoordinates = []
                            thisYCoordinates = []
                            aboveXCoordinates = []
                            aboveYCoordinates = []
                            belowXCoordinates = []
                            belowYCoordinates = []
                            MMxCoordinates = []
                            MMyCoordinates = []
                            thisXCoordinates.append(xCoordinates[node+(middleLayer+1)*16])
                            thisYCoordinates.append(yCoordinates[node+(middleLayer+1)*16])
                            aboveXCoordinates.append(xCoordinates[adjacentNode+(middleLayer+2)*16])
                            aboveYCoordinates.append(yCoordinates[adjacentNode+(middleLayer+2)*16])
                            MMxCoordinates.append(thisXCoordinates)
                            MMxCoordinates.append(aboveXCoordinates)
                            MMyCoordinates.append(thisYCoordinates)
                            MMyCoordinates.append(aboveYCoordinates)
                            ax.plot(MMxCoordinates, MMyCoordinates, 'r')
                            #ax.show()
                        if MM[node+(middleLayer)*16][adjacentNode][1] == '1' and ('01' in MM[adjacentNode+(middleLayer-1)*16] or '11' in MM[adjacentNode+(middleLayer-1)*16]):
                            thisXCoordinates = []
                            thisYCoordinates = []
                            aboveXCoordinates = []
                            aboveYCoordinates = []
                            belowXCoordinates = []
                            belowYCoordinates = []
                            MMxCoordinates = []
                            MMyCoordinates = []
                            thisXCoordinates.append(xCoordinates[node+(middleLayer+1)*16])
                            thisYCoordinates.append(yCoordinates[node+(middleLayer+1)*16])
                            belowXCoordinates.append(xCoordinates[adjacentNode+(middleLayer)*16])
                            belowYCoordinates.append(yCoordinates[adjacentNode+(middleLayer)*16])
                            MMxCoordinates.append(belowXCoordinates)
                            MMxCoordinates.append(thisXCoordinates)
                            MMyCoordinates.append(belowYCoordinates)
                            MMyCoordinates.append(thisYCoordinates)

                            ax.plot(MMxCoordinates, MMyCoordinates, 'r')
                            #ax.show()
                        else:
                            pass
                    elif middleLayer == 2:
                        if MM[node+(middleLayer)*16][adjacentNode][0] == '1':
                            # access x,y of layer above (if middlelayer 1, if we have a 1, )
                            # if we are layer 1, above layer is layer 2
                            # this is for above layer
                            #print("hello")
                            thisXCoordinates = []
                            thisYCoordinates = []
                            aboveXCoordinates = []
                            aboveYCoordinates = []
                            belowXCoordinates = []
                            belowYCoordinates = []
                            MMxCoordinates = []
                            MMyCoordinates = []
                            thisXCoordinates.append(xCoordinates[node+(middleLayer+1)*16])
                            thisYCoordinates.append(yCoordinates[node+(middleLayer+1)*16])
                            aboveXCoordinates.append(xCoordinates[adjacentNode+(middleLayer+2)*16])
                            aboveYCoordinates.append(yCoordinates[adjacentNode+(middleLayer+2)*16])
                            MMxCoordinates.append(thisXCoordinates)
                            MMxCoordinates.append(aboveXCoordinates)
                            MMyCoordinates.append(thisYCoordinates)
                            MMyCoordinates.append(aboveYCoordinates)

                            ax.plot(MMxCoordinates, MMyCoordinates, 'r')
                            #ax.show()
                        if MM[node+(middleLayer)*16][adjacentNode][1] == '1' and ('01' in MM[adjacentNode+(middleLayer-1)*16] or '11' in MM[adjacentNode+(middleLayer-1)*16]):
                            thisXCoordinates = []
                            thisYCoordinates = []
                            aboveXCoordinates = []
                            aboveYCoordinates = []
                            belowXCoordinates = []
                            belowYCoordinates = []
                            MMxCoordinates = []
                            MMyCoordinates = []
                            thisXCoordinates.append(xCoordinates[node+(middleLayer+1)*16])
                            thisYCoordinates.append(yCoordinates[node+(middleLayer+1)*16])
                            belowXCoordinates.append(xCoordinates[adjacentNode+(middleLayer)*16])
                            belowYCoordinates.append(yCoordinates[adjacentNode+(middleLayer)*16])
                            MMxCoordinates.append(belowXCoordinates)
                            MMxCoordinates.append(thisXCoordinates)
                            MMyCoordinates.append(belowYCoordinates)
                            MMyCoordinates.append(thisYCoordinates)

                            ax.plot(MMxCoordinates, MMyCoordinates, 'r')
                            #ax.show()
                        else:
                            pass
    #fig.show()


    makeIndividualEventPictures = False

    if makeIndividualEventPictures == True:
        with PdfPages('./furtherTests/test_' + datetime.datetime.now().strftime('%Y%m%d%H%M%S') + '.pdf') as pdf:
            pdf.savefig()
            plt.close()
        
        onlyfiles = [f for f in listdir('./furtherTests') if isfile(join('./furtherTests', f))]
        merger = PdfMerger()
        
        time.sleep(1)


        if '.DS_Store' in onlyfiles:
            onlyfiles.remove('.DS_Store')
        for file in onlyfiles:
            merger.append('./furtherTests/' + file)
        merger.write("furtherTests.pdf")
        merger.close()



    # 6 different histograms representing the different frequency
    # 1st 
    # 2nd
    # 3rd
    # 4th
    # 5th is curvature
    # 6th lambda

    f = open("./trackParametersFile.txt", "r")
    phiSmoothness = []
    zSmoothness = []
    phiConsistency = []
    zConsistency = []
    curvature = []
    lambdaValue = []

    line_count = 0

    with open("./trackParametersFile.txt", 'r') as file:
        for line in file:
            line_count += 1

    # can put an if that checks line count then when it is 6 times the number of trials, run everything else

    # TODO: 
    #  1. control number of bins if necessary
    #  2. for the curvature and lambda values, are the scalefactors incorporated? 
    #       They need to be, so we can compare to the generator-level curvature and lambda. 
    #       for example, plot the ratio of fullSystem output value / generator value, 
    #       if the scalefactor is incorporated correctly then the ratio should be 1
    #  3. try to increase pixel size to induce rounding errors to get nonzero values for deltas
    #  4. make 2 seperate plots

    #if line_count == 6*100:
    for _ in range(int(line_count/6)):
        phiSmoothness.append(float(f.readline().split(' ')[-1]))
        zSmoothness.append(float(f.readline().split(' ')[-1]))
        phiConsistency.append(float(f.readline().split(' ')[-1]))
        zConsistency.append(float(f.readline().split(' ')[-1]))
        curvature.append(float(f.readline().split(' ')[-1]))
        lambdaValue.append(float(f.readline().split(' ')[-1]))
    
    f.close()

    # Add 0.01 to protect against log(0)
    phiSmoothness = np.array(phiSmoothness) + 1
    zSmoothness = np.array(zSmoothness) + 1
    phiConsistency = np.array(phiConsistency) + 1
    zConsistency = np.array(zConsistency) + 1

    # Take the log of the first 4 arrays
    phiSmoothness = np.log10(phiSmoothness)
    zSmoothness = np.log10(zSmoothness)
    phiConsistency = np.log10(phiConsistency)
    zConsistency = np.log10(zConsistency)

    maxY = 10000000
    minY = 0.5
    minX = -0.1
    maxX = 4.1
    nBins = 100
    nTracks = 0
    nFail = 0
    maxPhiD = 3.99
    maxZD = 3.99
    maxPhiD = 1.0
    maxZD = 1.0
    
    for i in range(len(phiSmoothness)):
        nTracks = nTracks + 1
        if (phiSmoothness[i]>maxPhiD) or (zSmoothness[i]>maxZD) or (phiConsistency[i]>maxPhiD) or (zConsistency[i]>maxZD):
            nFail = nFail + 1
            phiSmoothness[i] = 4.0
            zSmoothness[i] = 4.0
            phiConsistency[i] = 4.0
            zConsistency[i] = 4.0

    failureRate = nFail/nTracks
    failureRateError = np.sqrt(failureRate*(1.0-failureRate)/nTracks)
    if failureRate > 0.5:
        failureRate = 1.0 - failureRate
        nFail = nTracks - nFail
    print("tracks total: ", nTracks, " fail: ", nFail, " failure rate: (", 1000000*failureRate, "+-", 1000000*failureRateError, ") ppm")
            
    # create a 2 by 3 grid of histograms
    fig, axs = plt.subplots(2, 2)
    # plot the data
    n, bins, patches = axs[0, 0].hist(phiSmoothness, bins=nBins, log=True)
    axs[0, 0].set_xlabel("log$_{10}(\Delta\phi'')$")
    axs[0, 0].set_ylabel('tracks')
    #set ymin and ymax
    axs[0, 0].set_ylim(minY, maxY)
    axs[0, 0].set_xlim(minX, maxX)
    patches[-1].set_facecolor('red')

    n, bins, patches = axs[0, 1].hist(zSmoothness, bins=nBins, log=True)
    axs[0, 1].set_xlabel("log$_{10}(\Delta z'')$")
    axs[0, 1].set_ylabel('tracks')
    axs[0, 1].set_ylim(minY, maxY)
    axs[0, 1].set_xlim(minX, maxX)
    patches[-1].set_facecolor('red')

    n, bins, patches = axs[1, 0].hist(phiConsistency, bins=nBins, log=True)
    axs[1, 0].set_xlabel("log$_{10}(\Delta\phi')$")
    axs[1, 0].set_ylabel('tracks')
    axs[1, 0].set_ylim(minY, maxY)
    axs[1, 0].set_xlim(minX, maxX)
    patches[-1].set_facecolor('red')

    n, bins, patches = axs[1, 1].hist(zConsistency, bins=nBins, log=True)
    axs[1, 1].set_xlabel("log$_{10}(\Delta z')$")
    axs[1, 1].set_ylabel('tracks')
    axs[1, 1].set_ylim(minY, maxY)
    axs[1, 1].set_xlim(minX, maxX)
    patches[-1].set_facecolor('red')

    plt.tight_layout()

    with PdfPages('./histograms/test_deltas' + datetime.datetime.now().strftime('%Y%m%d%H%M%S') + '.pdf') as pdf:
        pdf.savefig()
        plt.close()
    
    f = open("./Generator.txt", "r")

    generatorCurvature = []
    generatorLambdaValue = []

    for _ in range(int(line_count/6)):
        paramList = list(f.readline().split(", "))
        generatorCurvature.append(float(paramList[0]))
        generatorLambdaValue.append(float(paramList[1]))

    distanceBetweenLayers = layerRadii[1] - layerRadii[0]
    curvature = np.array(curvature)/(2.0*scaling_factor*distanceBetweenLayers)

    curvatureRatio = np.array(curvature) / np.array(generatorCurvature)

    lambdaValue = np.array(lambdaValue)*pixelWidth/(2.0*distanceBetweenLayers)
    lambdaRatio = np.array(lambdaValue) / np.array(generatorLambdaValue)
    
    curvatureDifference = (np.array(curvature) - np.array(generatorCurvature))*200.0/(0.3*magnetic_field) # This is in units of 1/GeV (which is inverse of p_T, the transverse momentum)
    lambdaDifference = np.array(lambdaValue) - np.array(generatorLambdaValue)

    curvatureDifference = 1000*curvatureDifference
    lambdaDifference = 1000*lambdaDifference

    curvatureRange = 30
    lambdaPlotRange = 1

    for i in range(len(curvatureDifference)):
        if np.abs(curvatureDifference[i]) > curvatureRange:
            curvatureDifference[i] = 0

        if np.abs(lambdaDifference[i]) > lambdaPlotRange:
            lambdaDifference[i] = 0
    
    print(curvatureDifference)
    print(lambdaDifference)
    
    fig, axs = plt.subplots(2, 2)

    # TODO: 1. want to suppress the decimals on the 0

    axs[0,0].hist(curvatureDifference, bins=50)
    axs[0,0].set_xlabel('$\sigma_c$ (TeV$^{-1}$)' )
    axs[0,0].set_ylabel('tracks')
    axs[0,0].set_xlim(-curvatureRange, curvatureRange)
    #x axis tick marks with exponential representation
    #axs[0].xaxis.set_major_formatter(FormatStrFormatter('%.1e'))
    axs[0,0].set_xticks([-curvatureRange, 0, curvatureRange])
    # print standard deviation of curvatureDifference
    print("Mean of curvature difference: ", np.mean(curvatureDifference), "/TeV")
    print("Standard deviation of curvature difference: ", np.std(curvatureDifference), "/TeV")

    axs[0,1].hist(lambdaDifference, bins=50)
    axs[0,1].set_xlabel('$\sigma_{\lambda}$ (‰)')
    axs[0,1].set_ylabel('tracks')
    axs[0,1].set_xlim(-lambdaPlotRange, lambdaPlotRange)
    print("Mean of lambda difference: ", np.mean(lambdaDifference), "‰")
    print("Standard deviation of lambda difference: ", np.std(lambdaDifference), "‰")

    #blank out the two lower plots
    axs[1,0].axis('off')
    axs[1,1].axis('off')


    plt.tight_layout()

    with PdfPages('./histograms/test_c_and_lambda' + datetime.datetime.now().strftime('%Y%m%d%H%M%S') + '.pdf') as pdf:
        pdf.savefig()
        plt.close()

    



if __name__ == "__main__":
    layerRadii = [5, 10, 15, 20, 25] # in centimeters
    magnetic_field = 2.0; # Tesla
    middleNodes = [6, 13] #going to need to turn this into 2d array and it will need to be passed in from fullsystem since it will change every time
    curvedNode = 6
    visualize(4, layerRadii, middleNodes, curvedNode, magnetic_field)


