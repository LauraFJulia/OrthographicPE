Pose estimation of 3 views based on the orthographic model.

Laura F. Julia, <laura.fernandez-julia@enpc.fr>, Univ. Paris Est, LIGM, ENPC, France

Version ??, May 2017

Future releases and updates:
https://github.com/LauraFJ/OrthographicPE.git

This MATLAB(R) / GNU OCTAVE directory contains the code associated to the IPOL submission "The Orthographic Projection Model for Pose Calibration of Long Focal Images" by Laura F. Julia, Pascal Monasse and Marc Pierrot-Deseilligny.


Files and folders
-----------------

data/                         - folder with three example images and their correspondences by pairs
lib/			      - folder with auxiliary Matlab functions
README.md                     - this file
LICENSE                       - license file
OrthographicPoseEstimation.m  - Main function for pose estimation of orthographic views
pipeline_matlab.m             - Example script for Matlab use
pipeline_octave.m             - Example script for GNU Octave use


Setup and Usage
---------------

MATLAB
------
1. You must have MATLAB software installed on your computer.
2. The folowing toolboxes are required:
  * statistics_toolbox
  * optimization_toolbox
3. Copy/move the 'OrthographicPE' folder to the MATLAB 'work' directory.
4. Run the example script pipeline_matlab.m to easily use the code. It contains all the necessary steps for the pose estimation of three perspective views using the orthographic model. The data used as example is in the data/ folder.

OCTAVE
------
1. You must have GNU Octave installed on you computer. You can install it in Ubuntu systems running the following command:

 sudo apt-get install octave

2. Two packages are necessary to run the functions in this directory: statistics and optim. To install them, run the following commands in the Octave terminal:

 pkg install -forge statistics
 pkg install -forge optim

3. Run the example script pipeline_octave.m to easily use the code. It contains all the necessary steps for the pose estimation of three perspective views using the orthographic model. The data used as example is in the data/ folder.


Copyright and Licence
---------------------

Copyright (c) 2017 Laura F. Julia <laura.fernandez-julia@enpc.fr>
All rights reserved.

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.


