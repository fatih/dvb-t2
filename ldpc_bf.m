function [u ,ite]=ldpc_bf(H,re,max_ite)        % actual function

% Code for LDPC Weighted Bit Flipping Algorithm (WBF)
% by Jinoe Morcilla Gavan
% Rev 1 June 7, 2007
% Based on the book Error Correcting Codes by LShu&DCostello

% output
%   u - decoded message
%   ite - number of iteration

% input
%   H - parity check matrix
%   re - received word
%   max_ite - maximum iteration

tic             % start timer

%%%%%%%%%% Step 1.  Generate the syndrome bits %%%%%%%%%%

% initialize Matrix and Variable
[row,col] = size(H);
hard=[ ];
y_re = re;
iteration = 0;

% hard decision from BPSK
% modified from bitf.c
% ECC Website, http://the-art-of-ecc.com
% R.H. Morelos-Zaragoza
% y_re > 0 --> 1
% y_re <= 0 --> 0
% for i = 1:col
%     if y_re(i) > 0.0
%         hard(i) = 1;
%     else
%         hard(i) = 0;
%     end % if
% end % for

y_re = re;
syn = mod(y_re*H',2);           % syndrome bits

while (sum(sum(syn)) ~= 0) & (iteration < max_ite)  %check if syn=0 or max iteration is reached

    iteration = iteration + 1;
    %%%%%%%%%% Step 2.  Compute for S, bit node checks %%%%%%%%%%
	S=zeros(1,1);
	for i = 1:col
		S(i) = syn*H(:,i);
	end % for i
   
    %%%%%%%%%% Step 3:  Store the bits to be flipped %%%%%%%%%%
    [srow,scol]=size(S);
	bflip=[ 1 ];
	flip_count=1;

	for i = 1:scol-1
		if S(i+1)>=S(bflip)
			bflip(flip_count)=i+1;
			flip_count=flip_count+1;
		end % if S
	end % for i

	if S(1) == S(bflip(1))
		bflip(flip_count)=1;
	end % if S
    
    %%%%%%%%%% Step 4:  Flip the bits %%%%%%%%%%
    y_re(bflip)=not(y_re(bflip));
    syn = mod(y_re*H',2);  % get/recompute syndrome bits    
    
end % while
 
% return resulting values
if (sum(sum(syn)) == 0)
    disp('BF DECODING IS SUCCESSFUL')
    u = y_re;
    ite = iteration;
end % if sum

if (sum(sum(syn)) ~= 0)
    u = y_re;
    ite = iteration;
    disp('BF DECODING IS UNSUCCESSFUL')
end % if sum

toc             % end timer