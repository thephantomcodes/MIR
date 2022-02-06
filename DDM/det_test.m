clear;

src = [0,50];
det1 = [-7.5,-50];
det2 = [-5,-50];
coords = [-10:1.25:10];
px1 = meshgrid(coords);
px2 = px1';
px = [px1(:),px2(:)];
clear px1 px2;

theta = 30*pi/180;
rot = [cos(theta) -sin(theta); sin(theta), cos(theta)];

src= src*rot;
det1 = det1 * rot;
det2 = det2 * rot;

figure(1)
hold on;
scatter(px(:,1),px(:,2), 'b.')
plot([src(1),det1(1)], [src(2),det1(2)], 'r')
plot([src(1),det2(1)], [src(2),det2(2)], 'r')

d = [0 0 0; [src,1]; [det1,1]];
e = [0 0 0; [src,1]; [det2,1]];
for m = 1:length(px)
    d(1,:) = [px(m,:),1];
    e(1,:) = [px(m,:),1];
    if sign(det(d)) > -1 && sign(det(e)) < 1
        scatter(px(m,1),px(m,2),'r*')
    end
end

