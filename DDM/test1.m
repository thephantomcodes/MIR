W = [1 2; 3 4];
P = [2;3];
f = W^-1 * P;

f0 = [0;0];

w1 = W(1,:)';
w2 = W(2,:)';
%P1 = A1*A1'/(A1'*A1);
%P2 = A2*A2'/(A2'*A2);

N = 300;
e = zeros(1,N);

for n = 1:N
    %P = P1;
    w = w1;
    p = P(1);
    if(mod(n,2))
        %P=P2;
        w=w2;
        p = P(2);
    end
    f1 = f0 - ((w'*f0-p)/(w'*w))' * w;
    e(n) = pdist(f1-f,'euclidean');
    f0 = f1;
end

plot(e)
title('Error vs Iteration')
xlabel('iteration')
ylabel('distance from true value')
