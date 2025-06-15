function score_global_exit_SQ = main(setted_data)
%main zone to iterate with any filters start from there
%=============================== clear data to work======================
%clear all
clc
close all
%===========================Import SuperControl panel(Base)===============
if exist('setted_data', 'var')
    base_data=comparering_data(setted_data,base_data_saved);
else
base_data=comparering_data(struct('Error',{nan}),base_data_saved);end
%========================================================================
                            %===global_import===
global Save_img; global type_save_img; global data_size; global trainning; global load_weight; global save_weight; global adaption; global trainning_zone; global convergence_rate
                            %===================
 Save_img=base_data.base_Save_img; type_save_img=base_data.base_type_save_img; %save as img? What type it should be?

%===============================start import file========================
                      file_name=base_data.base_file_name;

                    [y_signal,fs]=import_file(file_name,base_data.base_file_type);
score_global_exit_SQ.type_of_audio=base_data.base_file_name;
%=============================== end import file ========================
sec=datetime('now')
%========================================================================   
y_signal = y_signal(:,1); %if we had stereo sound get work into mono sound
if base_data.base_do_normalization_out
y_signal=audio_normalization(y_signal);end
                                   %samples of signal_in to working
                                   %thought current element:
                                if isstring(base_data.base_data_size)
                                data_size=eval(base_data.base_data_size);
                                else; data_size=base_data.base_data_size; end
                                   trainning = base_data.base_trainning; %how much need times of trainning the filter's weight
                                   load_weight = base_data.base_load_weight; %does need to load avaivable weights? if it Exist it would load it. better save weight for half or lower data size
                                   save_weight = base_data.base_save_weight;
                                if isstring(base_data.base_adaption)
                                adaption=eval(base_data.base_adaption);  % most not be greater than the data_size;
                                else; adaption=base_data.base_adaption; end 
                                if isstring(base_data.base_trainning_zone)
                                trainning_zone=eval(base_data.base_trainning_zone);  % most not be greater than the data_size;
                                else; trainning_zone=base_data.base_trainning_zone; end
                                convergence_rate=base_data.base_do_convergence_rate;

%========================== look imported file============================
           if base_data.base_do_look_clear_wave
               if base_data.base_do_look_FFT
           fig_of_spectral = Look_FFT(y_signal,fs,'Spectral In',base_data.base_Increaze_Look_Freq(2),fs/2);end
            if base_data.base_do_look_Wave
                if base_data.base_do_use_Fs
                 fig_of_wave = Look_Wave(y_signal,fs,'Signal In'); else
                 fig_of_wave = Look_Wave(y_signal,1,'Signal In'); end
            end
                if base_data.base_do_look_WaveSpectrogram
            fig_of_Specrtogram = Look_WaveSpectrogram(y_signal,fs,'Spectrogram In'); end;

            if base_data.base_do_look_FFT && base_data.base_do_Increase_look_FFT
                    Increaze_Look(fig_of_spectral,base_data.base_Increaze_Look_Freq(1),base_data.base_Increaze_Look_Freq(2),base_data.base_Increaze_Look_Freq(3));
            end
            if base_data.base_do_look_Wave && base_data.base_do_Increase_look_Wave
                if ~base_data.base_do_use_Fs 
                    if iscell(base_data.base_Increaze_Look_wave_samples)
                    Increaze_Look(fig_of_wave,eval(string(base_data.base_Increaze_Look_wave_samples(1))),eval(string(base_data.base_Increaze_Look_wave_samples(2))),eval(string(base_data.base_Increaze_Look_wave_samples(3))));else
                    Increaze_Look(fig_of_wave,base_data.base_Increaze_Look_wave_samples(1),base_data.base_Increaze_Look_wave_samples(2),base_data.base_Increaze_Look_wave_samples(3)); end
                else;  Increaze_Look(fig_of_wave,base_data.base_Increaze_Look_wave_seconds(1),base_data.base_Increaze_Look_wave_seconds(2),base_data.base_Increaze_Look_wave_seconds(3)); end
            end   
           end
