%Quadrant determination test

clear
params.detNum = 32;
d = 360/params.detNum;
R = zeros(3,params.detNum);
R(1,:) = double(0:d:(360-d));   
R(2,:) = floor(R(1,:)/45);



R(3,:) = uint8((R(2,:))/2)+1;

R(3,R(3,:)==5) = 1;
flist = {@f1, @f2, @f3, @f4};
for r = 1:length(R(3,:))
    flist{R(3,r)}(R(1,r))
end
%R(3,:) = R(3,:) - 4*mod(R(3,:),4)

function f1(x)
    disp([x,1]);
end

function f2(x)
    disp([x,2]);
end

function f3(x)
    disp([x,3]);
end

function f4(x)
    disp([x,4]);
end