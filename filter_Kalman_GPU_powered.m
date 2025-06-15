function data_output = filter_Kalman_GPU_powered(Data_input,Desired_signal,Lamda,Step)

  global auto_agree;
  global data_size;
  global trainning;
  global adaption;
  global trainning_zone;
  
addpath('filters_demo\');
data_output=Data_input;
%check would u had enough memory in GPU:
first_memory_GPU=gpuDevice().AvailableMemory;
    %------------------------------------------% test stand:

    %-------------------GPU TRANSPONSE-----------------------

    %C = Zone;
    %K = R_e*C/(C'*R_e*C + r);
    %wk = wk + K*(Desired_signal(i+Step)-C'*wk);  
    %R_e = [eye(adaption).*Lamda-K*C']*R_e;
    %    Est(i)=wk'*Zone;

q=1;

r=mean(abs(Data_input').^(q*2))/mean(abs(Data_input').^(q));
%r=sum(abs(Data_input(:)).^2)/numel(Data_input);
%r=1e-5;
R_e= eye(adaption).*Lamda;
wk = zeros(adaption,1);

R_e=gpuArray(R_e);
wk = gpuArray(wk);
fast_eye=gpuArray((eye(adaption)).*Lamda);

tic
for i=adaption:(adaption+100)
    Zone=gpuArray(Data_input(i:-1:i-adaption+1));
    C = Zone;
    %K = R_e*C/(C'*R_e*C + r); 
    %tic
    C_tran=C';
    %toc
    %tic
    pre_K=r;
    %toc
    %tic
    pre_ading_K=C_tran*R_e*C;
    %toc
    %tic
    pre_out_K=gather(pre_K+pre_ading_K); %give back one array size to proccessor
    %toc
    %tic
    before_K = R_e*C;
    %toc
    %tic
    K=before_K / pre_out_K;
    %toc
    %tic
    pre_wk=gather(C_tran*wk); %give back one array size to proccessor
    %toc
    %tic
    pre_sub_wk=Desired_signal(i+Step)-pre_wk;
    %toc
    %tic
    pre_out_wk=K*pre_sub_wk;
    %toc
    %tic
    wk = wk + pre_out_wk;
    %toc
    %tic
    pre_R_e = K*C_tran;
    %toc
    %tic
    pre_Out_R_e=fast_eye-pre_R_e;
    %toc
    %tic
    R_e = pre_Out_R_e*R_e;
    %toc
    %tic
    Est(i)=wk'*Zone;end;
Time_off=toc/100;
second_memory_GPU=gpuDevice().AvailableMemory;
    clear data_compromise_new q r R_e fast_eye i C C_tran pre_K pre_ading_K ...
    pre_out_K before_K K pre_wk pre_sub_wk pre_out_wk wk pre_R_e pre_R_e pre_Out_R_e Est Zone
    %out test stand.
one_memory_per_data=((first_memory_GPU-second_memory_GPU)/numel(Data_input)*adaption*6);

the_possible_value_of_captured_memory=one_memory_per_data*numel(Data_input)*adaption*6;

if first_memory_GPU > the_possible_value_of_captured_memory || canUseGPU
if ~auto_agree 
time_per_once_training=(Time_off)*(trainning_zone-adaption);
time_for_all_data=(Time_off)*(numel(Data_input)-adaption);
disp('!!!!!!!!! WARNING !!!!!!!!!!')
disp(append('The possible time of calculation would be ',num2str(time_per_once_training*trainning+time_for_all_data),' in seconds'))
the_answer = "Would u dlike to continue? Y/N?\n"; answer = input(the_answer,'S');
else; answer = 'Y';end;
if answer == 'Y' || answer == 'y'

 
for i = data_size:data_size:ceil(numel(Data_input)/data_size)*data_size
 if i == data_size*(floor(numel(Data_input)/data_size)) || i < numel(Data_input)-data_size || i == numel(Data_input)-data_size
Data_input_short(i-data_size+1:1:i,1) = Data_input(i-data_size+1:1:i,1); Data_input_temperaly=Data_input_short(i-data_size+1:1:i,1);
Desired_signal_short(i-data_size+1:1:i,1) = Desired_signal(i-data_size+1:1:i,1); Desired_signal_temperaly=Desired_signal_short(i-data_size+1:1:i,1);
%filter_to_work here:
data_output(i-data_size+1:1:i,1) = GPU_powered_filter_Kalman_demo(Data_input_temperaly,Desired_signal_temperaly,Lamda,Step);

 else;
    if ~exist('Data_input_short');Data_input_short=0;;else;end;
    if ~exist('Desired_signal_short');Desired_signal_short=0;else;end;
Data_input_temperaly = Data_input(numel(Data_input_short):numel(Data_input),1);
Data_input_temperaly = padarray(Data_input_temperaly,[data_size-size(Data_input_temperaly,1) 0],0,'post');
Desired_signal_temperaly = Desired_signal(numel(Desired_signal_short):numel(Data_input),1);
Desired_signal_temperaly = padarray(Desired_signal_temperaly,[data_size-size(Desired_signal_temperaly,1) 0],0,'post');
%filter_to_work here:
data_output(i-data_size+1:1:i,1) = GPU_powered_filter_Kalman_demo(Data_input_temperaly,Desired_signal_temperaly,Lamda,Step);
data_output=data_output(1:1:numel(Data_input),1);
 end


end

else;end;
else; disp('sorry, u`r device not have enought memory'); end;
end
