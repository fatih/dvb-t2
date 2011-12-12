function y = cell_interleaver(x,k);

global Lr


for q= 1:length(x)
    
        y(Lr(q,k)+1)= x(q);
        
end

return

% 4 nisan ; Y(Lr(q,r_fec)) yerine Y(Lr(q,r_fec) + 1) yazýldý

