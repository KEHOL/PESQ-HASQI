%to compilate anything as possible to look:
clear all;
%most valued configuration:

%in_setted_data.base_file_name=
%in_setted_data.base_file_type=

%in_setted_data.base_data_size=
%in_setted_data.base_trainning=2;

in_setted_data.base_Save_img=1;
%in_setted_data.base_type_save_img=

%in_setted_data.base_load_weight=
%in_setted_data.base_save_weight=

%in_setted_data.base_noise_type=
in_setted_data.base_SNRdb=0;
global shifter_of_filters; shifter_of_filters=string({ ...
    'no filtration', ...
    'LMS', ...
    'RLS', ...
    'Volterrs MLS', ...
    'Blind Adapt by Sato', ...
    'Blind Adapt by Godart', ...
    "Kalman's", ...
    "Kalman's_GPU" ...
    });
shifter_of_filters=string({ ...
    'LMS', ...      %1
    'LMS', ...      %2
    'LMS', ...      %3
    'RLS', ...      %4
    'RLS', ...      %5
    'RLS', ...      %6
    'Volterrs MLS', ...      %7
    'Volterrs MLS', ...      %8
    'Blind Adapt by Sato', ...      %9
    'Blind Adapt by Sato', ...      %10
    'Blind Adapt by Godart', ...      %11
    'Blind Adapt by Godart', ...      %12
    "Kalman's", ...      %13
    "Kalman's", ...      %14
    "Kalman's_GPU" ,...      %15
    "Kalman's_GPU" ,...      %16
    "Kalman's_GPU" ...      %17
    });


%in_setted_data.base_filtration_type=shifter_of_filters(round((numel(shifter_of_filters)-1)*rand()+1));

%shifter_of_noises = string({ ...
%    'gaussian', ...
%    'rand', ...
%    'speaking strong', ...
%    'speaking calm', ...
%    'dog and people', ...
%    'building side', ...
%    'highway side', ...
%    'subway arrive', ...
%    'self noise' ...
%    });

shifter_of_noises = string({ ...
    'gaussian', ...
    'speaking strong', ...
    'dog and people', ...
    'building side', ...
    'highway side', ...
    });


%in_setted_data.base_noise_type=shifter_of_noises(round((numel(shifter_of_noises)-1)*rand()+1));

%in_setted_data.base_value_filtration_for_LMS=
%in_setted_data.base_value_filtration_for_RLS=
%in_setted_data.base_value_filtration_for_Bilinear_RLS=
%in_setted_data.base_value_filtration_for_Volterrs_MLS=
%in_setted_data.base_value_filtration_for_Blind_Adapt_by_Sato=
%in_setted_data.base_value_filtration_for_Blind_Adapt_by_Godart=
%in_setted_data.base_value_filtration_for_Kalmans=

%in_setted_data.base_adaption=220;
%base_trainning_zone_value=240;

in_setted_data.base_filtration_auto_GPU=1;

in_setted_data.base_speech_measuring="Duo";


global Iterations;
global data_filtration_before;
Iterations=0;

Super_sorted.Save_name='Exit_Information_tables';
Super_sorted.Save_type='.xlsx';
data_filtration_before=1;
for filter_num=1:1:numel(shifter_of_filters)
    %for filter_num=1:1:2
for noise_num=1:1:numel(shifter_of_noises)
%    for noise_num=1:1:1
%SNR_Delta_LOOK:
%for training=0:20:40
%for repeats=1:3:2
%for data_size=100:3000:17000

for SNR_delta=0:10:30
if ~(Iterations == 0)
in_setted_data.base_do_look_clear_wave=0;
end
switch filter_num
    case 1 %LMS
in_setted_data.base_desired_signal_be="y_signal";
in_setted_data.base_do_acoustic_cancelation=0;
in_setted_data.base_trainning=1;
in_setted_data.base_trainning_zone=500;
in_setted_data.base_adaption=100;
    case 2 %LMS
in_setted_data.base_desired_signal_be="y_signal_noised";
in_setted_data.base_do_acoustic_cancelation=0;
in_setted_data.base_trainning=1;
in_setted_data.base_trainning_zone=500;
in_setted_data.base_adaption=100;
    case 3 %LMS
