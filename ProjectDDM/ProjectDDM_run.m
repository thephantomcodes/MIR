clear;

params.scanRad = 50;
params.detLen = 40;
params.detNum = 256;
params.pxNum = 256;
params.phantomRad = 10;
params.pxWidth = 2*params.phantomRad/params.pxNum;
params.rows = 1:params.pxNum;


% params.scanRad = 50;
% params.detLen = 40;
% params.detNum = 8;
% params.pxNum = 8;
% params.phantomRad = 10;
% params.pxWidth = 2*params.phantomRad/params.pxNum;
% params.rows = 1:params.pxNum;

img = MakeDisc(params.pxNum,params.pxNum);
pxVals = img(params.rows,:);
%img = ones(params.pxNum);
%img = repmat(1:params.pxNum,params.pxNum,1);
hold on;
xlim([0,params.detNum]);
grid on;


params.deg = 0;
[sgram0] = ProjectDDM(params, img);
plot(sgram0, 'b');

params.deg = 15;
sgram15 = ProjectDDM(params, img);
plot(sgram15, 'r');

params.deg = 30;
sgram30 = ProjectDDM(params, img);
plot(sgram30, 'g');

params.deg = 44;
sgram44 = ProjectDDM(params, img);
plot(sgram44, 'm');

params.deg = 46;
sgram46 = ProjectDDM(params, img);
plot(sgram46, 'm');

params.deg = 60;
sgram60 = ProjectDDM(params, img);
plot(sgram60, 'g');

params.deg = 75;
sgram75 = ProjectDDM(params, img);
plot(sgram75, 'r');

params.deg = 90;
sgram90 = ProjectDDM(params, img);
plot(sgram90, 'b');

legend(['0' char(176) '-90' char(176)], ['15' char(176) '-75' char(176)], ['30' char(176) '-60' char(176)], ['44' char(176) '-46' char(176)])
title('DDM Projection vs. Angle')
xlabel('Detector Number')
ylabel('Measured Value')
%{
src = [0, params.scanRad];
detBounds = CalcDetBounds(params.scanRad, params.detLen, params.detNum);
pxBounds = CalcPxBounds(params.pxNum, params.phantomRad);
pxCenters = CalcPxCenters(params.pxNum, params.phantomRad);

deg = 30;
ang = deg*pi/180;
rotMat = [cos(ang) sin(ang); -sin(ang) cos(ang)];
detBounds = (rotMat*detBounds')';
src = (rotMat*src')';

projBounds = ProjectDetBounds( detBounds, src, pxCenters(1) );
detWidth = projBounds(2:9) - projBounds(1:8);
%sgram = zeros(1,params.detNum);
%}