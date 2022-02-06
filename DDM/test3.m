clear;
m = 1000;
x = m*[1; 2; 3; 4;];
P = [5/6 0 1 0; 
    0 5/6 0 1; 
    1 5/6 0 0; 
    0 0 5/6 1];
b = P*x;
b = poissrnd(b);
%xx = inv(P'*P)*P'*b;
%disp(x');
xx = zeros(4,1);
Pcol = diag(1./sum(P,1));
Prow = diag(1./sum(P,2));
iter = 10000;
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
end
%plot(err);
disp(err(iter))
disp(xx'/m);