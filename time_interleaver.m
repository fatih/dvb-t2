function y = time_interleaver(fec_blocks)

column= reshape(fec_blocks,length(fec_blocks)/5,5);
x = transpose(column);
y = reshape(x,1,length(fec_blocks));

end


