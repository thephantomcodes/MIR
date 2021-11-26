%----------------------
% Perform DDM projection of SLP and uniform disc
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

projDisc = 1;

if projDisc == 1
    tic
    img = MakeDisc(params.pxNum,params.pxNum);
    sgram = ProjectDDM(params, img);
    figure(1);
    imshow(sgram,[]);
    title('Sinogram for uniform disc');
    save('data/sinogramDisc.mat', 'sgram');
    toc
end

tic
img = phantom(params.pxNum);
sgram = ProjectDDM(params, img);
figure(2);
imshow(sgram,[]);
title('Sinogram for Shepp-Logan Phantom');
save('data/sinogramPhantom.mat', 'sgram');
toc

VerifyPhantomSinogram