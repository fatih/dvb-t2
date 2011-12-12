function output = rec_main(y,mod_type2,fec_rate)
  global ldpc_par_adress; 
  global qldpc;
  global kbch_length;
  global nldpc_length;
  global demultiplexed;
  global Nc;
  global tc;
  global kldpc_length;
  global Nsubstream;
  global angle_bb;
  global Ncells;
  global mod_type;
  global Lr;  
  global qam_constellation_0;
  global qam_constellation_1;
  global r_fec;
  
[qam_constellation_0,qam_constellation_1,Lr,ldpc_par_adress,qldpc,kbch_length,nldpc_length,demultiplexed,Nc, tc, kldpc_length, Nsubstream, angle_bb, Ncells, mod_type] = database_dvbt2(fec_rate,mod_type2,'short');

tic;  

  output=[];
  to_input_main=rec_bicm_main(y);
  w=length(to_input_main);
  for i=1:r_fec
      output=[output rec_input_main(to_input_main(((i-1)*(w/r_fec)+1):(i*(w/r_fec))))];
  end;             
t = toc
end

