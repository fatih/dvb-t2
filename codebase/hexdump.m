function hexstring = hexdump(filenm,k)
% hexdump(filenm, n)
% Print the first n bytes of a file in hex and ASCII.

output = [];

    
    fid = fopen(filenm, 'r');
    if (fid<0) disp(['Error opening ',filenm]); return; end;
    nread = 0;
    n = 188;

    fseek(fid,(k-1)*188,'bof');

    while (nread < n)
        width = 188;


        [A,count] = fread(fid, width, 'uchar');
        nread = nread + count;
        if (nread>n) count = count - (nread-n); A = A(1:count); end;
        hexstring = repmat(' ',1, width*3);
        hexstring(1:3*count) = sprintf('%02x ',A);
        ascstring = repmat('.',1, count);
        idx = find(double(A)>=32);
        ascstring(idx) = char(A(idx));
        %fprintf(1, '%s *%s*\n', hexstring, ascstring);

    end;

    fclose(fid);

    

