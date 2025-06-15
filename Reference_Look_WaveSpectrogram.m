function figure_Wave = Reference_Look_WaveSpectrogram(signal_to_Wave,Reference_signal_to_wave,FS_to_Wave,name_for_Wave)

 Name_of_Samples = "Seconds";


    figure_Wave = figure('name',append(name_for_Wave," ","in total length ",num2str(length(signal_to_Wave)/FS_to_Wave)," ",Name_of_Samples));
     tiledlayout(3, 1, 'TileSpacing', 'tight');
    set(gcf, 'WindowState', 'maximized');

    nexttile;
plot((0:length(signal_to_Wave)-1)/FS_to_Wave,signal_to_Wave);
hold on
plot((0:length(Reference_signal_to_wave)-1)/FS_to_Wave,Reference_signal_to_wave,'color',[1,0.5,0]);
title(append(name_for_Wave," ","in ",Name_of_Samples));
xlim([0+1e-27 numel(signal_to_Wave)/FS_to_Wave]);
ylabel("Amplitude")
xlabel('');
set(gca, 'XTickLabel', []);
grid on

     nexttile;
     size=[round(256),round(256*0.75)];
     spectrogram(signal_to_Wave,size(1),size(2),[],FS_to_Wave,"yaxis");
ylabel("Freq for reference");
xlim([0+1e-27 numel(signal_to_Wave)/FS_to_Wave]);
xlabel('');
set(gca, 'XTickLabel', []);
grid on;

     nexttile;
     spectrogram(Reference_signal_to_wave,size(1),size(2),[],FS_to_Wave,"yaxis");
xlabel(Name_of_Samples);
ylabel("Freq for current");
xlim([0+1e-27 numel(Reference_signal_to_wave)/FS_to_Wave]);
grid on;
                                            %=== Global_export ===
                                    global Save_img; global type_save_img;
                                            %=====================
                Do_Save_an_img(figure_Wave,Save_img,type_save_img) %=====save as img======
end