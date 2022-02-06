clear;
addpath('../toolbox');

tic
num=32;

params = makeParams(num);
img = MakeDisc(params.pxNum,params.pxNum);
%img = phantom(num);
% img = zeros(params.pxNum);
% img(:,params.pxNum/2) = 1;
%sgram = aim_project(img(:),params);
A = aim_matrix(params);
sgram = A*img(:);
imshow(A);
imgRecon = reshape(A'*sgram(:),size(img));


figure(2);
imshow(imgRecon,[]);

toc

% figure(1)
% hold on;
% plot(sgram(num+1,:))
% % plot(B)
% 
% figure(2)
% %sgram2 = imresize(sgram,15-log2(num),'nearest');
% imshow(sgram,[])
% 
% figure(3)
% hold on;
% for n=1:params.pxNum+1
%     plot(sgram(n,:)); 
% end
