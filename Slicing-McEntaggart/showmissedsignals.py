from mpl_toolkits.mplot3d import Axes3D
import mpl_toolkits.mplot3d.art3d as art3d
import matplotlib.pyplot as plt
import numpy as np

missinfo = np.genfromtxt('output/missedsignalinfo.txt',delimiter=',',skip_header=3)
nrows,ncols = missinfo.shape

for p in range(0,nrows,20):
    signal_phi = missinfo[p:5+p,0]
    signal_r = 1000*0.05*np.asarray([1,2,3,4,5])
    signal_z = missinfo[5+p:10+p,0]
    slice1_phi = missinfo[p:5+p,1:]
    slice1_z = missinfo[5+p:10+p,1:]
    slice2_phi = missinfo[10+p:15+p,1:]
    slice2_z = missinfo[15+p:20+p,1:]
    slice_r = 1000*np.vstack([0.05*np.ones((1,16)),0.1*np.ones((1,16)),0.15*np.ones((1,16)),0.2*np.ones((1,16)),0.25*np.ones((1,16))])
    rot = np.pi / 2.0 - signal_phi[0]             # shift hit at layer 0 of signal to pi for easier visibility in plot
    signal_phi = signal_phi + rot
    slice1_phi = slice1_phi + rot
    slice2_phi = slice2_phi + rot

    fig = plt.figure(figsize=(15,9))
    ax1 = fig.add_subplot(2,2,1)
    ax2 = fig.add_subplot(2,2,2)
    ax3 = fig.add_subplot(2,2,3)
    ax4 = fig.add_subplot(2,2,4)

    ax1.plot(signal_r*np.cos(signal_phi),signal_r*np.sin(signal_phi),'r-')
    ax1.scatter(signal_r*np.cos(signal_phi),signal_r*np.sin(signal_phi),c='r',s=4)
    ax1.scatter(slice_r*np.cos(slice1_phi),slice_r*np.sin(slice1_phi),c='b',s=4)
    ax1.plot(slice_r[:,0]*np.cos(slice1_phi[:,0]),slice_r[:,0]*np.sin(slice1_phi[:,0]),'b--')
    ax1.plot(slice_r[:,0]*np.cos(slice1_phi[:,15]),slice_r[:,0]*np.sin(slice1_phi[:,15]),'b--')
    
    ax2.plot(signal_r*np.cos(signal_phi),signal_r*np.sin(signal_phi),'r-')
    ax2.scatter(signal_r*np.cos(signal_phi),signal_r*np.sin(signal_phi),c='r',s=4)
    ax2.scatter(slice_r*np.cos(slice2_phi),slice_r*np.sin(slice2_phi),c='b',s=4)
    ax2.plot(slice_r[:,0]*np.cos(slice2_phi[:,0]),slice_r[:,0]*np.sin(slice2_phi[:,0]),'b--')
    ax2.plot(slice_r[:,0]*np.cos(slice2_phi[:,15]),slice_r[:,0]*np.sin(slice2_phi[:,15]),'b--')

    ax3.plot(signal_z,signal_r,'r-')
    ax3.scatter(signal_z,signal_r,c='r',s=10)
    ax3.scatter(slice1_z,slice_r,c='b',s=10)

    ax4.plot(signal_z,signal_r,'r-')
    ax4.scatter(signal_z,signal_r,c='r',s=10)
    ax4.scatter(slice2_z,slice_r,c='b',s=10)

    ax1.set_xlabel('x (mm)')
    ax1.set_ylabel('y (mm)')
    ax2.set_xlabel('x (mm)')
    ax2.set_ylabel('y (mm)')
    ax3.set_xlabel('z (m)')
    ax3.set_ylabel('r (mm)')
    ax4.set_xlabel('z (m)')
    ax4.set_ylabel('r (mm)')
    ax1.set_title('slice 0')
    ax2.set_title('slice 1')
    plt.savefig(f'missedsignalfigs/miss{int((p+1)/15)}.png')
    plt.close()

#plt.show()