if base_data.base_do_listening ; listen_audio(y_signal,fs);end
%======================== adding noise ===============================

  y_signal_noised = noise_add(y_signal,base_data.base_SNRdb,base_data.base_noise_type,base_data.base_noise_shift_an_seconds,fs);

score_SQ_PESQ (1) = 0; score_SQ_PESQ (2) = 0;
score_SQ_HASQI (1)= 0; score_SQ_HASQI (2)= 0;
switch base_data.base_speech_measuring
    case 'PESQ'
  score_SQ_PESQ = PESQ_test_measuring(y_signal_noised,y_signal,fs,'both') %pesq testing
  score_SQ=score_SQ_PESQ;
    case 'HASQI'
  score_SQ_HASQI = HASQI_test_measuring(y_signal_noised,y_signal,fs,'both') %HASQI testing
  score_SQ=score_SQ_HASQI;
    case 'Duo'
  score_SQ_PESQ = PESQ_test_measuring(y_signal_noised,y_signal,fs,'both') %pesq testing     
  score_SQ_HASQI = HASQI_test_measuring(y_signal_noised,y_signal,fs,'both') %HASQI testing
  score_SQ=score_SQ_PESQ;
end

  if base_data.base_do_export
  export_file(file_name,y_signal_noised,fs,append('SNR_',num2str(base_data.base_SNRdb),'_dB_',num2str(score_SQ(1))),base_data.base_file_type_out); end
        score_global_exit_SQ.score_SQ_PESQ_with_noise=score_SQ_PESQ;
        score_global_exit_SQ.score_SQ_HASQI_with_noise=score_SQ_HASQI;
  score_global_exit_SQ.type_of_noise={base_data.base_noise_type,base_data.base_SNRdb};
  score_global_exit_SQ.shift_noise_in_seconds=base_data.base_noise_shift_an_seconds;
%=============================== look noised file =====================
           if base_data.base_do_look_noised_wave
               if base_data.base_do_look_FFT
           fig_of_spectral = Look_FFT(y_signal_noised,fs,append('Spectral noised',' by ',base_data.base_noise_type),base_data.base_Increaze_Look_Freq(2),fs/2);end
            if base_data.base_do_look_Wave
                if base_data.base_do_use_Fs
                 fig_of_wave = Look_Wave(y_signal_noised,fs,append('Signal noised',' by ',base_data.base_noise_type)); else
                 fig_of_wave = Look_Wave(y_signal_noised,1,append('Signal noised',' by ',base_data.base_noise_type)); end
            end
                if base_data.base_do_look_WaveSpectrogram
            fig_of_Specrtogram = Look_WaveSpectrogram(y_signal_noised,fs,append('Spectrogram noised',' by ',base_data.base_noise_type)); end;

            if base_data.base_do_look_FFT && base_data.base_do_Increase_look_FFT
                    Increaze_Look(fig_of_spectral,base_data.base_Increaze_Look_Freq(1),base_data.base_Increaze_Look_Freq(2),base_data.base_Increaze_Look_Freq(3));
            end
            if base_data.base_do_look_Wave && base_data.base_do_Increase_look_Wave
                if ~base_data.base_do_use_Fs 
                    if iscell(base_data.base_Increaze_Look_wave_samples)
                    Increaze_Look(fig_of_wave,eval(string(base_data.base_Increaze_Look_wave_samples(1))),eval(string(base_data.base_Increaze_Look_wave_samples(2))),eval(string(base_data.base_Increaze_Look_wave_samples(3))));else
                    Increaze_Look(fig_of_wave,base_data.base_Increaze_Look_wave_samples(1),base_data.base_Increaze_Look_wave_samples(2),base_data.base_Increaze_Look_wave_samples(3)); end
                else;  Increaze_Look(fig_of_wave,base_data.base_Increaze_Look_wave_seconds(1),base_data.base_Increaze_Look_wave_seconds(2),base_data.base_Increaze_Look_wave_seconds(3)); end
            end   
           end
