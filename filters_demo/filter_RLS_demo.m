function output_signal = filter_RLS_demo(Data_input,Desired_signal,Lamda)

 %=== Global_export ===
  global trainning;
  global load_weight;
  global save_weight;
  global adaption;
  global trainning_zone;
  global convergence_rate;
 %=====================

%Updated 19.05.2025
%updated 15.06.2025
epsilon = 3e-5;
trainning_times=0;
%WARNING Data_input array could be equal to Desired_signal array
%used alternative write

%==================================Reference===============================
% the type of cutting signal captured from 
% https://www.mathworks.com/matlabcentral/fileexchange/3649-lms-algorithm-demo


% the type RLS alternative algorithm filter gathered from 
% https://picture.iczhiku.com/resource/eetop/WYiRoZIFhjsRrXmN.pdf
%==========================================================================

wi=(zeros(1,adaption)); Sd=(1/(1-Lamda)) * eye(adaption);
wi_down=wi;
Est = zeros (numel(Data_input),1);       

tick_check = 1000;
check_update=1*ceil(trainning_zone^(1/4));

if load_weight == 1 && exist('filters_demo/weight_RLS.mat')
  load('filters_demo/weight_RLS.mat');
  Zone = Data_input(adaption:-1:adaption-adaption+1);
  timed_w=size(wi);if timed_w(2)>numel(Zone); wi=create_same_length_an_data(wi,Zone);else; wi=padarray(wi,[0 (size(Zone,1)-size(wi,2))],0,'post');end
else
                tic;
            while trainning_times<trainning
for i=adaption:trainning_zone
    %Zone=Data_input(i:-1:i-adaption+1);
    Zone = Data_input(i-adaption+1:1:i);
    Est(i+(-adaption+1)*1)=wi*Zone;
            E(i) = Desired_signal(i)-Est(i+(-adaption+1)*1);
            Zetta = Sd*Zone;
            Phi = (Zetta*Zetta'/(Lamda+Zetta'*Zone));
            %Sd = (Sd - Phi);
            Sd = (1/Lamda)*(Sd - Phi);
            wi = (wi'+E(i)*Sd*Zone)';
     if (mod(i,tick_check) == 0) && (mod(trainning_times,check_update)==0 || trainning_times == 1) ;time=toc; clc; disp(append('The possible time left ',num2str(fix(((time*((numel(Data_input))-i+1)/(tick_check))+time*(trainning_zone-adaption)*(trainning-trainning_times+1)/(tick_check))-time)),' in seconds by RLS calculation'));tic;
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
            save('filters_demo/weight_RLS.mat','wi');else;
            end
                tic;
    for i=adaption:numel(Data_input)
    %Zone=Data_input(i:-1:i-adaption+1);
    Zone = Data_input(i-adaption+1:1:i);
    Est(i+(-adaption+1)*1)=wi*Zone;
            E(i) = Desired_signal(i)-Est(i+(-adaption+1)*1);
              Zetta = Sd*Zone;
            Phi = (Zetta*Zetta'/(Lamda+Zetta'*Zone));
            %Sd = (Sd - Phi);
            Sd = (1/Lamda)*(Sd - Phi);
            wi = (wi'+E(i)*Sd*Zone)';
    if (mod(i,tick_check) == 0 );time=toc; clc; disp(append('The possible time left ',num2str(fix(((time*((numel(Data_input))-i+1)/(tick_check))+time*(0)*(1))-time)),' in seconds by RLS calculation'));tic;
    else;end
    end
end
output_signal = Est;

end

function OutData = create_same_length_an_data(Indata,InDesired)
[rows,cols]=size(InDesired);
[rowsData,colsData]=size(Indata);
InResided=Indata;

OutData = InResided(rowsData, 1:rows);
end