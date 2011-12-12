function to_bicm_packet = input_main(t)

global kbch_length

upl_package = [];

% todo has to be work in a while loop , düþünülecek

num_of_upl = floor((kbch_length - 80)/ 1520); % TODO: Optimize by using SYNCD timing
 


%assignin('base','msg', msg);


for k=1:num_of_upl 
    % todo readfile, 188*8 bit, assign to x 
    %deneme kodu 3 nisan 2010,süleyman
    
    x = input_stream('mux1-cp.ts',((k - 1) + (t - 1)* num_of_upl) );
    
    %x = msg( ( (k-1)*1504 + 1 ) : (k * 1504)   );
 
    
    upl_package = [upl_package upl_create(x)];
end;    
    bbframe = data_packet(upl_package, kbch_length); %%3 nisan
    %%bbframe = [bbframe bbframe_part];%% 3 nisan


to_bicm_packet = bb_scrambler(bbframe);

end
