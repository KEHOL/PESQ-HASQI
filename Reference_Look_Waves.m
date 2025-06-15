function figure_Wave = Reference_Look_Waves(signal_to_Wave,Reference_signal_to_wave,FS_to_Wave,name_for_Wave)
    switch FS_to_Wave
        case 1; Name_of_Samples = "Samples";
        otherwise; Name_of_Samples = "Seconds";
    end
    
figure_Wave = figure('name',append(name_for_Wave," ","in total length ",num2str(length(signal_to_Wave)/FS_to_Wave)," ",Name_of_Samples));
set(gcf, 'WindowState', 'maximized');
plot((0:length(signal_to_Wave)-1)/FS_to_Wave,signal_to_Wave);
hold on
plot((0:length(Reference_signal_to_wave)-1)/FS_to_Wave,Reference_signal_to_wave,'color',[1,0.5,0]);
title(append(name_for_Wave," ","in ",Name_of_Samples));
xlabel(Name_of_Samples)
ylabel("Amplitude")
grid on
                                            %=== Global_export ===
                                    global Save_img; global type_save_img;
                                            %=====================
                Do_Save_an_img(figure_Wave,Save_img,type_save_img) %=====save as img======
end