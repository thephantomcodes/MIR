% clear;

params = makeParams(32);
R = params.scanRad;
r = params.phantomRad;
s = [0,params.scanRad];

%A = polynomial approx
A = zeros(1,params.detNum);

%B = true value, secant method
B = zeros(1,params.detNum);

% 
% figure(1);
% hold on;
% scatter(s(1),s(2));
% xlim([-35,35]);
% ylim([-55,15]);

for det = 1:params.detNum/2 + 1
    dx1 = params.det(det);
    if det > 1
        ax2 = ax1;
        bx2 = bx1;
        ay2 = ay1;
        by2 = by1;
    end
    
    if dx1 ~= 0
        m = -2*R/dx1;
        mm = m^2 + 1;
        x1 = 2*m*R;
        x2 = sqrt(x1^2 - 4*mm*(R^2 -r^2));
        ax1 = (-x1+x2)/(2*mm);
        bx1 = (-x1-x2)/(2*mm);
        ay1 = m*ax1 + R;
        by1 = m*bx1 + R;
    else
        ax1 = 0;
        bx1 = 0;
        ay1 = r;
        by1 = -r;
    end
    
%     scatter([ax1, bx1, dx1], [ay1, by1, -R], '.');
    if det > 1
        A(det-1) = polyarea([ax2 ax1 bx1 bx2], [ay2 ay1 by1 by2]);
        A(det-1) = A(det-1)/params.pxWidth^2;
        %A(det-1) = polygonArea([ax2 ay2; ax1 ay1; bx1 by1; bx2 by2]);
    end
    
    a1 = [ax1, ay1];
    %a2 = [ax2, ay2];
    b1 = [bx1, by1];
    %b2 = [bx2, by2];
    if det > 1
        theta2 = theta1;
        a2 = [ax2, ay2];
        b2 = [bx2, by2];
    end
    theta1 = acos(dot(b1 / norm(b1), a1 / norm(a1)));
    if det > 1
        B(det-1) = 0.5*r^2*(theta1 - theta2);
        B(det-1) = B(det-1) - polygonArea([zeros(1,2); a1; b1]);
        B(det-1) = B(det-1) + polygonArea([zeros(1,2); a2; b2]);
    end
end

A(end:-1:params.detNum/2+1) = A(1:params.detNum/2);
B(end:-1:params.detNum/2+1) = B(1:params.detNum/2);
B = B / params.pxWidth^2;

figure(2);
hold on;
%plot(sgram0);
%plot(sgram(1,:));
plot(A);
plot(B); 
legend('DDM', 'AIM', 'B');