function crc8 = crc8_function(x)

poly_crc8 = [0 0 1 0 1 0 1 1];
crc8 = zeros(1,8);

for k = 1:length(x);
    
    msb_bit = xor(x(k),crc8(end));
    g = poly_crc8 * (msb_bit);
    crc8(end) = msb_bit;
    crc8 = circshift(crc8,[0,1]);
    crc8 = xor(crc8,g);
end

crc8 = fliplr(crc8);

return





    
    
    