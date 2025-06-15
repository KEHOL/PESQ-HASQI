function output_signal = filter_Kalman_demo(Data_input,Desired_signal,Lamda,Step)

 %=== Global_export ===
  global trainning;
  global load_weight;
  global save_weight;
  global adaption;
  global trainning_zone;
  global convergence_rate;

 %=====================
%as bigger the EA than better reducing noises from DI
%Step must be lower and been natural then the Extra_adaptation
% the extra_adaptation as more as better, but need better calculation power

%updated 15.06.2025

%==================================Reference===============================
% the type of cutting signal captured from 
% https://www.mathworks.com/matlabcentral/fileexchange/3649-lms-algorithm-demo

% the type Kalman algorithm filter gathered from 
%https://viewer.mathworks.com/?viewer=plain_code&url=https%3A%2F%2Fwww.mathworks.com%2Fmatlabcentral%2Fmlc-downloads%2Fdownloads%2F7f4610a9-8d5e-409a-aa74-b91623d2604f%2Fc67f9c42-c665-4086-9232-be1f5714e4bb%2Ffiles%2FAdaptive_filtering_toolbox_v5%2FKalman_Filters%2FKalman_vs_RLS_equalizer.m&embed=web
%==========================================================================
epsilon = 5e-2;
trainning_times=0;

tick_check = 100;
check_update=1*ceil(trainning_zone^(1/4));
q=1;

%r=mean(abs(Data_input').^(q*2))/mean(abs(Data_input').^(q));
%r=sum(abs(Data_input(:)).^2)/numel(Data_input);
r=1e-5;
R_e= eye(adaption).*Lamda;
wk = zeros(adaption,1);
wk_down=wk;
Est = zeros (numel(Data_input),1);

if load_weight == 1 && exist('filters_demo/weight_Kalmans.mat')
  load('filters_demo/weight_Kalmans.mat');
  Zone = Data_input(adaption:-1:adaption-adaption+1);
  timed_w=size(wk);if timed_w(1)>numel(Zone); wk=create_same_length_an_data(wk',Zone)';else; wk=(padarray(wk',[0 (size(Zone,1)-size(wk',2))],0,'post'))';end
else
            while trainning_times<trainning
               % if trainning_times==1;;else; w=wk(:,trainning_times-1);end;
                tic
for i=adaption:trainning_zone
            Zone=Data_input(i:-1:i-adaption+1);
            %Zone = Data_input(i-adaption+1:1:i);
    C = Zone;
    K = R_e*C/(C'*R_e*C + r);
    wk = wk + K*(Desired_signal(i+(-adaption+1)*1+Step)-wk'*C);  
    R_e = [eye(adaption).*Lamda-K*C']*R_e;
        Est(i+(-adaption+1)*1)=wk'*Zone;
    if (mod(i,tick_check) == 0) && (mod(trainning_times,check_update)==0 || trainning_times == 1) ;time=toc; clc; disp(append('The possible time left ',num2str(fix(((time*((numel(Data_input))-i+1)/(tick_check))+time*(trainning_zone-adaption)*(trainning-trainning_times+1)/(tick_check))-time)),' in seconds by Kalman calculation'));tic;
    else;end

    %Re{i}=R_e;
    %t_est_kalman(i)=C'*wk(:,i);
    %e_kalman(i) = Desired_signal(i+Step)'-(t_est_kalman(i));
    %n_err_kalman(i) = abs(Desired_signal(i+Step)'-sign(t_est_kalman(i)));
end
        norm(wk-wk_down)
        if norm(wk-wk_down) <= epsilon && convergence_rate
        trainning_times=trainning;
        end 
    wk_down=wk;
    trainning_times=trainning_times+1;
            end
            if save_weight == 1
            wk=single(wk);
            save('filters_demo/weight_Kalmans.mat','wk');else;end
        toc
end            
    for i=adaption:numel(Data_input)-Step
            Zone=Data_input(i:-1:i-adaption+1);
            %Zone = Data_input(i-adaption+1:1:i);
          Est(i+(-adaption+1)*1)=wk'*Zone;
        C = Zone;
        K = R_e*C/(C'*R_e*C + r);
        wk = wk + K*(Desired_signal(i+(-adaption+1)*1+Step)-wk'*C);  
        R_e = [eye(adaption).*Lamda-K*C']*R_e;
    if (mod(i,tick_check) == 0) ;time=toc; clc; disp(append('The possible time left ',num2str(fix(((time*((numel(Data_input))-i+1)/(tick_check))*(1))-time)),' in seconds by Kalman calculation'));tic; 
    else;end

    end

output_signal = Est;

end

function OutData = create_same_length_an_data(Indata,InDesired)
[rows,cols]=size(InDesired);
[rowsData,colsData]=size(Indata);
InResided=Indata;

OutData = InResided(1:rowsData, 1:rows);
end