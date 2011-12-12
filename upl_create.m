function y = upl_create(x)

global dnp

N = length(x);  % 1 UP packet, each one 188 bytes = 188 * 8 bits
 

if x == zeros(1,N);
    y = [];
    dnp = dnp + 1;  
    
else
   crc      = crc8_function(x);
   st       = dec2bin(dnp,8);
   
   dnparray = [];
   
   for k = 1:8;
       dnparray = [dnparray str2num(st(k))];
   end;
   
   y        = [crc x dnparray];
end

return


    

