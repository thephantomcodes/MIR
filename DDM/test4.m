redo=0;

tic
if(redo==1)
    %clear;
    num=128;
    params = makeParams(num);
    P = aim_matrix(params);
end


%x = MakeDisc(params.pxNum,params.pxNum);
x = phantom(params.pxNum);
x = x(:);
b = P*x;
b = poissrnd(1000*b)./1000;
%xx = inv(P'*P)*P'*b;
%disp(x');
xx = zeros(params.pxNum);
xx = xx(:);
Pcol = diag(1./sum(P,1));
Prow = diag(1./sum(P,2));
iter = 10;
err = zeros(1,iter);

% while max(abs(x-xx)) > .001
for z=1:iter
    xx = xx + 1*(Pcol)*P'*Prow*(b - P*xx);
    %disp(xx');
    %err(m) = sqrt((x-xx)'*(x-xx));
    err(z) = norm(x-xx)/norm(x);
%     if(mod(n,100) == 0)
%         disp([xx']);
%     end
%     xx = reshape(xx,params.pxNum,params.pxNum);
%     x = reshape(x,params.pxNum,params.pxNum);
    %plot(err);
    disp(err(iter))

    figure(1);
    subplot(1,2,1); imshow(reshape(xx,params.pxNum,params.pxNum),[]);
    subplot(1,2,2); imshow(reshape(xx,params.pxNum,params.pxNum),[min(x(:)),max(x(:))]);
    savefig("figures/den-iter-" + string(z) + ".fig")
end


figure(2);
plot(err);
toc
