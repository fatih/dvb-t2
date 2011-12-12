function bbframe = data_packet(x,w)

% where x is  n-UPL package


N = length(x);

mattype = [ones(1,8) zeros(1,8)];
upl = [0 0 0 0 0 1 0 1 1 1 1 0 1 0 0 0 ];
dfl_length= [0 0 1 1 1 0 1 1 0 1 1 0 0 0 0 0 ];
sync = [0 1 0 0 0 1 1 1 ];
syncd = zeros(1,16);

bb_partial = [mattype upl dfl_length sync syncd];

crc8_mode = crc8_function(bb_partial);
bb_header = [bb_partial crc8_mode];

padding_zeros = zeros(1,(w - 80 - N));


bbframe= [bb_header x padding_zeros]; 

return


