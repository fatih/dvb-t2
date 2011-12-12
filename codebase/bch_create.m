function Kldpc = bch_create(m)

global kbch_length


% Multiply message signal with x^(Nbch-Kbch)
m_yedek = [m zeros(1,168)]; 


% computed via galois_multi_bhc.m
gx = [1 0 1 0 0 1 0 1 1 0 1 0 0 0 0 0 1 0 0 1 1 0 0 0 1 0 0 0 1 0 1 1 1 1 1 0 1 0 1 1 1 1 1 0 0 1 1 1 1 1 1 1 0 0 0 1 0 1 0 0 1 0 1 0 1 0 0 1 0 1 1 0 0 0 0 0 1 0 0 1 1 1 0 0 0 1 0 1 1 1 0 0 0 1 0 0 1 0 1 1 0 0 1 1 0 1 0 0 0 1 1 0 0 1 0 0 1 1 0 1 1 0 0 1 0 1 1 0 0 0 0 1 1 0 0 1 0 1 0 1 0 1 1 1 1 1 0 1 1 0 1 1 0 1 0 0 0 1 1 0 0 0 0 0 0 0 1 0 1 ];

%convert generator polynomial and message to galois field to apply binary
%polnomial divison;

gx_galois = gf(gx);
m_yedek_galois = gf(m_yedek);


[a, re] = deconv(m_yedek_galois,gx_galois) ;  % Divide m by gx


re = re((kbch_length + 1):end); % The last 168 bits is the remainder

re = double(re.x); % Convert from galois to double;

Kldpc = [m re]; % Output Codeword for LDPC processing

end





    



 