if base_data.base_do_listening ; listen_audio(y_signal_noised,fs);end
%======================== start filtration chose type of filtration ===============================
%sound_in_to_patch_without_filter(y_signal,y_signal)
        global auto_agree
        auto_agree=base_data.base_filtration_auto_GPU;
        repeat_completed=0;

        y_signal_noised_saved=y_signal_noised;
while base_data.base_repeat_filtration >= repeat_completed
            if ~repeat_completed==0; load_weight=1 ;else;end;
switch base_data.base_filtration_type
    case 'LMS'
%LMS filter 
        y_signal_filtered=filter_LMS_Improved(y_signal_noised,eval(base_data.base_desired_signal_be),base_data.base_value_filtration_for_LMS); 
        score_global_exit_SQ.value_filtration = base_data.base_value_filtration_for_LMS;

    case 'RLS'
%RLS Filter
        y_signal_filtered=filter_RLS_Improved(y_signal_noised,eval(base_data.base_desired_signal_be),base_data.base_value_filtration_for_RLS); 
        score_global_exit_SQ.value_filtration = base_data.base_value_filtration_for_RLS;

    case 'Bilinear RLS'  %cannot be used correctly
%Bilinear(Volterrs) RLS Filter
        y_signal_filtered=filter_Bilinear_RLS_Improved(y_signal_noised,eval(base_data.base_desired_signal_be),base_data.base_value_filtration_for_Bilinear_RLS(1),base_data.base_value_filtration_for_Bilinear_RLS(2),base_data.base_value_filtration_for_Bilinear_RLS(3));
        score_global_exit_SQ.value_filtration = base_data.base_value_filtration_for_Bilinear_RLS;

    case 'Volterrs MLS'
%Volterrs(Bilinier) LMS Filter
        y_signal_filtered=filter_Volterrs_LMS_Improved(y_signal_noised,eval(base_data.base_desired_signal_be),base_data.base_value_filtration_for_Volterrs_MLS(1),base_data.base_value_filtration_for_Volterrs_MLS(2),base_data.base_value_filtration_for_Volterrs_MLS(3));
        score_global_exit_SQ.value_filtration = base_data.base_value_filtration_for_Volterrs_MLS;

    case 'Blind Adapt by Sato'
%Blind Adapt Filter "by Sato"
 global sato
 sato = 1;  y_signal_filtered=filter_Godart_algoritm_Improved(y_signal_noised,base_data.base_value_filtration_for_Blind_Adapt_by_Sato(1),base_data.base_value_filtration_for_Blind_Adapt_by_Sato(2),base_data.base_value_filtration_for_Blind_Adapt_by_Sato(3));  
 score_global_exit_SQ.value_filtration = base_data.base_value_filtration_for_Blind_Adapt_by_Sato;
base_data.base_desired_signal_be="y_signal_noised";
    case 'Blind Adapt by Godart'
 global sato      
%Blind Adapt Filter "by Godart"
 sato = 0;  y_signal_filtered=filter_Godart_algoritm_Improved(y_signal_noised,base_data.base_value_filtration_for_Blind_Adapt_by_Godart(1),base_data.base_value_filtration_for_Blind_Adapt_by_Godart(2),base_data.base_value_filtration_for_Blind_Adapt_by_Godart(3));
 score_global_exit_SQ.value_filtration = base_data.base_value_filtration_for_Blind_Adapt_by_Godart;
base_data.base_desired_signal_be="y_signal_noised";
    case 'BlockThresholding an TimeFreq' %cannot be used correctly by back time-Freq into time, have losts.
        y_signal_filtered=filter_Block_Thresholding_TF_Improved(y_signal_noised,eval(base_data.base_desired_signal_be),fs,base_data.base_value_filtration_for_BlockThresholding_an_TimeFreq(1),base_data.base_value_filtration_for_BlockThresholding_an_TimeFreq(2))
    case "Kalman's"
%Kalman's Filter %complished
        y_signal_filtered=filter_Kalman_Improved(y_signal_noised,eval(base_data.base_desired_signal_be),base_data.base_value_filtration_for_Kalmans(1),base_data.base_value_filtration_for_Kalmans(2)); 
        score_global_exit_SQ.value_filtration = base_data.base_value_filtration_for_Kalmans;
    case "Kalman's_GPU"
