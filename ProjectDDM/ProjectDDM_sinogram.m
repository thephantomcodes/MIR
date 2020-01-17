clear;

params.scanRad = 50;
params.detLen = 40;
params.detNum = 256;
params.pxNum = 256;
params.phantomRad = 10;
params.rows = 1:params.pxNum;

params.rotations = 0:180/params.detNum:180;

img = MakeDisc(params.pxNum,params.pxNum);
%sgram = zeros(length(params.rotations),params.detNum);

%for r = 1:length(rotations)
    %params.deg = rotations(r);
    sgram = ProjectDDM(params, img);
%end
figure(1);
imshow(sgram,[]);
title('Sinogram for uniform disc');
save('data/sinogramDisc.mat', 'sgram');

img = phantom(params.pxNum);
sgram = zeros(length(params.rotations),params.detNum);

%for r = 1:length(rotations)
    %params.deg = rotations(r);
    sgram = ProjectDDM(params, img);
%end
figure(2);
imshow(sgram,[]);
title('Sinogram for Shepp-Logan Phantom');
save('data/sinogramPhantom.mat', 'sgram');

VerifyPhantomSinogram