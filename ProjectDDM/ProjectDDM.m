function [ sgram ] = ProjectDDM( params, img )

sgram = zeros(params.detNum, length(params.rotations));
pxBoundsFixed = CalcPxBounds(params.pxNum, params.phantomRad)';

for rotation = 1:length(params.rotations)
src = [0, params.scanRad];
detBounds = CalcDetBounds(params.scanRad, params.detLen, params.detNum);

pxBounds = zeros(params.pxNum+1,5);
pxBounds(:,2) = 1:params.pxNum+1;%%
pxBounds(:,3) = [0; abs(diff(pxBounds(:,1)))];
pxBounds(:,4) = zeros(params.pxNum+1,1);
pxBounds(:,5) = 0;
pxCenters = CalcPxCenters(params.pxNum, params.phantomRad);


params.deg = params.rotations(rotation);

ang = params.deg*pi/180;
rotMat = [cos(ang) sin(ang); -sin(ang) cos(ang)];

detBounds = (rotMat*detBounds')';
src = (rotMat*src')';

%detVal = zeros(1,params.detNum);

for row = params.rows % index of image row or column
    projDetBounds = ProjectDetBounds( detBounds, src, 0, params.deg );
    if projDetBounds(1) < projDetBounds(2)
        projDetBounds(:,2) = 1:params.detNum+1;
        projDetBounds(:,3) = [abs(diff(projDetBounds(:,1))); 0];
    else
        projDetBounds(:,2) = 0:params.detNum;
        projDetBounds(:,3) = [0;abs(diff(projDetBounds(:,1)))];
    end
    if params.deg<=45 || params.deg>=315 || (params.deg>=135 && params.deg<=225)
        pxCoords = [pxBoundsFixed, repmat(pxCenters(row),params.pxNum+1,1)];
        pxBounds(:,1) = ProjectDetBounds( pxCoords, src, 0, params.deg );
        cosRay = src(2)./sqrt((projDetBounds(:,1) - src(1)).^2 + src(2).^2)';
        pxBounds(:,4) = [img(row,:),0];
    else
        pxCoords = [repmat(pxCenters(row),params.pxNum+1,1), pxBoundsFixed];
        pxBounds(:,1) = ProjectDetBounds( pxCoords, src, 0, params.deg );
        cosRay = src(1)./sqrt((projDetBounds(:,1) - src(2)).^2 + src(1).^2)';
        pxBounds(:,4) = [img(:,row)',0];
    end
    pxBounds(:,3) = [0; abs(diff(pxBounds(:,1)))];
    projDetBounds(:,4) = 0;
    projDetBounds(:,5) = 1;
    lastBound = max(projDetBounds(:,1));
        
    allBounds = sortrows([projDetBounds;pxBounds],1);
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
                    weight = allBounds(m,6)/(denom);
                    sgram(detFound,rotation) = sgram(detFound,rotation) + weight*lastPx;
                end
            case 1
                if allBounds(m,1) >= lastBound
                    break
                end
                detFound = allBounds(m,2);
                denom = allBounds(m,3)*abs(cosRay(detFound) + cosRay(detFound+1))/2;
                weight = allBounds(m,6)/(denom);
                sgram(detFound,rotation) = sgram(detFound,rotation) + weight*lastPx;
        end
    end
end
% lenCR = length(cosRay);
% cosRay = abs(cosRay(1:lenCR-1) + cosRay(2:lenCR))/2;
% detVal = detVal./cosRay;

end
end