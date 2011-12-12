function y = rec_upl_create(x)

global dnp1
global dnp2

%%N    = length(x);  % 1 UP packet, each one 188 bytes = 188 * 8 bits
 
dnp2 = x(end-7:end); %array den integer a çevirme olucak

if dnp2==dnp1
    
    y   = x(9:end-8);
    dnp1 = dnp2;
    
else
    
   a = dnp2-dnp1;
   
   for k = 1:a;
       y= [y zeros(1,188*8,1)];
   end;
   
   dnp1 = dnp2;
   
end

return


    

