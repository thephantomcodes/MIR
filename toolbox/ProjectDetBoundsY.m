function [ projBounds ] = ProjectDetBoundsY( detBounds, src, px )
    m = (detBounds(:,1) - src(1))./(detBounds(:,2) - src(2));
    b = src(1) - m*src(2);
    projBounds = (px - b)./m;
    projBounds(isnan(projBounds)) = detBounds(isnan(projBounds));
end