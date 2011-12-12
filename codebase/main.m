function bicm_output = main(fec_rate,mod_type2)
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
  global r_fec
  
  [qam_constellation_0,qam_constellation_1,Lr,ldpc_par_adress,qldpc,kbch_length,nldpc_length,demultiplexed,Nc, tc, kldpc_length, Nsubstream, angle_bb, Ncells, mod_type] = database_dvbt2(fec_rate,mod_type2,'short');

tic;  
y = [];


for k = 1:r_fec
  y = [y input_main(k)];
end

  z=bicm_main(y);
  bicm_output=z;
t = toc
end



%%r_fec global olarak database içinde 10 olarak seçildi.

