clear;
addpath('../toolbox');

params.scanRad = 50;
params.detLen = 40;
params.detNum = 128;
params.viewNum = 128;
params.pxNum = 128;
params.phantomRad = 10;
params.rows = 1:params.pxNum;
params.fieldOfView = 360;
rotations = 0:params.fieldOfView/params.viewNum:params.fieldOfView-1/params.viewNum;
params.rotations = rotations;
disp(params);

tic
img = phantom(params.pxNum);
sgram = ProjectDDM(params, img);
toc

SART(params, sgram, 5);