function figure_FFT = Look_FFT(signal_to_FFT,FS_to_FFT,name_for_FFT,from_HZ_FFT,To_HZ_FFT)
figure_FFT = figure('name',name_for_FFT);
set(gcf, 'WindowState', 'maximized');
stem(FS_to_FFT/(length(signal_to_FFT))*(0:length(signal_to_FFT)-1),abs(fft(signal_to_FFT,[],1)))
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