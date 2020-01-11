function [ projBounds ] = ProjectDetBounds( detBounds, src, px, rotDeg )
    if rotDeg<=45 || rotDeg>=315 || (rotDeg>=135 && rotDeg<=225)
        projBounds  = ProjectDetBoundsX( detBounds, src, px);
    else
        projBounds  = ProjectDetBoundsY( detBounds, src, px);
    end
end