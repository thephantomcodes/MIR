function [ pxBounds ] = CalcPxBounds(pxNum, phantomRad)
    pxBounds = phantomRad*(-1:2/pxNum:1);
end