in_setted_data.base_desired_signal_be="y_signal_noised";
in_setted_data.base_do_acoustic_cancelation=1;
in_setted_data.base_trainning=1;
in_setted_data.base_trainning_zone=500;
in_setted_data.base_adaption=100;
    case 4 %RLS
in_setted_data.base_desired_signal_be="y_signal";
in_setted_data.base_do_acoustic_cancelation=0;
in_setted_data.base_trainning=1;
in_setted_data.base_trainning_zone=500;
in_setted_data.base_adaption=100;
    case 5 %RLS
in_setted_data.base_desired_signal_be="y_signal_noised";
in_setted_data.base_do_acoustic_cancelation=0;
in_setted_data.base_trainning=1;
in_setted_data.base_trainning_zone=500;
in_setted_data.base_adaption=100;
    case 6 %RLS
in_setted_data.base_desired_signal_be="y_signal_noised";
in_setted_data.base_do_acoustic_cancelation=1;
in_setted_data.base_trainning=1;
in_setted_data.base_trainning_zone=500;
in_setted_data.base_adaption=100;
    case 7 %Volterrs MLS
in_setted_data.base_desired_signal_be="y_signal";
in_setted_data.base_do_acoustic_cancelation=0;
in_setted_data.base_trainning=1;
in_setted_data.base_trainning_zone=500;
in_setted_data.base_adaption=100;
    case 8 %Volterrs MLS
in_setted_data.base_desired_signal_be="y_signal_noised";
in_setted_data.base_do_acoustic_cancelation=0;
in_setted_data.base_repeat_filtration=0;
in_setted_data.base_trainning=1;
in_setted_data.base_trainning_zone=500;
in_setted_data.base_adaption=100;
    case 9 %Blind Adapt by Sato
in_setted_data.base_desired_signal_be="y_signal_noised";
in_setted_data.base_do_acoustic_cancelation=0;
in_setted_data.base_repeat_filtration=1;
in_setted_data.base_trainning=1;
in_setted_data.base_trainning_zone=500;
in_setted_data.base_adaption=100;
    case 10 %Blind Adapt by Sato
in_setted_data.base_desired_signal_be="y_signal_noised";
in_setted_data.base_do_acoustic_cancelation=1;
in_setted_data.base_repeat_filtration=1;
in_setted_data.base_trainning=1;
in_setted_data.base_trainning_zone=500;
in_setted_data.base_adaption=100;
    case 11 %Blind Adapt by Godart
in_setted_data.base_desired_signal_be="y_signal_noised";
in_setted_data.base_do_acoustic_cancelation=0;
in_setted_data.base_repeat_filtration=1;
in_setted_data.base_trainning=1;
in_setted_data.base_trainning_zone=500;
in_setted_data.base_adaption=100;
    case 12 %Blind Adapt by Godart
in_setted_data.base_desired_signal_be="y_signal_noised";
in_setted_data.base_do_acoustic_cancelation=1;
in_setted_data.base_trainning=1;
in_setted_data.base_trainning_zone=500;
in_setted_data.base_adaption=100;
    case 13 %Kalman's
in_setted_data.base_desired_signal_be="y_signal";
in_setted_data.base_do_acoustic_cancelation=0;
in_setted_data.base_repeat_filtration=0;
in_setted_data.base_trainning=1;
in_setted_data.base_trainning_zone=500;
in_setted_data.base_adaption=100;
in_setted_data.base_value_filtration_for_Kalmans=[1,in_setted_data.base_adaption-1];
    case 14 %Kalman's
in_setted_data.base_desired_signal_be="y_signal";
in_setted_data.base_do_acoustic_cancelation=0;
in_setted_data.base_repeat_filtration=0;
in_setted_data.base_trainning=1;
in_setted_data.base_trainning_zone=500;
in_setted_data.base_adaption=400;
in_setted_data.base_value_filtration_for_Kalmans=[1,in_setted_data.base_adaption-1];
    case 15 %Kalman's GPU
in_setted_data.base_desired_signal_be="y_signal";
in_setted_data.base_do_acoustic_cancelation=0;
in_setted_data.base_repeat_filtration=0;
in_setted_data.base_trainning=1;
in_setted_data.base_trainning_zone=500;
in_setted_data.base_adaption=400;
in_setted_data.base_value_filtration_for_Kalmans=[1,in_setted_data.base_adaption-1];
    case 16 %Kalman's GPU
