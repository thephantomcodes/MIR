function [ detVal ] = ProjectDDM( params, img )

src = [0, params.scanRad];
detBounds = CalcDetBounds(params.scanRad, params.detLen, params.detNum);

pxBoundsFixed = CalcPxBounds(params.pxNum, params.phantomRad)';
pxBounds = zeros(params.pxNum+1,1);
pxBounds(:,2) = 1:params.pxNum+1;%%
pxBounds(:,3) = [0; abs(diff(pxBounds(:,1)))];
pxBounds(:,4) = zeros(params.pxNum+1,1);
pxBounds(:,5) = 0;
pxCenters = CalcPxCenters(params.pxNum, params.phantomRad);


ang = params.deg*pi/180;
rotMat = [cos(ang) sin(ang); -sin(ang) cos(ang)];

detBounds = (rotMat*detBounds')';
src = (rotMat*src')';

detVal = zeros(1,params.detNum);

for row = params.rows % index of image row or column
    projBounds = ProjectDetBounds( detBounds, src, 0, params.deg );
    if projBounds(1) < projBounds(2)
        projBounds(:,2) = 1:params.detNum+1;
        projBounds(:,3) = [abs(diff(projBounds(:,1))); 0];
    else
        projBounds(:,2) = 0:params.detNum;
        projBounds(:,3) = [0;abs(diff(projBounds(:,1)))];
    end
    if params.deg<=45 || params.deg>=315 || (params.deg>=135 && params.deg<=225)
        pxCoords = [pxBoundsFixed, repmat(pxCenters(row),params.pxNum+1,1)];
        pxBounds(:,1) = ProjectDetBounds( pxCoords, src, 0, params.deg );
        cosRay = src(2)./sqrt((projBounds(:,1) - src(1)).^2 + src(2).^2)';
        pxVals = img(row,:);
        pxBounds(:,4) = [pxVals,0];
    else
        pxCoords = [repmat(pxCenters(row),params.pxNum+1,1), pxBoundsFixed];
        pxBounds(:,1) = ProjectDetBounds( pxCoords, src, 0, params.deg );
        cosRay = src(1)./sqrt((projBounds(:,1) - src(2)).^2 + src(1).^2)';
        pxVals = img(:,row)';
        pxBounds(:,4) = [pxVals,0];
    end
    pxBounds(:,3) = [0; abs(diff(pxBounds(:,1)))];
    projBounds(:,4) = 0;
    projBounds(:,5) = 1;
    lastBound = max(projBounds(:,1));
        
    allBounds = sortrows([projBounds;pxBounds],1);
    allBounds(:,6) = [diff(allBounds(:,1));0];
    
    detFound = 0;
    denom = 0;
    lastPx = 0;
    
    for m=1:length(allBounds)
        switch allBounds(m,5)
            case 0
                if allBounds(m,2) > params.pxNum
                   break 
                end
                lastPx = allBounds(m,4);
                if detFound > 0
                    correction = abs(cosRay(detFound) + cosRay(detFound+1))/2;
                    weight = allBounds(m,6)/(denom*correction);
                    detVal(detFound) = detVal(detFound) + weight*lastPx;
                end
            case 1
                if allBounds(m,1) >= lastBound
                    break
                end
                denom = allBounds(m,3);
                detFound = allBounds(m,2);
                correction = abs(cosRay(detFound) + cosRay(detFound+1))/2;
                weight = allBounds(m,6)/(denom*correction);
                detVal(detFound) = detVal(detFound) + weight*lastPx;
        end
    end
end
% lenCR = length(cosRay);
% cosRay = abs(cosRay(1:lenCR-1) + cosRay(2:lenCR))/2;
% detVal = detVal./cosRay;

end