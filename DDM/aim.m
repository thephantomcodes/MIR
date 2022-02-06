function [a] = aim(v,s,d1,d2,w)
% hold on
% plot([d1(1) s(1)], [d1(2) s(2)])
% plot([d2(1) s(1)], [d2(2) s(2)])

V = [v(1),v(2); v(1),v(2)-w; v(1)+w,v(2)-w; v(1)+w,v(2);];
%c = [v(1)+w/2, v(2)-w/2];
polygon = zeros(6,2);
pindex = 0;
tolerance = 1e-6;
o1 = zeros(4,1);
o2 = zeros(4,1);

for n = 1:4
   o1(n) = orientation(s,d1,V(n,:),tolerance);
   o2(n) = orientation(s,d2,V(n,:),tolerance);
   if o1(n) > -1 && o2(n) < 1
       pindex = pindex+1;
       polygon(pindex,:) = V(n,:);
   end
end

if pindex == 4
    a = 1;
    return
end

if pindex == 0 && (abs(sum(o1+o2)) == 4 || abs(sum(o2)) == 4)
    a = 0;
    return
end

D = [d1; d2];

for n = 1:2
    y = ycrossing(s,D(n,:),V(1,:));
    %if y - V(1,2) <= tolerance && y - V(2,2) >= -tolerance
    if y < V(1,2) && y > V(2,2)
        pindex = pindex+1;
        polygon(pindex,:) = [V(1,1), y];
    end

    y = ycrossing(s,D(n,:),V(4,:));
    %if y - V(4,2) <= tolerance  && y - V(3,2) >= -tolerance
    if y < V(4,2)  && y > V(3,2)
        pindex = pindex+1;
        polygon(pindex,:) = [V(4,1), y];
    end

    x = xcrossing(s,D(n,:),V(1,:));
    %if x - V(1,1) >= -tolerance && x - V(4,1) <= tolerance
    if x > V(1,1) && x < V(4,1)
        pindex = pindex+1;
        polygon(pindex,:) = [x, V(1,2)];
    end

    x = xcrossing(s,D(n,:),V(2,:));
    %if x - V(2,1) >= -tolerance && x - V(3,1) <= tolerance
    if x > V(2,1) && x < V(3,1)
        pindex = pindex+1;
        polygon(pindex,:) = [x, V(2,2)];
    end
end

if pindex < 3
    a = 0.0;
    return
end

% plot(V(:,1), V(:,2)); 
% plot(polygon(:,1), polygon(:,2));

c = [mean(polygon(1:pindex,1)), mean(polygon(1:pindex,2))];
polygon = polygonSort(polygon(1:pindex,:),c);
a = polygonArea(polygon) / (w*w);
%a = polyarea(polygon(:,1), polygon(:,2))/ (w*w);
end

function o = orientation(s,d,v,tolerance)
    d0 = d-s;
    v0 = v - s;
    d = d0(1)*v0(2) - d0(2)*v0(1);
    if abs(d) < tolerance
        d = 0;
    end
    o = sign(d);
end

function x = xcrossing(s,d,v)
    x = s(1)*v(2) + d(1)*s(2) - s(1)*d(2) - d(1)*v(2);
    x = x / (s(2) - d(2));
end

function y = ycrossing(s,d,v)
    y = d(1)*s(2) + v(1)*d(2) - s(1)*d(2) - v(1)*s(2);
    y = y / (d(1) - s(1));
end

function a = polygonSort(p,c)
    a = p - c;
    [theta, r] = cart2pol(a(:,1),a(:,2));
    a = sortrows([theta,r],1);
    [x, y] = pol2cart(a(:,1),a(:,2));
    a = [x, y] + c;
end
