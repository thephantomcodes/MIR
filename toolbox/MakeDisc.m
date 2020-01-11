function [disc] = MakeDisc(pxNum, rad)
    disc = zeros(pxNum);

    %for h = -pxNum/2:pxNum/2
     for h = 1:pxNum   
       %for k = -pxNum/2:pxNum/2
       for k = 1:pxNum
         if sqrt((h-0.5*pxNum-0.5)^2 + (k-0.5*pxNum-0.5)^2) <= rad/2
            disc(h,k) = 1;
         end
       end
    end

end

