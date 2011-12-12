 
function [to_input_main] = rec_bicm_main(T2_frame)

%Todo: Column_twisted_interleaver, reshape ile yapýlacak, Süleymanoviç
%yapacakmýþ :)

  global r_fec;
  global ldpc_par_adress; 
  global qldpc;
  global kldpc_length;
  
  
 time_deinterleaved = rec_time_deinterleaver(T2_frame);

 x=length(T2_frame)/r_fec; 

 to_input_main = [];

 for k = 1:r_fec;
    
    time_deinterleaved_part = time_deinterleaved(((k-1)*x+1):(k)*x) ;
    
    cell_deinterleaved = rec_cell_deinterleaver(time_deinterleaved_part,k);
    
    %derotated = rec_constellation_rotation(cell_deinterleaved);
     
    demodulated = [];
    for i=1:length(cell_deinterleaved)
         demodulated = [demodulated rec_demapper(cell_deinterleaved(i))];
    end;
     
    cell_bit_multiplexed = rec_bits_to_cell_word_demultiplexer(demodulated);
     
    to_FEC_module = rec_column_twist_interleaved(cell_bit_multiplexed); 
     
    H= parity_matrix_gen(qldpc,ldpc_par_adress);
    
    [ldpc_decoded,ite]=ldpc_bf(H,to_FEC_module,10);
    
    ldpc_decoded = ldpc_decoded(1:kldpc_length);
    
    bch_decoded = rec_bch(ldpc_decoded);
    
    to_input_main=[to_input_main bch_decoded];
    
 end; 
    
    
end


