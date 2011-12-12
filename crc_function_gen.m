function crc = crc_function_gen(x,poly_crc)

crc = zeros(1,length(poly_crc));

for k = 1:length(x);
    
    msb_bit = xor(x(k),crc(end));
    g = poly_crc * (msb_bit);
    crc(end) = msb_bit;
    crc = circshift(crc,[0,1]);
    crc = xor(crc,g);
end

crc = fliplr(crc);

return

