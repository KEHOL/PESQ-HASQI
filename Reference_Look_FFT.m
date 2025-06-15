function figure_FFT = Reference_Look_FFT(signal_to_FFT,Reference_signal_to_FFT,FS_to_FFT,name_for_FFT,from_HZ_FFT,To_HZ_FFT)
figure_FFT = figure('name',name_for_FFT);
set(gcf, 'WindowState', 'maximized');
stem(FS_to_FFT/(length(signal_to_FFT))*(0:length(signal_to_FFT)-1),abs(fft(signal_to_FFT,[],1)))
hold on 
stem(FS_to_FFT/(length(Reference_signal_to_FFT))*(0:length(Reference_signal_to_FFT)-1),abs(fft(Reference_signal_to_FFT,[],1)),'color',[1,0.5,0])
title(name_for_FFT);
xlabel("F (Hz)")
ylabel("Amplitude")
grid on
xlim([from_HZ_FFT To_HZ_FFT]);
                                            %=== Global_export ===
                                    global Save_img; global type_save_img;
                                            %=====================
                Do_Save_an_img(figure_FFT,Save_img,type_save_img) %=====save as img======
end