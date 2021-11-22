%------------------------------------
% NOT TESTED OR USED
%------------------------------------


function [ RecIm ] = SART( A, sgram, Iterations )
    %A = SysMat;% SM_A is the CT system maxtix
    %An = diag(1 ./ max(0.00001,sum(A,1)));
    %Am = diag(1 ./ max(0.00001,sum(A,2)));
    
    [m, n] = size(A);
    An = sparse(n,n);
    Am = sparse(m,m);
    weights = 1 ./ max(0.00001,sum(A,1));
    for p = 1:n
        An(p,p) = weights(p);
    end
    
    weights = 1 ./ max(0.00001,sum(A,2));
    for p = 1:m
        Am(p,p) = weights(p);
    end
    W = An*A'*Am; %weights matrix
    
    [PrSize, ImSize]=size(sgram);
    G = reshape(sgram',PrSize*ImSize,1);
    [~, ImSize]=size(A);% Get the system matrix size
    RecIm = zeros(ImSize,1);% Generate the initial image vector 
    
    relaxParam = 1.0;

    for x=1:Iterations
        RecIm = RecIm - relaxParam*W*(A*RecIm - G);
    end
end

