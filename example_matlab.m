% Example Matlab script for Orthographic Pose Estimation

% Copyright (c) 2017 Laura F. Julia <laura.fernandez-julia@enpc.fr>
% All rights reserved.
%
% This program is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
% 
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
% 
% You should have received a copy of the GNU General Public License
% along with this program.  If not, see <http://www.gnu.org/licenses/>.

clear;
close all;

addpath('lib');

rng('shuffle');

%% Dataset info %%%
im_path='data/';
image_names={'input_0.png','input_1.png','input_2.png'};
info=imfinfo(strcat(im_path,image_names{1}));
imsize=[info.Width;info.Height];

zoomFactor=8; % zoom-out factor from original images
pixPerMm=imsize(1)*zoomFactor/24; % Canon EOS Mark ii sensor: 24x36mm
focalMm=1000; % 1000mm focal length
focal=focalMm*pixPerMm;

mainPoseEstimation(focal);
