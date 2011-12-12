function y = rec_bb_descrambler(x)

init_s = [1 0 0 1 0 1 0 1 0 0 0 0 0 0 0] ;
y=[];

for k = 1:length(x)
    
    part_out    = xor(init_s(end-1),init_s(end));
    init_s(end) = part_out;
    b           = xor(part_out,x(k));
    init_s      = circshift(init_s,[0,1]);
    y           = [y b];
    
end
return

