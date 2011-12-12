function crc8 = crc8_function_inv(x);


poly_crc8 = [1 1 0 1 0 1 0 0]; %Polynomial of CRC-8 
crc8 = zeros(1,8); % Initial values of CRC output


%The Crc coding process is transposed, thus we will get the CRC as a result
%of a binary sequence like : [MSB, ... , LSB]


for k = 1:length(x);
    
    msb_bit = xor(x(k),crc8(1));    %The input data is XORed with the MSB of the CRC output
    g = poly_crc8 * (msb_bit);      %The weights of the CRC8 polynomial are multiplied with the input bit
    crc8(1) = msb_bit;              %We store de XORed result to the MSB of the CRC, this is due to
                                    %circhisft code that we are using below
    crc8 = circshift(crc8,[0,-1]);  
    crc8 = xor(crc8,g);             %The Output is XORed with the g(explained above) and stored in the registers
end


return





    
    
    