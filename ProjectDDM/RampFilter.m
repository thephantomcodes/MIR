function [sgram_filtered] = RampFilter(params, sgram)

ramp = abs(linspace(-1, 1, params.detNum))';
ramp = repmat(ramp, [1,params.viewNum]);

sgram_filtered = fftshift(fft(sgram,[],1),1);
sgram_filtered = sgram_filtered .* ramp;
sgram_filtered = ifftshift(sgram_filtered,1);
sgram_filtered = real(ifft(sgram_filtered .* ramp,[],1));

end
