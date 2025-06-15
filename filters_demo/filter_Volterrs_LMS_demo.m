function output_signal = filter_Volterrs_LMS_demo(Data_input,Desired_signal,mu,step,mu_step)

 %=== Global_export ===
  global trainning;
  global load_weight;
  global save_weight;
  global adaption;
  global trainning_zone;
  global convergence_rate;
 %=====================

%WARNING Data_input array could be equal to Desired_signal array
%Updated 19.05.2025
%updated 15.06.2025
epsilon = 6e-3;
trainning_times=0;
% to start work u had to choose Data_input and Desired_signal of.
% Step-Size 0<mu<2 can be used 4e-5 as fast adapt or 4e-7 as slow Adapt


%==================================Reference===============================
% the type of cutting signal captured from 
% https://www.mathworks.com/matlabcentral/fileexchange/3649-lms-algorithm-demo


% the type MLS algorithm filter gathered from 
% https://picture.iczhiku.com/resource/eetop/WYiRoZIFhjsRrXmN.pdf
% the type Volterra MLS algorithm filter gathered from 
% https://viewer.mathworks.com/?viewer=plain_code&url=https%3A%2F%2Fwww.mathworks.com%2Fmatlabcentral%2Fmlc-downloads%2Fdownloads%2F7f4610a9-8d5e-409a-aa74-b91623d2604f%2Fc67f9c42-c665-4086-9232-be1f5714e4bb%2Ffiles%2FAdaptive_filtering_toolbox_v5%2FNonlinear_Adaptive_Filters%2FVolterra_LMS.m&embed=web
%==========================================================================

wi=(zeros(1,adaption));
wi_down=wi;
E=[]; Mu=eye(adaption).*mu;

for i=1:adaption
    for j=i+step:adaption
Mu(j,j)=Mu(i,i)*mu_step;
    end
end


wi=(zeros(1,adaption));
Est = zeros (numel(Data_input),1);

tick_check = 1000;
check_update=1*ceil(trainning_zone^(1/4));

if load_weight == 1 && exist('filters_demo/weight_LMS_Volters.mat')
  load('filters_demo/weight_LMS_Volters.mat');
  Zone = Data_input(adaption:-1:adaption-adaption+1);
  timed_w=size(wi);if timed_w(2)>numel(Zone); wi=create_same_length_an_data(wi,Zone);else; wi=padarray(wi,[0 (size(Zone,1)-size(wi,2))],0,'post');end
else
                   tic;
           while trainning_times<trainning

for i=adaption:trainning_zone
            Zone=Data_input(i:-1:i-adaption+1);
            %Zone = Data_input(i-adaption+1:1:i);
    Est(i+(-adaption+1)*1)=wi*Zone;
    E(i) = Desired_signal(i)' - Est(i+(-adaption+1)*1);
    wi = (wi' + 2*Mu*E(i)*Zone)';
    if (mod(i,tick_check) == 0) && (mod(trainning_times,check_update)==0 || trainning_times == 1) ;time=toc; clc; disp(append('The possible time left ',num2str(fix(((time*((numel(Data_input))-i+1)/(tick_check))+time*(trainning_zone-adaption)*(trainning-trainning_times+1)/(tick_check))-time)),' in seconds by LMS Volters calculation'));tic;
    else;end

end
        %norm(wi-wi_down)
        if norm(wi-wi_down) <= epsilon && convergence_rate
        trainning_times=trainning;
        end 
    wi_down=wi;
    trainning_times=trainning_times+1;
            end
            if save_weight == 1
                wi=single(wi);
            save('filters_demo/weight_LMS_Volters.mat','wi');else;end
end
        tic;
    for i=adaption:numel(Data_input)
            Zone=Data_input(i:-1:i-adaption+1);
            %Zone = Data_input(i-adaption+1:1:i);
          Est(i+(-adaption+1)*1)=wi*Zone;
         E(i) = Desired_signal(i)' - Est(i+(-adaption+1)*1);
         wi = (wi' + 2*Mu*E(i)*Zone)';
    if (mod(i,tick_check) == 0 );time=toc; clc; disp(append('The possible time left ',num2str(fix(((time*((numel(Data_input))-i+1)/(tick_check))+time*(0)*(1))-time)),' in seconds by LMS Volters calculation'));tic;
    else;end
    end
 %based output
output_signal = Est;   

end

function OutData = create_same_length_an_data(Indata,InDesired)
[rows,cols]=size(InDesired);
[rowsData,colsData]=size(Indata);
InResided=Indata;

OutData = InResided(rowsData, 1:rows);
end