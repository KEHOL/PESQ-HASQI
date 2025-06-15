function output_signal = filter_LMS_demo(Data_input,Desired_signal,mu)

 %=== Global_export ===
  global trainning;
  global load_weight;
  global save_weight;
  global adaption;
  global trainning_zone;
  global convergence_rate;
 %=====================
 
%updated 18.05.2025
%updated 15.06.2025
epsilon = 2e-3;
trainning_times=0;
%WARNING Data_input array could be equal to Desired_signal array

% to start work u had to choose Data_input and Desired_signal of.
% Step-Size 0<mu<2 can be used 4e-5 as fast adapt or 4e-7 as slow Adapt


%==================================Reference===============================
% the type of cutting signal captured from 
% https://www.mathworks.com/matlabcentral/fileexchange/3649-lms-algorithm-demo


% the type LMS algorithm filter gathered from 
% https://picture.iczhiku.com/resource/eetop/WYiRoZIFhjsRrXmN.pdf
%==========================================================================


wi=(zeros(1,adaption));
wi_down=wi;
E=[];
Est = zeros (numel(Data_input),1);
if load_weight == 1 && exist('filters_demo/weight_LMS.mat')
  load('filters_demo/weight_LMS.mat');
  Zone = Data_input(adaption:-1:adaption-adaption+1);
  timed_w=size(wi);if timed_w(2)>numel(Zone); wi=create_same_length_an_data(wi,Zone);else; wi=padarray(wi,[0 (size(Zone,1)-size(wi,2))],0,'post');end
else
            
            while trainning_times<trainning 

for i=adaption:trainning_zone
    Zone=Data_input(i:-1:i-adaption+1);
    %Zone = Data_input(i-adaption+1:1:i);
    Est(i+(-adaption+1)*1)=wi*Zone;
    E(i) = Desired_signal(i+(-adaption+1)*0)' - Est(i+(-adaption+1)*1);
    wi = (wi' + 2*mu*E(i)*Zone)';
    
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
            save('filters_demo/weight_LMS.mat','wi');else;end
end

    for i=adaption:numel(Data_input)
        Zone=Data_input(i:-1:i-adaption+1);
        %Zone = Data_input(i-adaption+1:1:i);
          Est(i+(-adaption+1)*1)=wi*Zone;
         E(i) = Desired_signal(i+(-adaption+1)*0)' - Est(i+(-adaption+1)*1);
         wi = (wi' + 2*mu*E(i)*Zone)';
    end
 %based output
output_signal = Est;   
%Used Acoustic Noise Cancellation from LMS
%output_signal = Desired_signal - Est;


end

function OutData = create_same_length_an_data(Indata,InDesired)
[rows,cols]=size(InDesired);
[rowsData,colsData]=size(Indata);
InResided=Indata;

OutData = InResided(rowsData, 1:rows);
end