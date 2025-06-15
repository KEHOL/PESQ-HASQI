function output_signal = filter_Bilinear_RLS_demo(Data_input,Desired_signal,mu,Lamda,system_matrix)

 %=== Global_export ===
  global trainning;
 global load_weight;
 global save_weight;
 %=====================

%WARNING Data_input array could be equal to Desired_signal array
adaption=numel(Data_input);
%used alternative write
wi=zeros(system_matrix,adaption); Sd=eye(system_matrix).*mu;
%if system_matrix = 1 then it works natural RLS filter.
for i=1:numel(Data_input)
    Data_input_new(:,i)=zeros(system_matrix,1)';
        for j=1:system_matrix
            Data_input_new(j,i)=1*Data_input(i); %can be changed to neuron systems
        end
end
%pause(10);
if load_weight == 1 && exist('filters_demo/weight_RLS_Volters.mat')
  load('filters_demo/weight_RLS_Volters.mat');
   timed_w=size(wi);times_input_new=(Data_input_new);if timed_w(2)>times_input_new(1); wi=create_same_length_an_data(wi',times_input_new);else;end
 
   if size(Data_input_new,2) > size(wi,1)
  wi=padarray(wi',[0 (size(Data_input_new,2)-size(wi,1))],0,'post'); else;
  wi=(create_same_length_an_data(wi',Data_input_new'))';
   end
else
tick_check = 10000;
check_update = 10;
                for trainning_times=1:trainning
                tic    
for i=1:numel(Data_input)
    E(i) = Desired_signal(i)'-wi(:,i)'*Data_input_new(:,i)+Data_input(i);
    Zetta = Sd*Data_input_new(:,i);
    Phi = (Zetta/(Lamda+Zetta'*Data_input_new(:,i)));
    wi(:,i+1) = wi(i)+E(i)*Sd*Data_input_new(:,i);
    %Sd = (1/Lamda)*(Sd - Zetta*Phi'); 
    % /\ find out what the problem deviding by lambda /\
    Sd = (Sd - Zetta*Phi');
    if i==tick_check && (mod(trainning_times,check_update) == 0 || trainning_times == 1);time=toc; clc; disp(append('The possible time left ',num2str(fix(((time*((numel(Data_input)))/(tick_check))*(trainning-trainning_times+1))-time)),' in seconds by Volters\Bilinear RLS calculation'))
    else;end;
end
                end
                if save_weight == 1
                    wi=single(wi);
                save('filters_demo/weight_RLS_Volters.mat','wi');else;end
end
Est = zeros (numel(Data_input),1);
    for i = 1:numel(Data_input)
          Est(i) = wi(:,i)'*Data_input_new(:,i);
    end

output_signal = Est;

end

function OutData = create_same_length_an_data(Indata,InDesired)
[rows,cols]=size(InDesired);
[rowsData,colsData]=size(Indata);
InResided=Indata;

OutData = InResided(rowsData, 1:rows);
end