in_setted_data.base_desired_signal_be="y_signal_noised";
in_setted_data.base_do_acoustic_cancelation=0;
in_setted_data.base_repeat_filtration=0;
in_setted_data.base_trainning=1;
in_setted_data.base_trainning_zone=500;
in_setted_data.base_adaption=400;
in_setted_data.base_value_filtration_for_Kalmans=[1,in_setted_data.base_adaption-1];
    case 17 %Kalman's GPU
in_setted_data.base_desired_signal_be="y_signal_noised";
in_setted_data.base_do_acoustic_cancelation=1;
in_setted_data.base_repeat_filtration=0;
in_setted_data.base_trainning=1;
in_setted_data.base_trainning_zone=500;
in_setted_data.base_adaption=400;
in_setted_data.base_value_filtration_for_Kalmans=[1,in_setted_data.base_adaption-1];
    otherwise; end; 



%in_setted_data.base_value_filtration_for_Kalmans=[matrix_size,1,3]
%in_setted_data.base_data_size=data_size;
%in_setted_data.base_trainning=training;
%in_setted_data.base_repeat_filtration=repeats;
in_setted_data.base_filtration_type=shifter_of_filters(filter_num);
in_setted_data.base_SNRdb=SNR_delta;
in_setted_data.base_noise_type=shifter_of_noises(noise_num);


Times_start=tic;
data_raw=main(in_setted_data);

                                                   Iterations=Iterations+1;

 data_filtarion=filter_num; if data_filtration_before ~= data_filtarion; Iterations=1; end


                                     data_filtration_before=data_filtarion;
%===========================configuration zone===========================
Super_sorted.Seconds_full_Iteration(Iterations,data_filtarion)=toc(Times_start);
Super_sorted.Name_of_audio(Iterations,data_filtarion) = string(data_raw.type_of_audio);
    Super_sorted.Score_PESQ_noised_narrowband(Iterations,data_filtarion) = data_raw.score_SQ_PESQ_with_noise(1); Super_sorted.Score_PESQ_noised_wideband(Iterations,data_filtarion) = data_raw.score_SQ_PESQ_with_noise(2);
    Super_sorted.Score_HASQI_noised_narrowband(Iterations,data_filtarion) = data_raw.score_SQ_HASQI_with_noise(1); Super_sorted.Score_HASQI_noised_wideband(Iterations,data_filtarion) = data_raw.score_SQ_HASQI_with_noise(2);
Super_sorted.Name_of_noise(Iterations,data_filtarion) = data_raw.type_of_noise(1); Super_sorted.SNR_an_DB(Iterations,data_filtarion) = data_raw.type_of_noise(2);
Super_sorted.Shift_Value_noise(Iterations,data_filtarion) = data_raw.shift_noise_in_seconds;
    Super_sorted.Score_PESQ_filtered_narrowband(Iterations,data_filtarion) = data_raw.score_SQ_PESQ_filtered(1); Super_sorted.Score_PESQ_filtered_wideband(Iterations,data_filtarion) = data_raw.score_SQ_PESQ_filtered(2);
    Super_sorted.Score_HASQI_filtered_narrowband(Iterations,data_filtarion) = data_raw.score_SQ_HASQI_filtered(1); Super_sorted.Score_HASQI_filtered_wideband(Iterations,data_filtarion) = data_raw.score_SQ_HASQI_filtered(2);
