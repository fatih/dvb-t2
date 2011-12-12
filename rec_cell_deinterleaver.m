function y = rec_cell_deinterleaver(x,k);

global Lr

for q= 1:length(x)
    
    y(q)= x(Lr(q,k)+1);
        
end;

return

