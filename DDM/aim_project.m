function sgram = aim_project(img,params)

V = makePixelVertices(params);
R = 0:360/params.detNum:360;
%D = -params.detLen/2:params.detWidth:params.detLen/2;
sgram = zeros(length(R)-1,params.detNum);

% figure(1);
% hold on;

for n = 1:length(R)-1
    display(['n=',num2str(n)]);
    r = R(n)*pi/180;
    rot = [cos(r) -sin(r); sin(r), cos(r)];
    src= params.src*rot;
    %scatter(src(1),src(2));
     
    for m = 1:length(params.det)-1
        det1 = [params.det(m),-params.scanRad] * rot;
        det2 = [params.det(m+1),-params.scanRad] * rot;
        A = aim_list(V,src,det1,det2,params.pxWidth);
        sgram(n,m) = A' * img;
        %display(['x=',num2str(x)]);
    end
end
end

