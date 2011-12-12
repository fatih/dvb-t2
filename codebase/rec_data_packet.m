function [upl_package,bb_header,dfl_length,num_of_upl] = rec_data_packet(x)

% where x is  n-UPL package
global kbch_length;

bb_header   = x(1:80);
%bb_partial  = bb_header(1:72);
% %crc_control yapýlmadý
% mattype     = bb_partial(1:16);
% upl         = bb_partial(17:32);
dfl_length_arr  = bb_header(33:48);
dfl_length  =1520;  % arrayden integer'a çevirme yapýlacak

num_of_upl = floor((kbch_length - 80)/ dfl_length);
length_upl_package= num_of_upl * dfl_length;
upl_package = x(81:length_upl_package + 80);


% mattype = [ones(1,8) zeros(1,8)];
% upl = [0 0 0 0 0 1 0 1 1 1 1 0 1 0 0 0 ];
% dfl_length= [0 0 1 1 1 0 1 1 0 1 1 0 0 0 0 0 ];
% sync = [0 1 0 0 0 1 1 1 ];
% syncd = zeros(1,16);

% bb_partial = [mattype upl dfl_length sync syncd];

% crc8_mode = crc8_function(bb_partial);
% bb_header = [bb_partial crc8_mode];

%padding_zeros = zeros(1,(w - 80 - N));


%bbframe= [bb_header x padding_zeros]; 

return


