# OrthographicPE
Pose estimation of 3 views based on the orthographic model.

This MATLAB(R) directory contains the code associated to the IPOL submission "The Orthographic Projection Model for Pose Calibration of Long Focal Images" by Laura F. Julia, Pascal Monasse and Marc Pierrot-Deseilligny.

## CONTENT
This directory should contain the following files and folders:
  data/                         - folder with three example images and their correspondences by pairs
  README.md                     - this file
  LICENSE                       - license file
  OrthographicPoseEstimation.m  - pose estimation of N orthographic views from corresponding tracks
  AC_RANSAC_Orthographic.m      - a contrario RANSAC adapted to the orthographic model
  BundleAdjustment.m            - function computing bundle adjustment for an initial pose
  matches2triplets.m            - function to extract tracks from pairs of correspondences
  triangulation3D.m             - 3d triangulation from image points and camera matrices
  Normalize2Ddata.m             - isometric normalization of 2D points
  ReprError.m                   - computation of  the reprojection error of N points and M cameras
  pipeline_script.m             - Example script

## SETUP
1. You must have MATLAB software installed on your computer.
2. Copy/move the 'OrthographicPE' folder to the MATLAB 'work' directory.
3. Open MATLAB and add the 'OrthographicPE' directory to the Path.
4. Run the example script detailed in usage section below.

## USAGE
The script pipeline_script.m is provided to easily use the code. It contains all the necessary steps for the pose estimation of three perspective views using the  orthographic model. The data used as example is in the data/ folder.

