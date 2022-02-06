function a = polygonArea(p)
    a = 0;
    for n = 1:length(p)
        m = mod(n, length(p)) + 1;
        a = a + det([p(n,1), p(m,1); p(n,2), p(m,2)]); 
    end
    a = a/2;
end