clear;
addpath('../toolbox');

params.scanRad = 50;
params.detLen = 40;
params.detNum = 200;
params.viewNum = 200;
params.pxNum = 200;
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

tic
figure(3);
A = ProjectDDM_matrix(params);
b = A*img(:);
b = reshape(b,params.detNum, length(params.rotations))';
imshow(b,[]);
toc

%VerifyPhantomSinogram