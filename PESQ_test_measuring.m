function score_output = PESQ_test_measuring(Data_input,Data_reference,fs_used,mode)

%write mode 'narrowband' or 'wideband' or both
%fs must been 16000 or 8000
fs_using=[16000,8000];
%gothed fs 
fs_choosen=fs_using(1);

Data_input=resample_to_Used(Data_input,fs_used,fs_choosen);
Data_reference=resample_to_Used(Data_reference,fs_used,fs_choosen);

fs=fs_choosen;

%
dir_before = pwd;
cd('pesq-mex-master\') %change directory into working place

mex *.c -output ./bin/PESQ_MEX

addpath('./bin');

%used P.862 https://github.com/ludlows/pesq-mex 

switch lower(mode)
    case 'nw'
        fprintf('testing narrowband.\n');
score_output = pesq_mex(Data_reference, Data_input, fs, 'narrowband');
    case 'wb'
        fprintf('testing wideband.\n');
score_output = pesq_mex(Data_reference, Data_input, fs, 'wideband');
    case 'both'
        fprintf('testing both.\n');
score_output = pesq_mex(Data_reference, Data_input, fs, 'both');
    otherwise
        error(['''' mode ''' is not a recognised ''mode'' value.'])
end   

cd(dir_before); %get back after all iterations

for i=1:2
if isnan(score_output(i)) 
score_output(i)=-1;else;end
end

end

function Data_out = resample_to_Used(Data_In,fs_have,fs_need)

fs_choosen_least_kHz=round(fs_need/1000);
fs_used_least_kHz=round(fs_have/1000);

if fs_used_least_kHz == fs_choosen_least_kHz
%   No resampling performed if the rates match
    Data_out=Data_In;

elseif fs_choosen_least_kHz < fs_choosen_least_kHz
%   Resample for the input rate lower than the output
    Data_out=resample(Data_In,fs_need,fs_have);
    
    % mathcing RMS level
    inRMS=sqrt(mean(Data_In.^2));
    outRMS=sqrt(mean(Data_out.^2));
    Data_out=(inRMS/outRMS)*Data_out;
else
    %Resample for the input rate higher than the output
%   Resampling includes an anti-aliasing filter.
    Data_out=resample(Data_In,fs_need,fs_have);
    
%   Reduce the input signal bandwidth to Used-10% kHz:
%   Chebychev Type 2 LP (smooth passband)
    order=7; %Filter order
    atten=30; %Sidelobe attenuation in dB
    fcutx=(fs_choosen_least_kHz-fs_choosen_least_kHz*0.1)/fs_used_least_kHz; %Cutoff frequency as a fraction of the sampling rate
    [bx,ax]=cheby2(order,atten,fcutx);
    Data_In=filter(bx,ax,Data_In);
    
%   Reduce the resampled signal bandwidth to Used-10% kHz
    fcuty=(fs_choosen_least_kHz-fs_choosen_least_kHz*0.1)/fs_choosen_least_kHz;
    [by,ay]=cheby2(order,atten,fcuty);
    Data_out=filter(by,ay,Data_out);
    
%   Compute the input and output RMS levels within the 21 kHz bandwidth
%   and match the output to the input
    inRMS=sqrt(mean(Data_In.^2));
    outRMS=sqrt(mean(Data_out.^2));
    Data_out=(inRMS/outRMS)*Data_out;
end
end
