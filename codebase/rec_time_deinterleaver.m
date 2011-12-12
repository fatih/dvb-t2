function y = rec_time_deinterleaver(rec_fec_blocks)
 
 column = reshape(rec_fec_blocks,5,length(rec_fec_blocks)/5);
 x      = transpose(column);
 y      = reshape(x,1,length(rec_fec_blocks));

end

