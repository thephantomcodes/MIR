function A = aim_list(V,src,det1,det2,width)
    A = zeros(length(V),1);
    %A = aim(V,src,det1,det2,width);
    
    for n = 1:length(V)
        v = V(n,:);
        A(n) = aim(v,src,det1,det2,width);
    end
end