%the gpu varience should use for more than 150-200 extra adaptation 
        y_signal_filtered=filter_Kalman_GPU_powered(y_signal_noised,eval(base_data.base_desired_signal_be),base_data.base_value_filtration_for_Kalmans(1),base_data.base_value_filtration_for_Kalmans(2));  
        score_global_exit_SQ.value_filtration = base_data.base_value_filtration_for_Kalmans;
    otherwise;
        %no filtration
        
        y_signal_filtered=y_signal_noised;
        score_global_exit_SQ.value_filtration = nan;
end
if base_data.base_do_normalization_out
y_signal_filtered=audio_normalization(y_signal_filtered);end

if base_data.base_do_acoustic_cancelation
y_signal_filtered=eval(base_data.base_desired_signal_be)-y_signal_filtered;end

seconds(datetime('now')-sec)
if base_data.base_do_normalization_out
y_signal_filtered=audio_normalization(y_signal_filtered);end
repeat_completed=repeat_completed+1;
y_signal_noised=y_signal_filtered; %repeat filtration


end
%======================== end ^filtration =============================== 
switch base_data.base_speech_measuring
    case 'PESQ'
  score_SQ_PESQ = PESQ_test_measuring(y_signal_filtered,y_signal,fs,'both') %pesq testing
  score_SQ=score_SQ_PESQ;
    case 'HASQI'
  score_SQ_HASQI = HASQI_test_measuring(y_signal_filtered,y_signal,fs,'both') %HASQI testing
  score_SQ=score_SQ_HASQI;
    case 'Duo'
  score_SQ_PESQ = PESQ_test_measuring(y_signal_noised,y_signal,fs,'both') %pesq testing     
  score_SQ_HASQI= HASQI_test_measuring(y_signal_noised,y_signal,fs,'both') %HASQI testing
  score_SQ=score_SQ_PESQ;
end

        score_global_exit_SQ.score_SQ_PESQ_filtered=score_SQ_PESQ;
        score_global_exit_SQ.score_SQ_HASQI_filtered=score_SQ_HASQI;
    score_global_exit_SQ.name_of_type_filtering=base_data.base_filtration_type;
