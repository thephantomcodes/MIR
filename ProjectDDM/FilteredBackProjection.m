clear;
addpath('../toolbox');
addpath('~/data/dicom/');

params.scanRad = 50;
params.detLen = 55;
params.detNum = 512;
params.viewNum = 512;
params.pxNum = 512;
params.phantomRad = 10;
params.rows = 1:params.pxNum;
params.fieldOfView = 360;
rotations = 0:params.fieldOfView/params.viewNum:params.fieldOfView-1/params.viewNum;
params.rotations = rotations;
disp(params);

img = phantom(params.pxNum);
%img = MakeDisc(params.pxNum, 200);
% img = dicomread("ID_0000_AGE_0060_CONTRAST_1_CT.dcm");
% img = imresize(img, 0.5);

disp("Full Reconstruction");
tic; sgram = ProjectDDM(params, img); toc;
tic; sgram_filtered = RampFilter(params, sgram); toc;
tic; img_fbp_full = BackProjectDDM(params, sgram_filtered); toc;

disp("Fiew View Reconstruction");
params.viewNum = 128;
rotations = 0:params.fieldOfView/params.viewNum:params.fieldOfView-1/params.viewNum;
params.rotations = rotations;
tic; sgram = ProjectDDM(params, img); toc;
tic; sgram_filtered = RampFilter(params, sgram); toc;
tic; img_fbp_fiew = BackProjectDDM(params, sgram_filtered); toc;

disp("SART Reconstruction");
tic; img_sart = SART(params, sgram, 5); toc;

subplot(1,3,1); imshow(img_fbp_full, [])
title("Full Reconstruction");
subplot(1,3,2); imshow(img_fbp_fiew, [])
title("Fiew View Reconstruction");
subplot(1,3,3); imshow(img_sart, [])
title("SART Reconstruction");