Super_sorted.Values_of_filtarion{Iterations,data_filtarion} = data_raw.value_filtration;
Super_sorted.Filtration_name(Iterations,data_filtarion) = append(num2str(data_filtarion),'_',string(data_raw.name_of_type_filtering));
Super_sorted.trainning(Iterations,data_filtarion)=data_raw.trainning;
Super_sorted.been_adaption(Iterations,data_filtarion)=data_raw.been_adaption;
Super_sorted.been_trainning_zone(Iterations,data_filtarion)=data_raw.been_trainning_zone;
Super_sorted.Repeats(Iterations,data_filtarion)=data_raw.happen_repeat_of_filtration;
Super_sorted.Samples_into_filter(Iterations,data_filtarion)=data_raw.Samples_into_filter;
Super_sorted.Filtration_time(Iterations,data_filtarion)=datetime('now');
Super_sorted.Filter_num=data_filtarion;
Super_sorted.Measuring_type=data_raw.SQ_measuring_type;
%Super_sorted.Save_name_tabel=append(data_raw.SQ_measuring_type,'_',Super_sorted.Save_name);
%============================Filter Yes\no===============================
if data_raw.been_load_weight; Super_sorted.Does_been_load_weight(Iterations,data_filtarion) = string('yes'); else; Super_sorted.Does_been_load_weight(Iterations,data_filtarion)= string('no');end
if data_raw.been_save_weight; Super_sorted.Does_been_save_weight(Iterations,data_filtarion) = string('yes'); else; Super_sorted.Does_been_save_weight(Iterations,data_filtarion)= string('no');end
if data_raw.does_knew_the_desired_signal; Super_sorted.Does_knew_the_desired_signal(Iterations,data_filtarion) = string('yes'); else; Super_sorted.Does_knew_the_desired_signal(Iterations,data_filtarion)= string('no');end
if data_raw.does_do_acoustic_canceletion; Super_sorted.Does_do_acoustic_canceletion(Iterations,data_filtarion) = string('yes'); else; Super_sorted.Does_do_acoustic_canceletion(Iterations,data_filtarion)= string('no');end
if data_raw.normalization_out; Super_sorted.normalization_out(Iterations,data_filtarion) = string('yes'); else; Super_sorted.normalization_out(Iterations,data_filtarion)= string('no');end
%========================================================================


super_fast_export_to_excel(data_filtarion,Super_sorted)
end;end;end;%end;%end;%end

%==============================export data===============================


clear all
%==========================Creating the label============================

function super_fast_export_to_excel(Sheets,Sorted_value)
global Iterations;
%==============================import data===============================
switch Sorted_value.Measuring_type
    case 'PESQ'
    do_times=1;
    name_noised={'Score_SQ_noised_narrowband','Score_SQ_noised_wideband'};
    data_noised={Sorted_value.Score_PESQ_noised_narrowband(:,Sheets);Sorted_value.Score_PESQ_noised_wideband(:,Sheets)};
    name_filtered={'Score_SQ_filtered_narrowband','Score_SQ_filtered_wideband'};
    data_filtered={Sorted_value.Score_PESQ_filtered_narrowband(:,Sheets);Sorted_value.Score_PESQ_filtered_wideband(:,Sheets)};
    name_file={append('PESQ','_',Sorted_value.Save_name)};
    add_to_Filter={'Score_SQ_narrowband_by_','Score_SQ_wideband_by_'};
    case 'HASQI'
    do_times=1;
    name_noised={'Score_SQ_noised_EQ_provided','Score_SQ_noiseded_NAL_R_EQ_add'};
    data_noised={Sorted_value.Score_HASQI_noised_narrowband(:,Sheets);Sorted_value.Score_HASQI_noised_wideband(:,Sheets)};
    name_filtered={'Score_SQ_filtered_EQ_provided','Score_SQ_NAL_R_EQ_add'};
    data_filtered={Sorted_value.Score_HASQI_filtered_narrowband(:,Sheets);Sorted_value.Score_HASQI_filtered_wideband(:,Sheets)};
    name_file={append('HASQI','_',Sorted_value.Save_name)};
    add_to_Filter={'Score_SQ_EQ_provided_by_','Score_SQ_NAL_R_EQ_add_by_'};
    case 'Duo'
    do_times=2;
    name_noised={'Score_SQ_noised_narrowband','Score_SQ_noised_wideband','Score_SQ_noised_EQ_provided','Score_SQ_noiseded_NAL_R_EQ_add'};
    data_noised={Sorted_value.Score_PESQ_noised_narrowband(:,Sheets);Sorted_value.Score_PESQ_noised_wideband(:,Sheets);Sorted_value.Score_HASQI_noised_narrowband(:,Sheets);Sorted_value.Score_HASQI_noised_wideband(:,Sheets)};
    name_filtered={'Score_SQ_filtered_narrowband','Score_SQ_filtered_wideband','Score_SQ_filtered_EQ_provided','Score_SQ_NAL_R_EQ_add'};
    data_filtered={Sorted_value.Score_PESQ_filtered_narrowband(:,Sheets);Sorted_value.Score_PESQ_filtered_wideband(:,Sheets);Sorted_value.Score_HASQI_filtered_narrowband(:,Sheets);Sorted_value.Score_HASQI_filtered_wideband(:,Sheets)};
    name_file={append('PESQ','_',Sorted_value.Save_name),append('HASQI','_',Sorted_value.Save_name)};
    add_to_Filter={'Score_SQ_narrowband_by_','Score_SQ_wideband_by_','Score_SQ_EQ_provided_by_','Score_SQ_NAL_R_EQ_add_by_'};
