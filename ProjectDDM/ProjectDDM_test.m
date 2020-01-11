clear;

expected0 = [3.4754,4.9130,6.3051,7.4463,3.9466,0,0,0];
expected1 = [0,0,0,0.2692,1.8097,3.4633,4.8637,6.2978];
expected2 = [0,0.1275,2.5971,5.5496];
expected3 = [4.1519,6.8457,2.0673,0];
expected4 = [2.7618,5.1667,5.0421,0];

params.scanRad = 50;
params.detLen = 40;
params.detNum = 4;
params.pxNum = 8;
params.phantomRad = 10;
params.pxWidth = 2*params.phantomRad/params.pxNum;
params.deg = 45;

img = repmat(1:params.pxNum,params.pxNum,1);
%img = reshape(1:params.pxNum^2,params.pxNum,params.pxNum)';

params.rows = 8;
params.detNum = 8;
[sgram0] = ProjectDDM(params, img);
%plot(sgram0, 'b');
if(~min(abs(sgram0 - expected0) < 10^-4))
    disp('sgram0 failed')
else
    disp('sgram0 passed')
end

params.rows = 1;
params.detNum = 8;
[sgram1] = ProjectDDM(params, img);
if(~min(abs(sgram1 - expected1) < 10^-4))
    disp('sgram1 failed')
else
    disp('sgram1 passed')
end


params.rows = 1;
params.detNum = 4;
[sgram2] = ProjectDDM(params, img);
%plot(sgram0, 'b');
if(~min(abs(sgram2 - expected2) < 10^-4))
    disp('sgram2 failed')
else
    disp('sgram2 passed')
end

params.rows = 8;
params.detNum = 4;
[sgram3] = ProjectDDM(params, img);
if(~min(abs(sgram3 - expected3) < 10^-4))
    disp('sgram3 failed')
else
    disp('sgram3 passed')
end

img = repmat((params.pxNum:-1:1)',1,params.pxNum);
params.rows = 1;
params.detNum = 4;
params.deg=60;
[sgram4] = ProjectDDM(params, img);
if(~min(abs(sgram4 - expected4) < 10^-4))
    disp(['sgram4 failed: ', num2str(abs(sgram4 - expected4))])
else
    disp('sgram4 passed')
end
