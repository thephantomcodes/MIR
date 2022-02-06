function [params] = makeParams(numPx)
    if nargin < 1
       numPx = 4;
    end
    params.scanRad = 50;
    params.detLen = 40;
    params.pxNum = numPx;
    params.detNum = numPx;
    params.phantomRad = 10;
    params.pxWidth = 2*params.phantomRad/params.pxNum;
    params.src = [0,params.scanRad];
    params.detWidth = params.detLen/params.detNum;
    params.det = -params.detLen/2:params.detWidth:params.detLen/2;
%     params.rows = 1:params.pxNum;
%     params.rotations = 0:180/params.detNum:180;
end

