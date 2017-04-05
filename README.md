# OrthographicPE
Pose estimation of 3 views based on the orthographic model.

This MATLAB(R) / GNU OCTAVE directory contains the code associated to the IPOL submission "The Orthographic Projection Model for Pose Calibration of Long Focal Images" by Laura F. Julia, Pascal Monasse and Marc Pierrot-Deseilligny.

## CONTENT
This directory should contain the following files and folders:

Files                         | Description
:---------------------------- | :------------------------------------------------------------------
data/                         | folder with three example images and their correspondences by pairs
README.md                     | this file
LICENSE                       | license file
OrthographicPoseEstimation.m  | pose estimation of N orthographic views from corresponding tracks
AC_RANSAC_Orthographic.m      | a contrario RANSAC adapted to the orthographic model
BundleAdjustment.m            | function computing bundle adjustment for an initial pose
matches2triplets.m            | function to extract tracks from pairs of correspondences
triangulation3D.m             | 3d triangulation from image points and camera matrices
Normalize2Ddata.m             | isometric normalization of 2D points
ReprError.m                   | computation of the reprojection error of N points and M cameras
pipeline_matlab.m             | Example script for Matlab use
pipeline_octave.m             | Example script for GNU Octave use


## SETUP & USAGE
### MATLAB
1. You must have MATLAB software installed on your computer.
2. Copy/move the 'OrthographicPE' folder to the MATLAB 'work' directory.
3. Open MATLAB and add the 'OrthographicPE' directory to the Path.
4. Run the example script pipeline_matlab.m to easily use the code. It contains all the necessary steps for the pose estimation of three perspective views using the orthographic model. The data used as example is in the data/ folder.

### OCTAVE
1. You must have GNU Octave installed on you computer. You can install it in Ubuntu systems running the following command:
```
sudo apt-get install octave
```
2. Two packages are necessary to run the functions in this directory: statistics and optim. To install them, run the following commands in the Octave terminal:
```
pkg install -forge statistics
pkg install -forge optim
```
3. Run the example script pipeline_octave.m to easily use the code. It contains all the necessary steps for the pose estimation of three perspective views using the orthographic model. The data used as example is in the data/ folder.

