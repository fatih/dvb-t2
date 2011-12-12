function Nldpc = ldpc_create_den(x,b)

kbch_length = 12432;
nldpc_length = 16200;
ldpc_par_adress = b;
qldpc = 10
kldpc_length = 12600;

%Initial values of parity bits are zero
par_bits = zeros(1,(nldpc_length- kldpc_length));

%Get the table for the given rate, rate variable is global

% par_adress = par_adress_table(rate) ; 


r = 0;
size2=size(ldpc_par_adress);
time=size2(2);
length(x)
for k = 1:length(x)
    if mod(k,360) == 1 
            r = r + 1;            
    end;
    for n = 1:time 

            p_adress = mod(  (ldpc_par_adress(r,n) +  mod(k,360)*qldpc ) , nldpc_length- kldpc_length); % Qldpc changes with rate variable        
            par_bits(p_adress + 1) = xor( par_bits(p_adress + 1) , x(k) );
    end;
end;
   
for m = 2:length(par_bits) 
    par_bits(m) = xor(par_bits(m), par_bits(m-1));
end;

par_bits_int = parity_bit_interleaver(par_bits); %
Nldpc = [x par_bits];

return

% 4 nisan  par_bits(p_adress) yerine Par_bits(p_adress + 1) yapýldý
% r= 1 yerine r=0 yapýldý son döngüde outoff bound oluyordu.
%ilk for un içindeki forun sýnýrlarý yukarýda hesaplanarak yazýldý time
%olarak eski hali length(ldpc_par_adress) bir eksik sonuç veriyordu.



        
        
        
    