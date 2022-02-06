theta = 0:179;
p = phantom(512);
% p = zeros(256);
% p(100:105,125:130) = 1;
% p(110:115,125:130) = 1;

r1 = radon(p,theta)/20;
EmitedPhotons=10^5;
r2=EmitedPhotons*exp(-r1);
r2=poissrnd(r2) + 10^-15;
r2=-log(r2./EmitedPhotons);
%r2 = r2 - min(r2(:));
EmitedPhotons=2.5*10^4;
r3=EmitedPhotons*exp(-r1);
r3=poissrnd(r3) + 10^-15;
r3=-log(r3./EmitedPhotons);


% a = 1;
% n = 4;
% b = ones(n,1)/n;
% r3 = filter(b,a,r2);

% figure(1); 
% subplot(1,2,1); imshow(r1,[]);
% subplot(1,2,2); imshow(r2,[]);

p1 = iradon(r1,theta,'linear');
p2 = iradon(r2,theta,'linear');
p3 = iradon(r3,theta,'linear');


figure(2);
subplot(1,3,1); imshow(p1,[]);
subplot(1,3,2); imshow(p2,[]);
subplot(1,3,3); imshow(p3,[]);


% figure(3);
% subplot(3,2,1); plot(r1(:,127))
% subplot(3,2,3); plot(r2(:,127))
% subplot(3,2,5); plot(r3(:,127))
% 
% subplot(3,2,2); imshow(p1,[]);
% subplot(3,2,4); imshow(p2,[]);
% subplot(3,2,6); imshow(p3,[]);
% 
% 
% figure(4);
% subplot(3,1,1); snr(r1(:,127))
% subplot(3,1,2); snr(r2(:,127))
% subplot(3,1,3); snr(r3(:,127))
