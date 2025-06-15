function exit_base_data = base_data_saved
%==========\/=============configuration tabel===============\/============
%name of file:
base_file_name_str='Sounds/My_speech.1.474(16Khz)';
%type of file
base_file_type_str='.mp3';
base_file_type_out_str='.wav';
base_do_export_value=1;
%base saving value:
base_Save_img_value=1              ;base_type_save_img_str='.png'; 

%base value of work filters:
        base_data_size_str=string('floor(numel(y_signal)/1)');
    %base_data_size_str=1000;
base_trainning_value=1;
base_repeat_filtration_value=0;
base_load_weight_value=0;
base_save_weight_value=1;
        %base_adaption_value=string('floor(numel(y_signal)/2)');
        base_adaption_value=100;  

        base_trainning_zone_value=string('floor(numel(y_signal)/2)');
    %base_trainning_zone_value=5000;

%base choose filterion:

%base_filtration_type_str = 'no filtration';
base_filtration_type_str = 'LMS'; %adapatation some in 400, zone almost +-60
%base_filtration_type_str = 'RLS';  %adapatation some in 1-3, zone almost 50 same to size
%--------------------------------------------------------------------------
%base_filtration_type_str = 'Bilinear RLS'; cannot be used (old)
%--------------------------------------------------------------------------
%base_filtration_type_str = 'Volterrs MLS'; %adapatation some in any, zone almost +any
%base_filtration_type_str = 'Blind Adapt by Sato';  %adapatation some in any, zone almost +any adaptation 10
%base_filtration_type_str = 'Blind Adapt by Godart';  %adapatation some in any, zone almost +any
%--------------------------------------------------------------------------
%base_filtration_type_str = 'BlockThresholding an TimeFreq'; %cannot be used 
%need better sftp -> isftp workspace
%--------------------------------------------------------------------------
%base_filtration_type_str = "Kalman's"; %as bigger adaptation and zone then better
%base_filtration_type_str = "Kalman's_GPU"; %for bigger adaptation and zone then faster

base_filtration_auto_GPU_value = 1;

base_do_convergence_rate_value = 0; %SET to ZERO, using to much time to 1 exit

base_do_normalization_out_value = 1;

%base values for filters:

base_value_filtration_for_LMS_value=4e-4; %ass comes to over 4e-2 then better
base_value_filtration_for_RLS_value=0.99; %ass less then best
base_value_filtration_for_Bilinear_RLS_values=[10e-1,0.97]; %cannot be used
base_value_filtration_for_Volterrs_MLS_values=[3e-2,50,4e-5];
base_value_filtration_for_Blind_Adapt_by_Sato_values=[1,5,4e-5];
base_value_filtration_for_Blind_Adapt_by_Godart_values=[3,5,4e-5];
base_value_filtration_for_BlockThresholding_an_TimeFreq_values =[1,2]; %cannot be used
base_value_filtration_for_Kalmans_values=[1,3]; %training 10-30 times enough


%post filtering
base_do_Acoustic_cancelation_value=1; %while disered is unknown
%base desired signal must be:

%base_desired_signal_be_str="y_signal_noised";
base_desired_signal_be_str="y_signal";

%base_Measuring_type_is=
%base_speech_measuring_str="PESQ";
base_speech_measuring_str="HASQI";
%base_speech_measuring_str="Duo";
%base value of adding/creating noise:

base_SNRdb_value=0;

%base_noise_type_str = 'gaussian';
%base_noise_type_str = 'rand'; 
%base_noise_type_str = 'speaking strong'; 
%base_noise_type_str = 'speaking calm'; 
%base_noise_type_str = 'dog and people'; 
%base_noise_type_str = 'building side'; 
base_noise_type_str = 'highway side'; 
%base_noise_type_str = 'subway arrive'; 
%base_noise_type_str = 'self noise'; 

base_noise_shift_an_seconds_value = 1;

%base use scoring SQ:
base_by_PESQ_value=1;
%zone of looking:

base_do_look_clear_wave_value=0;
base_do_look_noised_wave_value=0;
base_do_look_filtered_wave_value=0;

%base plot Increasing and settings

base_Increaze_Look_Freq_values=[2000,0,8000]; %the delta freq, the start freq, end freq 
base_Increaze_Look_wave_samples_strs={'data_size/4','0','data_size'}; %for samples
base_Increaze_Look_wave_seconds_values=[1/4,0,1]; %for seconds %*

