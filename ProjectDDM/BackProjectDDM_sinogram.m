%----------------------
% Perform DDM back projection of SLP and uniform disc
%----------------------

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

params.rotations = 0:params.fieldOfView/params.viewNum:params.fieldOfView-1/params.viewNum;
disp(params);

projDisc = 0;

if projDisc == 1
    tic
    img = MakeDisc(params.pxNum,params.pxNum);
    sgram = ProjectDDM(params, img);
    img = BackProjectDDM(params, sgram);
    figure(1);
    imshow(img,[]);
    title('Back Projected uniform disc');
    save('data/backprojDisc.mat', 'img');
    toc
end

tic
img = phantom(params.pxNum);
sgram = ProjectDDM(params, img);
toc

tic
img = BackProjectDDM(params, sgram);
figure(2);
imshow(img,[]);
title('Back Projected Shepp-Logan Phantom');
save('data/backprojPhantom.mat', 'img');
toc

VerifyBackProjSinogram