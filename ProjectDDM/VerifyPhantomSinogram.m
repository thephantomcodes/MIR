if ~exist('s','var')
    load('data/sinogramPhantomOld.mat');
end

if ~exist('sgram','var')
load('data/sinogramPhantom.mat');
end

if max(s(:)-sgram(:)) > 1.0e-12
    disp('fail')
else
    disp('pass')
end