end
for i=1:do_times
exit_table_full=struct( ...
                       string(name_noised(i+(i-1))),{data_noised{i+(i-1)}}, ...
                       string(name_noised(i+1+(i-1))),{data_noised{i+1+(i-1)}}, ...
                       string(name_filtered(i+(i-1))),{data_filtered{i+(i-1)}}, ...
                       string(name_filtered(i+1+(i-1))),{data_filtered{i+1+(i-1)}}, ...
                       'Name_of_noise',{Sorted_value.Name_of_noise(:,Sheets)}, ...
                       'SNR_an_DB',{Sorted_value.SNR_an_DB(:,Sheets)}, ...
                       'Audio_Name',{Sorted_value.Name_of_audio(:,Sheets)}, ...
                       'Filtration_name',{Sorted_value.Filtration_name(:,Sheets)}, ...
                       'Values_of_filtarion',{Sorted_value.Values_of_filtarion(:,Sheets)}, ...
                       'Does_been_load_weights',{Sorted_value.Does_been_load_weight(:,Sheets)}, ...
                       'Does_been_save_weight',{Sorted_value.Does_been_save_weight(:,Sheets)}, ...
                       'Does_knew_the_desired_signal',{Sorted_value.Does_knew_the_desired_signal(:,Sheets)}, ...
                       'Does_do_acoustic_canceletion',{Sorted_value.Does_do_acoustic_canceletion(:,Sheets)}, ...
                       'Does_do_normalization_an_out_of_calculation',{Sorted_value.normalization_out(:,Sheets)}, ...
                       'Times_Training',{Sorted_value.trainning(:,Sheets)}, ...
                       'Zone_of_Trainning',{Sorted_value.been_trainning_zone(:,Sheets)}, ...
                       'Adaption',{Sorted_value.been_adaption(:,Sheets)}, ...
                       'Times_of_repeats',{Sorted_value.Repeats(:,Sheets)}, ...
                       'Samples_size_for_filter',{Sorted_value.Samples_into_filter(:,Sheets)},...
                       'Time_an_Iteration_Sec',{Sorted_value.Seconds_full_Iteration(:,Sheets)},...
                       'Date_of_calculation',{Sorted_value.Filtration_time(:,Sheets)}...
                       );

exit_table_User_friendly=struct( ...
                       string(name_noised(i+(i-1))),{data_noised{i+(i-1)}}, ...
                       string(name_filtered(i+(i-1))),{data_filtered{i+(i-1)}}, ...
                       'SNR_an_DB',{Sorted_value.SNR_an_DB(:,Sheets)}, ...
                       'Values_of_filtarion',{Sorted_value.Values_of_filtarion(:,Sheets)}, ...
                       'Does_knew_the_desired_signal',{Sorted_value.Does_knew_the_desired_signal(:,Sheets)}, ...
                       'Does_do_acoustic_canceletion',{Sorted_value.Does_do_acoustic_canceletion(:,Sheets)}, ...
                       'Samples_size_for_filter',{Sorted_value.Samples_into_filter(:,Sheets)}, ...
                       'Times_Training',{Sorted_value.trainning(:,Sheets)}, ...
                       'Zone_of_Trainning',{Sorted_value.been_trainning_zone(:,Sheets)}, ...
                       'Adaption',{Sorted_value.been_adaption(:,Sheets)}...
                       );

exit_table_comparing_first_label_zone=struct( ...
                       'Name_of_noise',{Sorted_value.Name_of_noise(:,Sheets)}, ...
                       'SNR_an_DB',{Sorted_value.SNR_an_DB(:,Sheets)}, ...
                       string(name_noised(i+(i-1))),{data_noised{i+(i-1)}}, ...
                       string(name_noised(i+1+(i-1))),{data_noised{i+1+(i-1)}}...
                      );
            writetable(struct2table(exit_table_comparing_first_label_zone),append(string(name_file(i)),Sorted_value.Save_type),'Sheet','Comparing_of_all','Range','A1')
