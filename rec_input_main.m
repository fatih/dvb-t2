function raw_data = rec_input_main(bicm_data)

global kbch_length
global dnp1
global dnp2

raw_data = [];

to_data_packet = rec_bb_descrambler(bicm_data);

[upl_package ,bbheader ,dfl_length ,num_of_upl] = rec_data_packet(to_data_packet);


dnp1=0;

for k=1:num_of_upl 
    
    raw_data = [raw_data rec_upl_create(upl_package(((k-1)*dfl_length + 1):k*dfl_length))];

end;    


end

