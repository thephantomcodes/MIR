clear;
addpath('../toolbox');

params.scanRad = 50;
params.detLen = 40;
params.detNum = 256;
params.viewNum = 256;
params.pxNum = 256;
params.phantomRad = 10;
params.rows = 1:params.pxNum;
params.fieldOfView = 360;
rotations = 0:params.fieldOfView/params.viewNum:params.fieldOfView-1/params.viewNum;
params.rotations = rotations;
disp(params);

img = phantom(params.pxNum);
%img = MakeDisc(params.pxNum, 200);

disp("Full Reconstruction");
tic; sgram = ProjectDDM(params, img); toc;
tic; sgram_filtered = RampFilter(params, sgram); toc;
tic; img_fbp_full = BackProjectDDM(params, sgram_filtered); toc;

disp("Fiew View Reconstruction");
params.viewNum = 64;
rotations = 0:params.fieldOfView/params.viewNum:params.fieldOfView-1/params.viewNum;
params.rotations = rotations;
tic; sgram = ProjectDDM(params, img); toc;
tic; sgram_filtered = RampFilter(params, sgram); toc;
tic; img_fbp_fiew = BackProjectDDM(params, sgram_filtered); toc;

subplot(1,2,1); imshow(img_fbp_full,[]);
title("Full Reconstruction");
subplot(1,2,2); imshow(img_fbp_fiew,[]);
title("Fiew View Reconstruction");