exit_table_comparing_next_label_zone=struct( ...
                        append(string(add_to_Filter(i+(i-1))),strrep(strrep(string(Sorted_value.Filtration_name(1,Sheets)),' ','_'),"'",'')),{data_filtered{i+(i-1)}}, ...
                        append(string(add_to_Filter(i+1+(i-1))),strrep(strrep(string(Sorted_value.Filtration_name(1,Sheets)),' ','_'),"'",'')),{data_filtered{i+1+(i-1)}}...
    );

            writetable(struct2table(exit_table_comparing_next_label_zone),append(string(name_file(i)),Sorted_value.Save_type),'Sheet','Comparing_of_all','Range',sprintf('%s1',strrep(char(64+Of_numbers((1.5+1*Sheets)*2)),'@','')))
exit_table_comparing_first_label_zone=struct( ...
                       'Name_of_noise',{Sorted_value.Name_of_noise(:,Sheets)}, ...
                       'SNR_an_DB',{Sorted_value.SNR_an_DB(:,Sheets)}, ...
                       string(name_noised(i+(i-1))),{data_noised{i+(i-1)}} ...
);
            writetable(struct2table(exit_table_comparing_first_label_zone),append(string(name_file(i)),Sorted_value.Save_type),'Sheet','soft_Comparing_of_all','Range','A1')
exit_table_comparing_next_label_zone=struct( ...
                        append(add_to_Filter(i+(i-1)),strrep(strrep(string(Sorted_value.Filtration_name(1,Sheets)),' ','_'),"'",'')),{data_filtered{i+(i-1)}} ...
);
            writetable(struct2table(exit_table_comparing_next_label_zone),append(string(name_file(i)),Sorted_value.Save_type),'Sheet','soft_Comparing_of_all','Range',sprintf('%s1',strrep(char(64+Of_numbers(3+1*Sheets)),'@','')))

            writetable(struct2table(exit_table_full),append(string(name_file(i)),Sorted_value.Save_type),'Sheet',string(Sorted_value.Filtration_name(1,Sheets)),'Range','A1')
            writetable(struct2table(exit_table_User_friendly),append(string(name_file(i)),Sorted_value.Save_type),'Sheet',append('soft_',string(Sorted_value.Filtration_name(1,Sheets))),'Range','A1')


