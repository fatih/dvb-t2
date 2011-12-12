function ldpc_dB_test(Go,Ho,max_ite,maxSNR,inc)               % use to test all BF Algo

% Code to test codes for LDPC
% by Jinoe Morcilla Gavan
% Rev 1 June 10, 2007

% input
%   Go - Generator Matrix
%   Ho - Parity Check Matrix
%   max_ite - maximum number of iterations
%   maxSNR - maximum SNR value
%   inc - increment of SNR values

close all

[Grow,Gcol]=size(Go);
[row,col] = size(Ho);
snr= [0:inc:maxSNR];

max = max_ite;
max_block=100;                 % can take >6 hours @ 3000

% For SNR/BER calculation
block=0;
biterrorsBF=0;                      % for BER calculations
biterrorsWBF=0;
biterrorsIWBF=0;

%%%%%%%%%%%  Create a file %%%%%%%%%%%
serial=fix((datenum(clock))*1e3);
s=sprintf('%d_BF_study_results.txt',serial);
fid = fopen(s,'a');
fprintf(fid,'\n');
fprintf(fid,'%s %d\n',' Date Stamp= ',serial);            
fclose(fid);
            
for a=1:length(snr)

    block=0;
    biterrorsBF=0;                      % for BER calculations
    biterrorsWBF=0;
    biterrorsIWBF=0;

    while (block < max_block)

        block = block+1;

        fprintf(1,'\\\\\\\t\t Simulation for \t\t SNR=%d \t\t block=%d\n',snr(a),block)
        
        %%%%%%%% Generate random message bits by Igor %%%%%%%%
        u = (sign(randn(1,size(Go,1)))+1)/2;

        %%%%%%%% Encode Message %%%%%%%%
        [cw]=ldpc_encode(Go,u);

        % BPSK modulation from Igor, another BPSK by Arun's
        % "1" --> 1     "0" --> -1
        cw_bpsk = 2*cw-1;

        %%%%%%%% add AWGN %%%%%%%%
        % AWGN transmission, soft decision received sequence
        y_bpsk = awgn(cw_bpsk,snr(a));  %awgn is from the communication toolbox

        %%%%%%%% Decode Message %%%%%%%% 
        % Bit Flip algorithm (BF)
        [synBF,y_reBF] = ldpc_bf_dB(Ho,y_bpsk,max);

        [numBF,ratioBF] = biterr(cw,y_reBF,'overall');        % from Comms Toolbox
        biterrorsBF = biterrorsBF+numBF;

        % Weighted Bit Flip algorithm (WBF)
        [synWBF,y_reWBF] = ldpc_wbf(Ho,y_bpsk,max);

        [numWBF,ratioWBF] = biterr(cw,y_reWBF,'overall');        % from Comms Toolbox
        biterrorsWBF = biterrorsWBF+numWBF;

        % Improved Weighted Bit Flip algorithm (IWBF)
        alp=0.7;            % Optimum value of alpha is required, pre-computed
                            % = 0.1 @ 4dB
        [synIWBF,y_reIWBF] = ldpc_iwbf(Ho,y_bpsk,alp,max);

        [numIWBF,ratioIWBF] = biterr(cw,y_reIWBF,'overall');        % from Comms Toolbox
        biterrorsIWBF = biterrorsIWBF+numIWBF;
    
        if rem(block,50)==0; %save statistics after every 50 blocks
            s=sprintf('%d_BF_study_results.txt',serial);
            fid = fopen(s,'a');
            fprintf(fid,'\n');
            fprintf(fid,'%s %2.1E\n',' SNR= ',snr(a));
            fprintf(fid,'%s %d\n',' blocks= ',block);
            fprintf(fid,'%s %d\n',' BFbiterrors= ',biterrorsBF);
            fprintf(fid,'%s %d\n',' WBFbiterrors= ',biterrorsWBF);
            fprintf(fid,'%s %d\n',' IWBFbiterrors= ',biterrorsIWBF);
            fclose(fid);
        end           
    
    end

%     fprintf(1,'Simulation finished for SNR: %d \n',snr(a))
    
end  % for for a