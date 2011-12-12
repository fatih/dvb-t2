%status = dos('ffmpeg.exe -i fair.mpg -vcodec copy -acodec copy -f mpegts output.ts');

hex_data = hexdump('mux1-cp.ts', 188);

hex_data = deblank(hex_data);

space_index = find(isspace(hex_data));
space_index = [1 space_index length(hex_data)];

bin_data_part = [];
for k = 2:length(space_index)
    hex_data_part = hex_data(space_index(k - 1):space_index(k));
    bin_data_part = [bin_data_part dec2bin(hex2dec(hex_data_part),8)];
end


bin_data = [];

for k = 1:length(bin_data_part)
    bin_data = [bin_data str2num(bin_data_part(k))];
end