Red=[255 20 0]*[1 255 255^2]';
Yellow=[247 255 2]*[1 255 255^2]';
Green=[240 230 140]*[1 255 255^2]';
Excel_bot=actxserver('Excel.Application'); un_scaring=Excel_bot.Workbooks.Open(append(pwd,'\',string(name_file(i)),Sorted_value.Save_type));
un_scaring.Sheets.Item(1).Application.ActiveWindow.SplitColumn = 4;
un_scaring.Sheets.Item(1).Application.ActiveWindow.SplitRow = 1;
un_scaring.Sheets.Item(1).Application.ActiveWindow.FreezePanes = true;
Noise_value = un_scaring.Sheets.Item(1).Range(['C' num2str(Iterations+1)]).Value;
Filter_value = un_scaring.Sheets.Item(1).Range([strrep(char(64+Of_numbers(3+2*Sheets)),'@','') num2str(Iterations+1)]).Value;
RecolorCeil = un_scaring.Sheets.Item(1).Range([strrep(char(64+Of_numbers(3+2*Sheets)),'@','') num2str(Iterations+1)]);
if Noise_value > Filter_value ; RecolorCeil.Interior.Color=Red;elseif Noise_value <= Filter_value && Noise_value*1.2 >= Filter_value; RecolorCeil.Interior.Color=Yellow; elseif Filter_value > 1.2*Noise_value; RecolorCeil.Interior.Color=Green; end;
Noise_value = un_scaring.Sheets.Item(1).Range(['D' num2str(Iterations+1)]).Value;
Filter_value = un_scaring.Sheets.Item(1).Range([strrep(char(64+Of_numbers(4+2*Sheets)),'@','') num2str(Iterations+1)]).Value;
RecolorCeil = un_scaring.Sheets.Item(1).Range([strrep(char(64+Of_numbers(4+2*Sheets)),'@','') num2str(Iterations+1)]);
if Noise_value > Filter_value ; RecolorCeil.Interior.Color=Red;elseif Noise_value <= Filter_value && Noise_value*1.2 >= Filter_value; RecolorCeil.Interior.Color=Yellow; elseif Filter_value > 1.2*Noise_value; RecolorCeil.Interior.Color=Green; end;
un_scaring.Sheets.Item(2).Activate;
un_scaring.Sheets.Item(2).Application.ActiveWindow.SplitColumn = 3;
un_scaring.Sheets.Item(2).Application.ActiveWindow.SplitRow = 1;
un_scaring.Sheets.Item(2).Application.ActiveWindow.FreezePanes = true;
Noise_value = un_scaring.Sheets.Item(2).Range(['C' num2str(Iterations+1)]).Value;
Filter_value = un_scaring.Sheets.Item(2).Range([strrep(char(64+Of_numbers(3+1*Sheets)),'@','') num2str(Iterations+1)]).Value;
RecolorCeil = un_scaring.Sheets.Item(2).Range([strrep(char(64+Of_numbers(3+1*Sheets)),'@','') num2str(Iterations+1)]);
if Noise_value > Filter_value ; RecolorCeil.Interior.Color=Red;elseif Noise_value <= Filter_value && Noise_value*1.2 >= Filter_value; RecolorCeil.Interior.Color=Yellow; elseif Filter_value > 1.2*Noise_value; RecolorCeil.Interior.Color=Green; end;
un_scaring.Sheets.Item(Sheets*2+1).Activate;
un_scaring.Sheets.Item(Sheets*2+1).Application.ActiveWindow.SplitRow = 1;
un_scaring.Sheets.Item(Sheets*2+1).Application.ActiveWindow.FreezePanes = true;
Noise_value = un_scaring.Sheets.Item(Sheets*2+1).Range(['A' num2str(Iterations+1)]).Value;
Filter_value = un_scaring.Sheets.Item(Sheets*2+1).Range([char('C') num2str(Iterations+1)]).Value;
RecolorCeil = un_scaring.Sheets.Item(Sheets*2+1).Range([char('C') num2str(Iterations+1)]);
if Noise_value > Filter_value ; RecolorCeil.Interior.Color=Red;elseif Noise_value <= Filter_value && Noise_value*1.2 >= Filter_value; RecolorCeil.Interior.Color=Yellow; elseif Filter_value > 1.2*Noise_value; RecolorCeil.Interior.Color=Green; end;
Noise_value = un_scaring.Sheets.Item(Sheets*2+1).Range(['B' num2str(Iterations+1)]).Value;
Filter_value = un_scaring.Sheets.Item(Sheets*2+1).Range([char('D') num2str(Iterations+1)]).Value;
RecolorCeil = un_scaring.Sheets.Item(Sheets*2+1).Range([char('D') num2str(Iterations+1)]);
if Noise_value > Filter_value ; RecolorCeil.Interior.Color=Red;elseif Noise_value <= Filter_value && Noise_value*1.2 >= Filter_value; RecolorCeil.Interior.Color=Yellow; elseif Filter_value > 1.2*Noise_value; RecolorCeil.Interior.Color=Green; end;
un_scaring.Sheets.Item(Sheets*2+2).Activate;
un_scaring.Sheets.Item(Sheets*2+2).Application.ActiveWindow.SplitRow = 1;
un_scaring.Sheets.Item(Sheets*2+2).Application.ActiveWindow.FreezePanes = true;
Noise_value = un_scaring.Sheets.Item(Sheets*2+2).Range(['A' num2str(Iterations+1)]).Value;
Filter_value = un_scaring.Sheets.Item(Sheets*2+2).Range([char('B') num2str(Iterations+1)]).Value;
RecolorCeil = un_scaring.Sheets.Item(Sheets*2+2).Range([char('B') num2str(Iterations+1)]);
if Noise_value > Filter_value ; RecolorCeil.Interior.Color=Red;elseif Noise_value <= Filter_value && Noise_value*1.2 >= Filter_value; RecolorCeil.Interior.Color=Yellow; elseif Filter_value > 1.2*Noise_value; RecolorCeil.Interior.Color=Green; end;
un_scaring.Sheets.Item(1).Activate;
un_scaring.Save;
un_scaring.Close;
Excel_bot.Quit;
end
end

function it_is_number_truth = Of_numbers(A)
        it_is_number_truth=[];
        while A > 0
             it_is_number_truth_raw = mod(A - 1, 26);
        it_is_number_truth = [it_is_number_truth_raw + 1, it_is_number_truth]; 
        A = floor((A - 1) / 26);
        end
end

