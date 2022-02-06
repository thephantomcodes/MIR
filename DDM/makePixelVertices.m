function [px] = makePixelVertices(params)
% px1 = meshgrid(params.phantomRad-params.pxWidth:-params.pxWidth:-params.phantomRad);
% px2 = meshgrid(params.pxWidth-params.phantomRad:params.pxWidth:params.phantomRad);
px1 = meshgrid(-params.phantomRad:params.pxWidth:params.phantomRad-params.pxWidth);
px2 = meshgrid(params.pxWidth-params.phantomRad:params.pxWidth:params.phantomRad);
px2 = flip(px2',1);
px = [px1(:),px2(:)];
clear px1 px2;
end

