function y = rec_demapper_test(x,qam_constellation_0,qam_constellation_1,mod_type)
  
%qam_constellation_0  ve qam_constellation_1 arrayleri oluþturulacak
%yapýlacak
  %global qam_constellation_0
  %global qam_constellation_1
  %global mod_type
  
  bit_number= log2(mod_type);
  realite=real(x);
  imaginary=imag(x);
    
  for k = 1:bit_number  % bit sýrasý MSB to LSB oluyor
      
    %%maximum likelihood function for bit=0 probability
    
    m = (realite-real(qam_constellation_0(k,1)))^2 + (imaginary-imag(qam_constellation_0(k,1)))^2;
    for i=2:2^(bit_number-1)
        a = (realite-real(qam_constellation_0(k,i)))^2 + (imaginary-imag(qam_constellation_0(k,i)))^2;
        if a<m 
           m=a;
        end;
    end;
    
    %%maximum likelihood function for bit=0 probability
    
    n = (realite-real(qam_constellation_1(k,1)))^2 + (imaginary-imag(qam_constellation_1(k,1)))^2;
    for i=2:2^(bit_number-1)
        a = (realite-real(qam_constellation_1(k,i)))^2 + (imaginary-imag(qam_constellation_1(k,i)))^2;
        if a<n
           n=a;
        end;
    end;
    
    % decision making process 
    if (m > n)     
        y(k) = 1;
    else
        y(k) = 0;
    end;
    
  end;
      
end




