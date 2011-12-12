%bits to cell word fonksiyonudur
%bitleri demultiplex ederek constelletions öncesi interleave yapmýþ olur
%bu fonksiyonun x'i bloklarý ayýrarark outputu oluþturur(Nsubsystems=blok_length.
%bu bloklar tam sýralý deðildir o yüzden database kullanýldý
%28.01.2010  23.29

% global variables : nldpc_length,mod_type,Nsubstream 

function y = rec_bits_to_cell_word_demultiplexer(x)
   global mod_type
   global nldpc_length
   global Nsubstream
   global demultiplexed

   nmod=log2(mod_type);
   %4_b_bit_to_cell_word_demultiplexer_parameter
   %demultiplexed=demultiplex_parameter(mod_type,fec_rate,nldpc_length); % Change according to database formation
   for i=1:nldpc_length/Nsubstream
       for k=1:Nsubstream
           y((i-1)*Nsubstream + k -demultiplexed(Nsubstream-k+1))=x((i-1)*Nsubstream+k);
       end;
   end;    
end

%gelecekte yapýlmasý niyetlenilen deðiþiklikler
%foksiyon bloklara yýrmýþken fonksiyonun bitmesi beklenmeden constellation
%içeride yapýlýr böylece constellation içeri yedirilmiþ olur
%c yada dsp code da zaman kazanýlabileceðini düþünüyorum


% 4 Nisan  y((i-1)*Nsubstream+k)=x((i-1)*Nsubstream  -demultiplexed(Nsubstream-k+1));
%yerine y((i-1)*Nsubstream+k)=x((i-1)*Nsubstream + k -demultiplexed(Nsubstream-k+1));
% yazýldý.

