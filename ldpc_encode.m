function [cw]=ldpc_encode(Go,u)

% Code for LDPC Encoding
% by Jinoe Morcilla Gavan
% Rev 1 June 4, 2007
% Based on the book Error Correcting Codes by LShu&DCostello


% output
%   cw - codeword

% input
%   Go - Generator Matrix
%   u - message bits

[Grow,Gcol]=size(Go);

% Removed Step 1, place in ldpc_dB_test.m
% Step 1.  Generate the message bits
% for i=1:Grow
%    u(i)=round(rand); 
% end 

% Step 2.  Encode message bits, u, to Generator Matrix, Go

find_ones=find(u);
[frow,fcol]=size(find_ones);

G_code=Go;
find_ones(fcol+1)=Grow+1;
G_code(Grow+1,:)=zeros(1,Gcol);
row_bits=[ ];

% Step 3:  Save lines with ones on syndrome bits
for n=1:fcol+1
    row_bits(n,:)=G_code(find_ones(n),:);
end

% Step 4:  Encode message
for n=1:fcol
    row_bits(n+1,:)=xor(row_bits(n,:),row_bits(n+1,:));
end


cw=row_bits(fcol+1,:);