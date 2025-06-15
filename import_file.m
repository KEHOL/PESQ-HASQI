function [Signal_import,FS_import] = import_file(name_file_to_import,type)
                            %===global_import===
                            global Iteration_num
                            %===================
                            if isempty(Iteration_num);Iteration_num = -1;else;end;
                            
                            %===================
disp('Importing')
% to import need name + type of information
name_file_to_import=append(name_file_to_import,type); 
[Signal_import,FS_import] = audioread(name_file_to_import);
end