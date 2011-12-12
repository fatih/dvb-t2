function [syn,hard] = ldpc_irrwbf(H,re,max_ite)

% Code for Implementation-efficient Reliability Ratio Based Weighted Bit-Flipping (IRRWBF) Decoding for LDPC codes 
% by Jinoe Morcilla Gavan
% Rev 1 June 17, 2007
% Original RRWBF proposed by Feng Guo and Lajos Hanzo
% "Reliability Ratio Based Weighted Bit-Flipping Decoding for LDPC codes"
% Modified to IRRWBF by C.-H. Lee and W. Wolf
% "Implementation-efficient reliability ratio based weighted bit-flipping decoding for LDPC codes"

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
y_min=[ ];      % IWBF y_min per check node/row
y_soft = re;    % save soft-decision data for WBF iteration
y_re = re;      % save soft-decision data to convert ro hard-decision
iteration = 0;

% hard decision from BPSK
% modified from bitf.c
% ECC Website, http://the-art-of-ecc.com
% R.H. Morelos-Zaragoza
% y_re => 0 --> 1
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

syn = mod(hard*H',2);

%%%%%%%%%%%% Step 2:  solve for Tm %%%%%%%%%%%%
% Get Tm per check bit
% Preprocessing, prior to iteration
Tm = sum(H_soft')';


while (sum(sum(syn)) ~= 0) & (iteration < max_ite)  %check if syn=0 or max iteration is reached

    iteration = iteration + 1;

    %%%%%%%%%%%% Step 3:  Compute for En, IRRWBF %%%%%%%%%%%%
    % En = (1/|rn|)*summation[(2Sm-1)Tm]
    
    % Compute for summation terms first    
    for s2 = 1:col          % vertical step, for message bits
        Eo=0;
        En(1,s2)=0;
        for s1 = 1:row      % horizontal step, for Sm
            Eo= ((2*syn(1,s1)-1)*Tm(s1,1)*H(s1,s2));
            En(1,s2)=En(1,s2)+Eo;
        end
    end
    
    % Divide by |rn|
    En = En./abs(y_re);
    
    %%%%%%%%%%%% Step 4:  Get maximum En %%%%%%%%%%%%
    % uses max function
    [max_En,id]=max(En,[],2);
    
    %%%%%%%%%%%% Step 5:  Flip the bits %%%%%%%%%%%%
    hard(id)=not(hard(id));
    
    syn = mod(hard*H',2);  % get/recompute syndrome bits    
    
end % while

% return resulting values
if (sum(sum(syn)) == 0)
    disp('IRRWBF DECODING IS SUCCESSFUL')
else
    disp('IRRWBF DECODING IS UNSUCCESSFUL')
end % if sum

toc             % end timer