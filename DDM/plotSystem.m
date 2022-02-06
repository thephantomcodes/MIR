hold on; 

%src and det bounds
s = [0,50];
d = [-20 -50; -10 -50; 0 -50; 10 -50; 20 -50];
r = 0*pi/180;
R = [cos(r) -sin(r); sin(r), cos(r)];


%plot rays
s = s*R;
for n = 1:5
   d(n,:) =  d(n,:)*R;
   plot([s(1,1),d(n,1)],[s(1,2),d(n,2)],'b')
end

%plot vert lines
plot([-10,-10],[-10,10],'r')
plot([-5,-5],[-10,10],'r')
plot([0,0],[-10,10],'r')
plot([5,5],[-10,10],'r')
plot([10,10],[-10,10],'r')

%plot hor lines
plot([-10,10],[-10,-10],'r')
plot([-10,10],[-5,-5],'r')
plot([-10,10],[0,0],'r')
plot([-10,10],[5,5],'r')
plot([-10,10],[10,10],'r')