%=============================== look filtered yfile =====================
           if base_data.base_do_look_filtered_wave
               if base_data.base_do_look_FFT
           fig_of_spectral = Look_FFT(y_signal_filtered,fs,append('Spectral out',' by ',base_data.base_filtration_type),base_data.base_Increaze_Look_Freq(2),fs/2);end
                    if base_data.base_do_Reference_FFT
                         fig_of_spectral_reference = Reference_Look_FFT(y_signal_noised_saved,y_signal_filtered,fs,'Spectral reference noise vs out',base_data.base_Increaze_Look_Freq(2),fs/2); end
            if base_data.base_do_look_Wave
                if base_data.base_do_use_Fs
                 fig_of_wave = Look_Wave(y_signal_filtered,fs,append('Signal out',' by ',base_data.base_filtration_type));
                      if base_data.base_do_Reference_Wave 
                      fig_of_wave_reference = Reference_Look_Waves(y_signal_noised_saved,y_signal_filtered,fs,'Signal reference noise vs out'); end
                else
                 fig_of_wave = Look_Wave(y_signal_filtered,1,append('Signal out',' by ',base_data.base_filtration_type));
                        if base_data.base_do_Reference_Wave 
                        fig_of_wave_reference = Reference_Look_Waves(y_signal_noised_saved,y_signal_filtered,1,'Signal reference noise vs out'); end
                end
                     
            end
                                if base_data.base_do_look_WaveSpectrogram
            fig_of_Specrtogram = Look_WaveSpectrogram(y_signal_noised,fs,append('Spectrogram out',' by ',base_data.base_filtration_type)); 
                                if base_data.base_do_Reference_Wave 
                        fig_of_Specrtogram_reference = Reference_Look_WaveSpectrogram(y_signal_noised_saved,y_signal_filtered,fs,'Spectrogram reference noise vs out'); end
                                end;

            if base_data.base_do_look_FFT && base_data.base_do_Increase_look_FFT
                    Increaze_Look(fig_of_spectral,base_data.base_Increaze_Look_Freq(1),base_data.base_Increaze_Look_Freq(2),base_data.base_Increaze_Look_Freq(3));
                    if base_data.base_do_Reference_Wave 
                    Increaze_Look(fig_of_spectral_reference,base_data.base_Increaze_Look_Freq(1),base_data.base_Increaze_Look_Freq(2),base_data.base_Increaze_Look_Freq(3));end
            end
            if base_data.base_do_look_Wave && base_data.base_do_Increase_look_Wave
                if ~base_data.base_do_use_Fs 
                    if iscell(base_data.base_Increaze_Look_wave_samples)
                    Increaze_Look(fig_of_wave,eval(string(base_data.base_Increaze_Look_wave_samples(1))),eval(string(base_data.base_Increaze_Look_wave_samples(2))),eval(string(base_data.base_Increaze_Look_wave_samples(3))));
                         if base_data.base_do_Reference_Wave 
                         Increaze_Look(fig_of_wave_reference,eval(string(base_data.base_Increaze_Look_wave_samples(1))),eval(string(base_data.base_Increaze_Look_wave_samples(2))),eval(string(base_data.base_Increaze_Look_wave_samples(3))));end;else
                    Increaze_Look(fig_of_wave,base_data.base_Increaze_Look_wave_samples(1),base_data.base_Increaze_Look_wave_samples(2),base_data.base_Increaze_Look_wave_samples(3)); 
                         if base_data.base_do_Reference_Wave 
                         Increaze_Look(fig_of_wave_reference,base_data.base_Increaze_Look_wave_samples(1),base_data.base_Increaze_Look_wave_samples(2),base_data.base_Increaze_Look_wave_samples(3));end;end
                else;  Increaze_Look(fig_of_wave,base_data.base_Increaze_Look_wave_seconds(1),base_data.base_Increaze_Look_wave_seconds(2),base_data.base_Increaze_Look_wave_seconds(3));
                         if base_data.base_do_Reference_Wave 
                         Increaze_Look(fig_of_wave_reference,base_data.base_Increaze_Look_wave_seconds(1),base_data.base_Increaze_Look_wave_seconds(2),base_data.base_Increaze_Look_wave_seconds(3));end;end
            end   
           end

if base_data.base_do_listening ; listen_audio(y_signal_filtered,fs);end
%=============================== start export file=======================
if base_data.base_do_export
export_file(file_name,y_signal_filtered,fs,append('exit_',num2str(score_SQ(1))),base_data.base_file_type_out);end
seconds(datetime('now')-sec)

score_global_exit_SQ.been_load_weight=base_data.base_load_weight;
score_global_exit_SQ.been_save_weight=base_data.base_save_weight;
score_global_exit_SQ.been_adaption=base_data.base_adaption;
score_global_exit_SQ.been_trainning_zone=base_data.base_trainning_zone;
if base_data.base_desired_signal_be == 'y_signal'
score_global_exit_SQ.does_knew_the_desired_signal=1; else;score_global_exit_SQ.does_knew_the_desired_signal=0; end;
score_global_exit_SQ.does_do_acoustic_canceletion=base_data.base_do_acoustic_cancelation;
score_global_exit_SQ.trainning=base_data.base_trainning;
score_global_exit_SQ.normalization_out=base_data.base_do_normalization_out;
score_global_exit_SQ.happen_repeat_of_filtration=base_data.base_repeat_filtration;
score_global_exit_SQ.Samples_into_filter=data_size;
score_global_exit_SQ.SQ_measuring_type=base_data.base_speech_measuring;

%=============================== end import file ========================
%clc
close all

%main mission:
%have posisbility to fast oparate with any noise reducers
%========================================================================
%save only exit data
saving = who;
saving(strcmp(saving,'score_global_exit_SQ')) = [];
clear(saving{:}); clear saving
end