base_do_look_FFT_value=0;
base_do_look_Wave_value=0;
base_do_look_WaveSpectrogram_value=1;
base_do_use_Fs_value=0;
base_do_Increase_look_Wave_value=0;
base_do_Increase_look_FFT_value=0;
base_do_Reference_FFT_value=0;
base_do_Reference_Wave_value=1;



%non needed:
base_do_listening_value=0;
%==============================end tabel==================================
%==========\/============== structure compiling ============\/============
exit_base_data=struct( ...
    'base_Save_img',{base_Save_img_value}, ...  %to data get write "exit_base_data.base_data"
    'base_type_save_img',{base_type_save_img_str}, ...
    'base_file_name',{base_file_name_str}, ...
    'base_file_type',{base_file_type_str}, ...
    'base_data_size',{base_data_size_str}, ...
    'base_trainning',{base_trainning_value}, ...
    'base_load_weight',{base_load_weight_value}, ...
    'base_save_weight',{base_save_weight_value}, ...
    'base_adaption',{base_adaption_value}, ...
    'base_trainning_zone',{base_trainning_zone_value}, ...
    'base_SNRdb',{base_SNRdb_value}, ...
    'base_noise_type',{base_noise_type_str}, ...
    'base_by_PESQ',{base_by_PESQ_value}, ...
    'base_Increaze_Look_Freq',{base_Increaze_Look_Freq_values}, ...
    'base_Increaze_Look_wave_samples',{base_Increaze_Look_wave_samples_strs}, ...
    'base_Increaze_Look_wave_seconds',{base_Increaze_Look_wave_seconds_values}, ...
    'base_do_look_FFT',{base_do_look_FFT_value}, ...
    'base_do_look_Wave',{base_do_look_Wave_value}, ...
    'base_do_look_WaveSpectrogram',{base_do_look_WaveSpectrogram_value}, ...
    'base_do_Increase_look_Wave',{base_do_Increase_look_Wave_value}, ...
    'base_do_Increase_look_FFT',{base_do_Increase_look_FFT_value}, ...
    'base_do_Reference_FFT',{base_do_Reference_FFT_value}, ...
    'base_do_Reference_Wave',{base_do_Reference_Wave_value}, ...
    'base_do_listening',{base_do_listening_value}, ...
    'base_filtration_type',{base_filtration_type_str}, ...
    'base_do_look_clear_wave',{base_do_look_clear_wave_value}, ...
    'base_do_look_noised_wave',{base_do_look_noised_wave_value}, ...
    'base_do_look_filtered_wave',{base_do_look_filtered_wave_value}, ...
    'base_value_filtration_for_LMS',{base_value_filtration_for_LMS_value}, ...
    'base_value_filtration_for_RLS',{base_value_filtration_for_RLS_value}, ...
    'base_value_filtration_for_Bilinear_RLS',{base_value_filtration_for_Bilinear_RLS_values}, ...
    'base_value_filtration_for_Volterrs_MLS',{base_value_filtration_for_Volterrs_MLS_values}, ...
    'base_value_filtration_for_Blind_Adapt_by_Sato',{base_value_filtration_for_Blind_Adapt_by_Sato_values}, ...
    'base_value_filtration_for_Blind_Adapt_by_Godart',{base_value_filtration_for_Blind_Adapt_by_Godart_values}, ...
    'base_value_filtration_for_BlockThresholding_an_TimeFreq',{base_value_filtration_for_BlockThresholding_an_TimeFreq_values}, ...
    'base_value_filtration_for_Kalmans',{base_value_filtration_for_Kalmans_values}, ...
    'base_desired_signal_be',{base_desired_signal_be_str}, ...
    'base_speech_measuring',{base_speech_measuring_str}, ...
    'base_do_use_Fs',{base_do_use_Fs_value}, ...
    'base_file_type_out',{base_file_type_out_str}, ...
    'base_do_convergence_rate',{base_do_convergence_rate_value}, ...
    'base_do_acoustic_cancelation',{base_do_Acoustic_cancelation_value}, ...
    'base_do_export',{base_do_export_value}, ...
    'base_noise_shift_an_seconds',{base_noise_shift_an_seconds_value}, ...
    'base_filtration_auto_GPU',{base_filtration_auto_GPU_value}, ...
    'base_do_normalization_out',{base_do_normalization_out_value}, ...
    'base_repeat_filtration',{base_repeat_filtration_value}, ...
    'base_raw',{nan} ...
);
%=================================export=================================
end