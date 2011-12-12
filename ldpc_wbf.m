function [syn,hard] = ldpc_wbf(H,re,max_ite)

% Code for LDPC Weighted Bit Flipping Algorithm (WBF)
% by Jinoe Morcilla Gavan
% Rev 1 June 8, 2007
% Based on the book Error Correcting Codes by LShu&DCostello
% Proposed by Y Kou, S Lin, M Fossorier
% "LDPC Codes Based on Finite Geometries:  A Rediscovery and New Results"

% output
%   syn - syndrome bits
%   hard - hard-coded message

% input
%   H - parity check matrix
%   re - received word
%   max_ite - maximum iteration


tic             % start timer

%%%%%%%%%%%% Step 1.  Generate the syndrome bits %%%%%%%%%%%%

% initialize Matrix and Variable

[row,col] = size(H);
hard=[ ];
y_min=[ ];      % WBF y_min per check node/row
y_soft = re;    % save soft-decision data for WBF iteration
y_re = re;      % save soft-decision data to convert ro hard-decision
iteration = 0;


% hard decision from BPSK
% modified from bitf.c
% ECC Website, http://the-art-of-ecc.com
% R.H. Morelos-Zaragoza
% y_re > 0 --> 1
% y_re <= 0 --> 0

for i = 1:col
    if y_re(i) > 0.0
        hard(i) = 1;
    else
        hard(i) = 0;
    end % if
end % for
hard_0=hard;        % save initial hard-decision data

for s1=1:row
    H_soft(s1,:)=H(s1,:).*abs(y_re);
end

%  syn = mod(y_re*H',2)
syn = mod(hard*H',2);


%%%%%%%%%%%%  Step 2:  solve for y_min %%%%%%%%%%%%
% Get y_min per check bit    
% Preprocessing, prior to iteration    
%%%%%%%%% Uses a zero flag to store first non-zero value %%%%%%%%%%%
for s1 = 1:row          % horizontal step, for check bits
    zero_flag = 0;
    for s2 = 1:col      % vertical step
        if H_soft(s1,s2) ~= 0 
            if zero_flag == 0
                y_min(s1,1) = H_soft(s1,s2);
                zero_flag = 1;
            end
            if H_soft(s1,s2) <= y_min(s1,1)
                y_min(s1,1) = H_soft(s1,s2);
            end
        end
    end
end


while (sum(sum(syn)) ~= 0) & (iteration < max_ite)  %check if syn=0 or max iteration is reached

    iteration = iteration + 1;

    %%%%%%%%%%%% Step 3:  Compute for En %%%%%%%%%%%%
    % En = summation[(2Sm-1)|ymin|]
    
    for s2 = 1:col          % vertical step, for message bits
        Eo=0;
        En(1,s2)=0;
        for s1 = 1:row      % horizontal step, for Sm
            Eo=(2*syn(1,s1)-1)*y_min(s1,1)*H(s1,s2);
            En(1,s2)=En(1,s2)+Eo;
        end
    end
    
    %%%%%%%%%%%% Step 4:  Get maximum En %%%%%%%%%%%%
    % uses max function
    
    [max_En,id]=max(En,[],2);
    
    %%%%%%%%%%%% Step 5:  Flip the bits %%%%%%%%%%%%
    hard(id)=not(hard(id));
    
    syn = mod(hard*H',2);  % get/recompute syndrome bits    
    
end % while

% return resulting values

if (sum(sum(syn)) == 0)
    disp('WBF DECODING IS SUCCESSFUL')
else
    disp('WBF DECODING IS UNSUCCESSFUL')
end % if sum

toc             % end timer