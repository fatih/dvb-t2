function bch_dec = rec_bch(msg)

 global kbch_length;
 global kldpc_length;
% global qlpdc;


% bch_decoder paramaters
dvbnBCH = kldpc_length; 
dvbkBCH = kbch_length; %kbch_length;
dvbprimBCH = [1 0 0 0 0 0 0 0 0 1 0 1 0 1 1]; % Reversed of primitive polynomial
dvbgenBCH  = [1 0 1 0 0 1 0 1 1 0 1 0 0 0 0 0 1 0 0 1 1 0 0 0 1 0 0 0 1 0 1 1 1 1 1 0 1 0 1 1 1 1 1 0 0 1 1 1 1 1 1 1 0 0 0 1 0 1 0 0 1 0 1 0 1 0 0 1 0 1 1 0 0 0 0 0 1 0 0 1 1 1 0 0 0 1 0 1 1 1 0 0 0 1 0 0 1 0 1 1 0 0 1 1 0 1 0 0 0 1 1 0 0 1 0 0 1 1 0 1 1 0 0 1 0 1 1 0 0 0 0 1 1 0 0 1 0 1 0 1 0 1 1 1 1 1 0 1 1 0 1 1 0 1 0 0 0 1 1 0 0 0 0 0 0 0 1 0 1 ];
data_input = [1 msg];

assignin('base','dvbnBCH', dvbnBCH) 
assignin('base','dvbkBCH', dvbkBCH)
assignin('base','dvbprimBCH', dvbprimBCH) 
assignin('base','dvbgenBCH', dvbgenBCH) 
assignin('base','data_input', data_input) 



[t,x,y] = sim('bchdect2');

bch_dec = y(:,1)';

end