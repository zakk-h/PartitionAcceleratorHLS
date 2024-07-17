import matplotlib.pyplot as plt
from matplotlib.backends.backend_pdf import PdfPages
import numpy as np
from PyPDF2 import PdfFileMerger
from os import listdir
from os.path import isfile, join
import datetime
import time


def visualize(outcome, layerRadii, middleNodes=None, curvedNode=None):
    # graph that plots in polar coordinates with cartesian overlay (no negative helly, but have negative and positive x)
    # have underlay in red that gives the true paths based on predetermined input data
    # overlay the results of running the algorithm on top of that in black
    # append graph to file (will have file with may graphs)

    #potentially assume that each pixel is only 25/2 microns in width to fit in positive y axis
    f = open("MM.txt", "r")
    pixelIndices = []
    # generalize all straight lines to curved line code as parameter 
    # embed 1 curved line and run 100 times (on random data and random node embedding), then 2 curved lines 100 times, no straight lines 100 times
   
    # 67 is the number of lines in MM
    # 5 is the number of layers
    # 16 is the number of coordinates in a layer
    for line in range(5):
        layerIndexList = list(f.readline()[1:-3].split(", "))
        for coordinate in range(16):
            layerIndexList[coordinate] = int(layerIndexList[coordinate])
        pixelIndices.append(layerIndexList)
    
    xCoordinates = []
    yCoordinates = []
    #12566 is the max pixel index
    for layer in range(len(pixelIndices)):
        xLayerCoordinates = []
        yLayerCoordinates = []
        for coordinate in pixelIndices[layer]:
            theta = ((coordinate)/12566)*np.pi/9 + np.pi/2.2# TODO: make this a smaller vertical pie splice; central value should be 90 degrees, and starting point is 90-theta and end point is 90+theta
            radius = layerRadii[layer]
            x = radius*np.cos(theta)
            y = radius*np.sin(theta)
            xCoordinates.append(x)
            yCoordinates.append(y)
            #xLayerCoordinates.append(x)
            #yLayerCoordinates.append(y)

        #xCoordinates.append(xLayerCoordinates)
        #yCoordinates.append(yLayerCoordinates)
    
    plt.rcParams['figure.figsize'] = (16,8)
    plt.rcParams.update({'font.size': 15})

    plt.xlabel('x (cm)')
    plt.ylabel('y (cm)')
    plt.scatter(xCoordinates, yCoordinates)
    
    # TODO: Need to color the lines red here; can probably make functions out of the repeted code; can probably put a lot of this code in its own function
    # can change to 2pi, or less than that, to represent slice of layer. but keep in mind 12566 represents pixels for entire circumference, and currently only using half
    if outcome == 0:
        ZeroxCoordinates = []
        ZeroyCoordinates = []
        #12566 is the max pixel index
        for layer in range(len(pixelIndices)):
            xLayerCoordinates = []
            yLayerCoordinates = []
            for coordinate in pixelIndices[layer]:
                theta = (coordinate/12566)*np.pi + np.pi/4
                radius = layerRadii[layer]
                x = radius*np.cos(theta)
                y = radius*np.sin(theta)
                #xCoordinates.append(x)
                #yCoordinates.append(y)
                xLayerCoordinates.append(x)
                yLayerCoordinates.append(y)

            ZeroxCoordinates.append(xLayerCoordinates)
            ZeroyCoordinates.append(yLayerCoordinates)

        print(ZeroxCoordinates)
        #plt.plot(ZeroxCoordinates, ZeroyCoordinates, 'r')
        
    
    elif outcome == 1:
        
        # 2 straight lines on edges
        OnexCoordinates = []
        OneyCoordinates = []
        #12566 is the max pixel index
        for layer in range(5):
            xLayerCoordinates = []
            yLayerCoordinates = []
            
            for coordinate in range(len(pixelIndices[layer])):
                if coordinate == 0:
                    theta = 0 + np.pi/4
                elif coordinate == 15:
                    theta = np.pi + np.pi/4
                else:
                    continue
                radius = layerRadii[layer]
                x = radius*np.cos(theta)
                y = radius*np.sin(theta)
                #xCoordinates.append(x)
                #yCoordinates.append(y)
                xLayerCoordinates.append(x)
                yLayerCoordinates.append(y)

            OnexCoordinates.append(xLayerCoordinates)
            OneyCoordinates.append(yLayerCoordinates)
        plt.plot(OnexCoordinates, OneyCoordinates, 'r')
        plt.show()
    
    elif outcome == 2:
        # 2 curved lines in the middle
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
            curvedCoordinate2 = int(curvedCoordinates[1])



            for coordinate in range(len(pixelIndices[layer])):
                

                if pixelIndices[layer][coordinate] == curvedCoordinate1:

                    theta = (pixelIndices[layer][coordinate]/12566)*np.pi/9 + np.pi/2.2
                    radius = layerRadii[layer]
                    x = radius*np.cos(theta)
                    y = radius*np.sin(theta)
                    curvedLineXCoordinates.append(x)
                    curvedLineYCoordinates.append(y)
                elif pixelIndices[layer][coordinate] == curvedCoordinate2:
                    theta = (pixelIndices[layer][coordinate]/12566)*np.pi/9 + np.pi/2.2
                    radius = layerRadii[layer]
                    x = radius*np.cos(theta)
                    y = radius*np.sin(theta)
                    curvedLineXCoordinates.append(x)
                    curvedLineYCoordinates.append(y)
                    

                else:
                    continue
                radius = layerRadii[layer]
                x = radius*np.cos(theta)
                y = radius*np.sin(theta)
                #xCoordinates.append(x)
                #yCoordinates.append(y)
                xLayerCoordinates.append(x)
                yLayerCoordinates.append(y)

            TwoxCoordinates.append(xLayerCoordinates)
            TwoyCoordinates.append(yLayerCoordinates)
        
        print(TwoxCoordinates, TwoyCoordinates)
        plt.scatter(curvedLineXCoordinates, curvedLineYCoordinates, c='r')
        plt.plot(TwoxCoordinates, TwoyCoordinates, 'r')




    elif outcome == 3:
        # no straight lines, do nothing
        pass
    elif outcome == 4:
        # 2 curved lines in the middle
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




            for coordinate in range(len(pixelIndices[layer])):
                

                if pixelIndices[layer][coordinate] == curvedCoordinate1:

                    theta = (pixelIndices[layer][coordinate]/12566)*np.pi/9 + np.pi/2.2
                    radius = layerRadii[layer]
                    x = radius*np.cos(theta)
                    y = radius*np.sin(theta)
                    curvedLineXCoordinates.append(x)
                    curvedLineYCoordinates.append(y)
                else:
                    continue
                radius = layerRadii[layer]
                x = radius*np.cos(theta)
                y = radius*np.sin(theta)
                #xCoordinates.append(x)
                #yCoordinates.append(y)
                xLayerCoordinates.append(x)
                yLayerCoordinates.append(y)

            TwoxCoordinates.append(xLayerCoordinates)
            TwoyCoordinates.append(yLayerCoordinates)
        
        print(TwoxCoordinates, TwoyCoordinates)
        plt.scatter(curvedLineXCoordinates, curvedLineYCoordinates, c='r')
        plt.plot(TwoxCoordinates, TwoyCoordinates, 'r')

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
        #pixelIndices.append(layerIndexList)

    
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
    print(MM)


    
    
    #plt.plot(ZeroxCoordinates, ZeroyCoordinates, 'r')
    # this only gives lines that have nodes that line up exactly (i.e. a line through the node 6 in each layer)
    # TODO: in the cases where a node doesn't have 11 or 10 and 01, turn all the links for that node to 00; for the nodes that had either 10 or 01 but not both, look at the corresponding node and turn the corresponding link to 0. Then turn that node's links to 00.

    # might be able to replace all this code to another call to pruneglobalmatrix
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

    print(MM)
    for middleLayer in range(3):
        for node in range(16):
            if '11' in MM[node+(middleLayer)*16] or ('01' in MM[node+(middleLayer)*16] and '10' in MM[node+(middleLayer)*16]):
                for adjacentNode in range(16):
                    if middleLayer == 0:
                        if MM[node+(middleLayer)*16][adjacentNode][0] == '1' and ('10' in MM[adjacentNode+(middleLayer+1)*16] or '11' in MM[adjacentNode+(middleLayer+1)*16]):
                            # access x,y of layer above (if middlelayer 1, if we have a 1, )
                            # if we are layer 1, above layer is layer 2
                            # this is for above layer
                            print("hello")
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
                            print(MMxCoordinates)
                            print(MMyCoordinates)

                            plt.plot(MMxCoordinates, MMyCoordinates, 'b')
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
                            print(MMxCoordinates)
                            print(MMyCoordinates)

                            plt.plot(MMxCoordinates, MMyCoordinates, 'b')
                            #plt.show()
                        else:
                            pass

                    elif middleLayer == 1:
                        if MM[node+(middleLayer)*16][adjacentNode][0] == '1' and ('10' in MM[adjacentNode+(middleLayer+1)*16] or '11' in MM[adjacentNode+(middleLayer+1)*16]):
                            # access x,y of layer above (if middlelayer 1, if we have a 1, )
                            # if we are layer 1, above layer is layer 2
                            # this is for above layer
                            print("hello")
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
                            plt.plot(MMxCoordinates, MMyCoordinates, 'b')
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

                            plt.plot(MMxCoordinates, MMyCoordinates, 'b')
                            #plt.show()
                        else:
                            pass
                    elif middleLayer == 2:
                        if MM[node+(middleLayer)*16][adjacentNode][0] == '1':
                            # access x,y of layer above (if middlelayer 1, if we have a 1, )
                            # if we are layer 1, above layer is layer 2
                            # this is for above layer
                            print("hello")
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

                            plt.plot(MMxCoordinates, MMyCoordinates, 'b')
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

                            plt.plot(MMxCoordinates, MMyCoordinates, 'b')
                            #plt.show()
                        else:
                            pass
    

    with PdfPages('./twoStraightLinesTests/test_' + datetime.datetime.now().strftime('%Y%m%d%H%M%S') + '.pdf') as pdf:
        pdf.savefig()
        plt.close()
    
    onlyfiles = [f for f in listdir('./twoStraightLinesTests') if isfile(join('./twoStraightLinesTests', f))]
    merger = PdfFileMerger()

    iterator = -1
    for file in onlyfiles:
        iterator += 1

    print(iterator)
    time.sleep(1)
    if iterator == 100:
        if '.DS_Store' in onlyfiles:
            onlyfiles.remove('.DS_Store')
        for file in onlyfiles:
            merger.append('./twoStraightLinesTests/' + file)
        merger.write("twoStraightLinesResult.pdf")
        merger.close()

    #plt.show()
    
    
    """

    for link in MM:
        # go through MM and color in each link in black
    
    
    return 
    """
    
if __name__ == "__main__":
    layerRadii = [5, 10, 15, 20, 25] # in centimeters
    middleNodes = [6, 13] #going to need to turn this into 2d array and it will need to be passed in from fullsystem since it will change every time
    curvedNode = 6
    visualize(2, layerRadii, middleNodes, curvedNode)
