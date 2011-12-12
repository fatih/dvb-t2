function H = parity_matrix_gen(qldpc,ldpc_par_adress)

size_rate =  size(ldpc_par_adress);
size_rate_row = size_rate(1);
size_rate_col = size_rate(2);

H = sparse(false(360 * qldpc , 16200));
r = 0;
rate = 1;

for n = 1:16200; 
    
    if mod(n,360) == 1 
         r = r + 1;            
    end;
    
            if (size_rate_row < r)
                
                H( rate , n )  = true;         
                if (n ~= 16200)
                    H( (rate + 1 ), n )  = true;
                end;
                rate = rate + 1;
                
            else
                
                for k = 1:size_rate_col  
                    if (ldpc_par_adress( r ,  k) ~= 0)
                        rate_r = ldpc_par_adress( r , k);
                        H( mod (( rate_r + mod(n - 1,360)* qldpc ) , 360* qldpc) + 1 , n ) = true;
                    end;
                end;
                
            end;
            
end;

end