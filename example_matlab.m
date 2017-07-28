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

%% Dataset info %%%
im_path='data/';
image_names={'input_0.png','input_1.png','input_2.png'};
corresp_files={'01.txt','12.txt','02.txt'};
info=imfinfo(strcat(im_path,image_names{1}));
imsize=[info.Width;info.Height];
zoomFactor=8; % zoom-out factor from original images
pixPerMm=imsize(1)*zoomFactor/24; % Canon EOS Mark ii sensor: 24x36mm
focalMm=1000; // 1000mm focal length
focal=focalMm*pixPerMm;
CalM=repmat([focal,0,imsize(1)/2;0,focal,imsize(2)/2;0,0,1],3,1);

%% Read matches from files %%%

% read matches between image 1 and image 2
dataFile = fopen(strcat(im_path,corresp_files{1}),'r');
corresp12 = fscanf(dataFile,'%f');
fclose(dataFile);
corresp12=reshape(corresp12,4,[]);

% read matches between image 2 and image 3
dataFile = fopen(strcat(im_path,corresp_files{2}),'r');
corresp23 = fscanf(dataFile,'%f');
fclose(dataFile);
corresp23=reshape(corresp23,4,[]);

% read matches between image 1 and image 3 (optional)
dataFile = fopen(strcat(im_path,corresp_files{3}),'r');
corresp13 = fscanf(dataFile,'%f');
fclose(dataFile);
corresp13=reshape(corresp13,4,[]);


%% Compute tracks %%%
Corresp=matches2triplets(corresp12,corresp23,corresp13);
fprintf('%d tracks between the three images.\n',size(Corresp,2));


%% A C RANSAC with Orthographic model %%%
[inliers,Sol,ransac_th]=AC_RANSAC_Orthographic(Corresp,CalM,imsize);
fprintf('%d inliers were found by AC-RANSAC.\n',length(inliers));

%% Orthographic model with all inliers %%%
[Sol1,Sol2]=OrthographicPoseEstimation(Corresp(:,inliers),CalM);

%% B A for both possible solutions %%%
R_t_0=[Sol1{1},Sol1{2}];
[R_t_1,Reconst1,iter1,repr_err1]=BundleAdjustment(CalM,R_t_0,Corresp(:,inliers));
fprintf('Minimum reached for first solution with %d iterations. ',iter1);
fprintf('Final reprojection error is %f.\n',repr_err1);

R_t_0=[Sol2{1},Sol2{2}];
[R_t_2,Reconst2,iter2,repr_err2]=BundleAdjustment(CalM,R_t_0,Corresp(:,inliers));
fprintf('Minimum reached for second solution with %d iterations. ',iter2);
fprintf('Final reprojection error is %f.\n',repr_err2);

%% Choose solution with less repr. err. %%%
if repr_err1<repr_err2
    Solution=R_t_1;
    Reconst=Reconst1;
else
    Solution=R_t_2;
    Reconst=Reconst2;
end

%% Orientations %%%
R2=Solution(4:6,1:3); t2=Solution(4:6,4);
R3=Solution(7:9,1:3); t3=Solution(7:9,4);


%% PLY file %%%
Color=paintReconstruction(Corresp(1:2,:),strcat(im_path,image_names{1}));
writePLYreconstruction('data/recontruction.ply',CalM,Solution,Reconst,Color);
writeOrientations('data/orientations.txt',Solution);
