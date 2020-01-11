function [ projBounds ] = ProjectDetBoundsX( detBounds, src, px )
    m = (detBounds(:,2) - src(2))./(detBounds(:,1) - src(1));
    b = src(2) - m*src(1);
    projBounds = (px - b)./m;
    projBounds(isnan(projBounds)) = detBounds(isnan(projBounds));
end