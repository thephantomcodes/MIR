v = [-5,0];
params = makeParams(4);

r = 45*pi/180;
rot = [cos(r) -sin(r); sin(r), cos(r)];
src = params.src *rot;

D = -params.detLen/2:params.detWidth:params.detLen/2;
det1 = [D(2),-params.scanRad] * rot;
det2 = [D(3),-params.scanRad] * rot;

A = aim(v,src,det1,det2,params.pxWidth,0);
sgram = A' * img;