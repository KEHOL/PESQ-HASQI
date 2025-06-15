function Do_Save_an_img(Figure_what_need_to_save, Actually_need,Type_an_img)
global Iteration_num
    switch Actually_need %check, to save
        case 1
            Path_To_Save='Save_img';
            if ~isfolder(Path_To_Save)
                mkdir(Path_To_Save); %create new folder
            disp('New folder to save imgs has been created');else;end
            Iteration_num=Iteration_num+1;
saveas(Figure_what_need_to_save,append(Path_To_Save,"\",num2str(year(datetime('now'))),"_",num2str(month(datetime('now'))),"_",num2str(day(datetime('now'))),"_","Ex",num2str(Iteration_num),"_",Figure_what_need_to_save.Name,Type_an_img));
   
            otherwise
    end
end


