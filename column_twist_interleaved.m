%--------------------------------------------------------------------------
%28.01.2010  16:37
%--------------------------------------------------------------------------
%column_twist_interleaved fonksiyonudur
%column ve row satýrlarýný karýþtýrarak(twist) interleave yapar
%ayrýca column dada shift yapar tc nin deðerlerine göre
%Nldpc=64800 veya 16200
%Nc modulation çeþidine göre deðiþir(16-qam,64-qam,256-qam)
%--------------------------------------------------------------------------
function column_twist_interleaved= column_twist_interleaved(y)
  global nldpc_length
  global Nc
  global tc
  global mod_type
  
  if mod_type == 4
      column_twist_interleaved = y;
  else
      column=nldpc_length/Nc;
      row=Nc;
      for i=1:column
        for k=1:row
           column_twist_interleaved((i-1)*row+k)= y(column*(k-1) + 1 + mod(i + column-tc(k),column));
        end;
      end;
  end;    
end
%--------------------------------------------------------------------------
%niyet edilen deðiþiklikler
%--yapýldý---1)Nc ve tc deðerleri otomatik olarak hesaplanmasý global variable olabilir
%2)for dögüsü yerine matrix memory yazýp memoryden okuma olabilir
%  bu niyet c ve dsp code da daha verimli bir hesaplama verebilir
%--------------------------------------------------------------------------



% 3 nisan  mod(column - tc(k),column) yerine mod(i+column-tc(k),column)
% yazýldý