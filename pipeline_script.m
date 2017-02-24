
clear;

%% Dataset info %%%
im_path='data/';
images_names={'_MG_0441.JPG','_MG_0445.JPG','_MG_0447.JPG'};
corresp_files={'corresp__MG_0441.JPG__MG_0445.JPG.txt',...
    'corresp__MG_0445.JPG__MG_0447.JPG.txt',...
    'corresp__MG_0441.JPG__MG_0447.JPG.txt'};
imsize=[3744;5616]; focal=1000*156;
CalM=repmat([focal,0,imsize(1)/2;0,focal,imsize(2)/2;0,0,1],3,1);

%% Read matches from files

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


%% A C RANSAC with Orthographic model %%%
[inliers,Sol,ransac_th]=AC_RANSAC_Orthographic(Corresp,CalM,imsize);

%% Orthographic model with all inliers %%%
[Sol1,Sol2]=OrthographicPoseEstimation(Corresp(:,inliers),CalM);

%% B A for both possible solutions %%%
R_t_0=[Sol1{1},Sol1{2}];
[R_t_1,Reconst1,iter1,repr_err1]=BundleAdjustment(CalM,R_t_0,Corresp(:,inliers));

R_t_0=[Sol2{1},Sol2{2}];
[R_t_2,Reconst2,iter2,repr_err2]=BundleAdjustment(CalM,R_t_0,Corresp(:,inliers));

%% Choose solution with less repr. err. %%%
if repr_err1<repr_err2
    Solution=R_t_1;
else
    Solution=R_t_2;
end

%% Orientations 
R2=Solution(4:6,1:3); t2=Solution(4:6,4);
R3=Solution(7:9,1:3); t3=Solution(7:9,4);

