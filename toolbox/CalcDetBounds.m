function [ DetBounds ] = CalcDetBounds( ScanRadius, DetLen, DetNum )
    DetBounds = zeros(DetNum+1,2);
    DetBounds(:,1) = DetLen*(-1/2:1/DetNum:1/2)';
    DetBounds(:,2) = -ScanRadius;
end