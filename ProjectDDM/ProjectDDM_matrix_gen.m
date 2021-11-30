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
%figure(2);
%imshow(sgram,[]);
% title('Sinogram for Shepp-Logan Phantom');
% save('data/sinogramPhantom.mat', 'sgram');
toc

tic
A = ProjectDDM_matrix(params);
sgram2 = A*img(:);
img2 = reshape(A'*sgram(:),params.pxNum,params.pxNum);
%imshow(img2,[]);
Srow_full = sum(A,2);
Scol_full = sum(A,1);
Srow = zeros(params.pxNum^2,1);
Scol = zeros(1, params.detNum*params.viewNum);
disp("sgram projection: matrix vs inline.");
disp(max(sgram(:)-sgram2(:)));
toc

tic
b = zeros(size(sgram));
for idx = 1:params.viewNum
    params.rotations = rotations(idx);
    A = ProjectDDM_matrix(params);
    Scol = Scol + sum(A,1);
    Srow(1+(idx-1)*params.detNum:idx*params.detNum, :) = sum(A,2);
    %b(idx,:) = A*img(:);
    %b(idx) = reshape(b,params.detNum, length(params.rotations))';
end
disp("matrix row and col sums: full vs partial.");
disp([min(Scol_full - Scol), max(Scol_full - Scol)]);
disp([min(Srow_full - Srow), max(Srow_full - Srow)]);
toc

tic
params.rotations = rotations;
img3 = BackProjectDDM(params, sgram);
figure(3);
imshow(img3,[]);
disp("sgram back projection: matrix vs inline:");
disp(max(img2(:)-img3(:)));
%figure(3);
%imshow(b,[]);
%max(sgram(:)-b(:))
toc

%VerifyPhantomSinogram