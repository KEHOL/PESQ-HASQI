function export_file(name_file_to_export,signal_Export,Fs_export,add_name,type_out)
disp('Exporting')
% to Export need name + second name + type of information
name_file_edited=append(name_file_to_export,add_name,type_out);
audiowrite(name_file_edited,signal_Export,Fs_export);
end