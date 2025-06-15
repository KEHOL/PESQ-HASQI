function figure_WaveSpectrogram = Look_WaveSpectrogram(signal_to_Wave,FS_to_Wave,name_for_WaveSpectrogram)

    Name_of_Samples = "Seconds";
    


figure_WaveSpectrogram = figure('name',append(name_for_WaveSpectrogram," ","in total length ",num2str(length(signal_to_Wave)/FS_to_Wave)," ",Name_of_Samples));
tiledlayout(2, 1, 'TileSpacing', 'tight');
set(gcf, 'WindowState', 'maximized');

    nexttile;
plot((0:length(signal_to_Wave)-1)/FS_to_Wave,signal_to_Wave);
title(append(name_for_WaveSpectrogram," ","in ",Name_of_Samples));
set(gca, 'XTickLabel', []);
ylabel("Amplitude")
xlim([0+1e-27 numel(signal_to_Wave)/FS_to_Wave]);
grid on
    nexttile;
    size=[round(256),round(256*0.75)];
     spectrogram(signal_to_Wave,size(1),size(2),[],FS_to_Wave,"yaxis");
xlabel(Name_of_Samples);
ylabel("Freq");
xlim([0+1e-27 numel(signal_to_Wave)/FS_to_Wave]);
grid on;



                                            %=== Global_export ===
                                    global Save_img; global type_save_img;
                                            %=====================
                Do_Save_an_img(figure_WaveSpectrogram,Save_img,type_save_img) %=====save as img======
end