clear;
addpath('../toolbox');

params.scanRad = 50;
params.detLen = 40;
params.detNum = 512;
params.viewNum = 512;
params.pxNum = 512;
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

ramp = abs(linspace(-1, 1, params.detNum))';
ramp = repmat(ramp, [1,params.viewNum]);

sgram_filtered = fftshift(fft(sgram,[],1),1);
sgram_filtered = sgram_filtered .* ramp;
sgram_filtered = ifftshift(sgram_filtered,1);
sgram_filtered = real(ifft(sgram_filtered .* ramp,[],1));

%imshow(abs(sgram_filtered),[]);

tic
img_fbp = BackProjectDDM(params, sgram_filtered);
imshow(img_fbp,[]);
toc
