function sound_in_to_patch_without_filter(Data_input,Desired_signal)
 %=== Global_export ===
  global data_size;
 %=====================

for i = data_size:data_size:numel(Data_input)+data_size
 if i == data_size*(floor(numel(Data_input)/data_size)) || i < numel(Data_input)-data_size || i == numel(Data_input)-data_size
Data_input_short(i-data_size+1:1:i,1) = Data_input(i-data_size+1:1:i,1); Data_input_temperaly=Data_input_short(i-data_size+1:1:i,1);
Desired_signal_short(i-data_size+1:1:i,1) = Desired_signal(i-data_size+1:1:i,1); Desired_signal_temperaly=Desired_signal_short(i-data_size+1:1:i,1);
%filter_to_work here:
%data_output(i-data_size+1:1:i,1)=
 else;
    if ~exist('Data_input_short');Data_input_short=0;;else;end;
    if ~exist('Desired_signal_short');Desired_signal_short=0;else;end;
Data_input_temperaly = Data_input(numel(Data_input_short):numel(Data_input),1);
Data_input_temperaly = padarray(Data_input_temperaly,[data_size-size(Data_input_temperaly,1) 0],0,'post');
Desired_signal_temperaly = Desired_signal(numel(Desired_signal_short):numel(Data_input),1);
Desired_signal_temperaly = padarray(Desired_signal_temperaly,[data_size-size(Desired_signal_temperaly,1) 0],0,'post');
%filter_to_work here:
%data_output(i-data_size+1:1:i,1)=
%data_output=data_output(1:1:numel(Data_input),1);
 end


end

end