function [ pxCenters ] = CalcPxCenters( pxNum, phantomRad )
    pxCenters = phantomRad/pxNum*((1-pxNum):2:(pxNum-1));
end

