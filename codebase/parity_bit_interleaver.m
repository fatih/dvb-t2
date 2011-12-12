%---------------------------------------------------
%parity_bit_interleaved fonksiyonu'dur.
%28.01.2009 14:30
%---------------------------------------------------

% y = Nldpc_frame;
function parity_bit_interleaved = parity_bit_interleaver(y)
  
  global qldpc
  
  parity_bit_interleaved = y;
  for t=1:qldpc
      for s=1:360
          parity_bit_interleaved(360*(t-1)+s)=y(qldpc*(s-1)+t);
      end;
  end;
end

%--------------------------------------------------
%bu fonksiyon ldpc create fonksiyonunda kullanýlacak
%sadece ldpcfec kýsmýný deðiþtiriyor
%ldpc içinde kullanýldýktan sonra Nbch'e eklenir
%böylece iki defa ekleme iþleminden feragat edilir
%içeride kullanýldýðýnda qdlpc girdisi silinebilir
%çünkü içeride fec rateden hesaplanabilir.
%---------------------------------------------------

