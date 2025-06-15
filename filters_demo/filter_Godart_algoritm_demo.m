function output_signal = filter_Godart_algoritm_demo(Data_input,q,p,mu)

 %=== Global_export ===
  global trainning;
     global sato;
  global load_weight;
  global save_weight;
  global adaption;
  global trainning_zone;
  global convergence_rate;
 %=====================
%updated 18.05.2025
%updated 15.06.2025
trainning_times=0;

%==================================Reference===============================
% the type of cutting signal captured from 
% https://www.mathworks.com/matlabcentral/fileexchange/3649-lms-algorithm-demo


% the type Godart algorithm filter gathered from 
% https://viewer.mathworks.com/?viewer=plain_code&url=https%3A%2F%2Fwww.mathworks.com%2Fmatlabcentral%2Fmlc-downloads%2Fdownloads%2F7f4610a9-8d5e-409a-aa74-b91623d2604f%2Fc67f9c42-c665-4086-9232-be1f5714e4bb%2Ffiles%2FAdaptive_filtering_toolbox_v5%2FBlind_Adaptive_Filtering%2FGodard.m&embed=web
% the type Sato algorithm filter gathered from 
% https://viewer.mathworks.com/?viewer=plain_code&url=https%3A%2F%2Fwww.mathworks.com%2Fmatlabcentral%2Fmlc-downloads%2Fdownloads%2F7f4610a9-8d5e-409a-aa74-b91623d2604f%2Fc67f9c42-c665-4086-9232-be1f5714e4bb%2Ffiles%2FAdaptive_filtering_toolbox_v5%2FBlind_Adaptive_Filtering%2FSato.m&embed=web
%==========================================================================


w=rand(1,adaption)*1e-2;
w_down=w;
r=mean(abs(Data_input).^(q*2))/mean(abs(Data_input).^(q));
Est = zeros (numel(Data_input),1);
if load_weight == 1 && exist('filters_demo/weight_Godarts.mat')
  load('filters_demo/weight_Godarts.mat');
   Zone = Data_input(adaption:-1:adaption-adaption+1);
  timed_w=size(w);if timed_w(2)>numel(Zone); w=create_same_length_an_data(w,Zone);else; w=padarray(w,[0 (size(Zone,1)-size(w,2))],0,'post');end
else
             while trainning_times<trainning
for i=adaption:trainning_zone
                Zone=Data_input(i:-1:i-adaption+1);
                %Zone = Data_input(i-adaption+1:1:i);
    x=Zone;
    output_signal = w * x;
switch sato 
    case 0 %Godart variant:
    epsilon = 2.3e-6;
    Erg=abs(output_signal)^q - r;
    w = (w' - (1/2) * (mu*p*q*(Erg^(p-1))*(abs(output_signal)^(q-2))*Data_input(i-1)*x))';
    case 1 %Sato variant:
        epsilon = 3e-4;
    Ers=output_signal - sign(output_signal)*r;
    w=(w'-mu*Ers*x)';
otherwise;

    end
end
        norm(w-w_down)
    if norm(w-w_down) <= epsilon && convergence_rate
        trainning_times=trainning;
    end 

    w_down=w;
    trainning_times=trainning_times+1;
             end
             if save_weight == 1
                 w=single(w);
             save('filters_demo/weight_Godarts.mat','w');else;end
end
   for i=adaption:numel(Data_input)
                Zone=Data_input(i:-1:i-adaption+1);
                %Zone = Data_input(i-adaption+1:1:i);
          Est(i+(-adaption+1)*1)=w*Zone;
            x=Zone;
         output_signal = w * x;
switch sato 
    case 0 %Godart variant:
    Erg=abs(output_signal)^q - r;
    w = (w' - (1/2) * (mu*p*q*(Erg^(p-1))*(abs(output_signal)^(q-2))*Data_input(i-1)*x))';
    case 1 %Sato variant:

    Ers=output_signal - sign(output_signal)*r;
    w=(w'-mu*Ers*x)';
otherwise;

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