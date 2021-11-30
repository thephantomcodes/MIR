if ~exist('img_gt','var')
    load('data/backprojPhantomGT.mat');
end

if ~exist('img','var')
load('data/backprojPhantom.mat');
end

if max(img(:)-img_gt(:)) > 1.0e-12
    disp('fail')
else
    disp('pass')
end