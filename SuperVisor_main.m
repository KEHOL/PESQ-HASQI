clear all
%to compilate anything as possible to look:
%most valued configuration:

%in_setted_data.base_file_name=
%in_setted_data.base_file_type=

%in_setted_data.base_data_size=20;
in_setted_data.base_trainning=2;
in_setted_data.base_repeat_filtration=0;
%in_setted_data.base_base_trainning_zone=360;
%in_setted_data.base_adaption=300;

in_setted_data.base_repeat_filtration=0;

in_setted_data.base_Save_img=1;
%in_setted_data.base_type_save_img=

%in_setted_data.base_load_weight=
%in_setted_data.base_save_weight=

%in_setted_data.base_noise_type=
in_setted_data.base_SNRdb=0

in_setted_data.base_filtration_type="LMS"

%in_setted_data.base_value_filtration_for_LMS=
%in_setted_data.base_value_filtration_for_RLS=
%in_setted_data.base_value_filtration_for_Volterrs_MLS=
%in_setted_data.base_value_filtration_for_Blind_Adapt_by_Sato=
%in_setted_data.base_value_filtration_for_Blind_Adapt_by_Godart=
%in_setted_data.base_value_filtration_for_Kalmans=

in_setted_data.base_noise_type='speaking strong';

in_setted_data.base_do_look_clear_wave=0;
in_setted_data.base_do_look_noised_wave=0;
in_setted_data.base_do_look_filtered_wave=0;

in_setted_data.base_do_export=0
%in_setted_data.base_file_type_out=

data_change=1;
set_dif=1;
set_big=2;
i=1;
times_samples=1000;

data_change_after=data_change;

    in_setted_data.base_adaption=round(data_change_after);
    in_setted_data.base_trainning_zone=round(data_change_after);
%in_setted_data.base_data_size=data_change_after;
%in_setted_data.base_value_filtration_for_LMS=data_change_after;
%in_setted_data.base_trainning=round(data_change_after);

exit_data=main(in_setted_data);
timeS=tic;
array_long=[];
best_data=exit_data.score_SQ_PESQ_filtered(1)-exit_data.score_SQ_PESQ_with_noise(1);
best_value=data_change_after(1);
 array_long(1,i)=exit_data.score_SQ_PESQ_with_noise(1);

 shift_zero=1;
 shift=shift_zero;
 times=1;
 times_repeat=0;
 save_before_data=-4;
while exit_data.score_SQ_PESQ_with_noise(1) > exit_data.score_SQ_PESQ_filtered(1)/set_big
    in_setted_data.base_do_look_clear_wave=0;
    i=i+1;
        if i<times_samples
    else
        break;
    end
    %======================================================================
        if (exit_data.score_SQ_PESQ_filtered(1)-exit_data.score_SQ_PESQ_with_noise(1))-save_before_data == 0 
        times_repeat = times_repeat+1;
        if times_repeat == 2
            break;
        end
    end

    if (exit_data.score_SQ_PESQ_filtered(1)-exit_data.score_SQ_PESQ_with_noise(1))-save_before_data>0 
        shift=abs(shift)+shift_zero*times;
        times=times+1;
         else 
        shift=-abs(shift)/1.4;
        times=0;
    end
    data_change_after=data_change_after+shift*set_dif;
    %=========================automation_section===========================
            %set bellow data change off
    %in_setted_data.base_data_size=round(data_change_after);


    %in_setted_data.base_trainning=round(data_change_after);
    %in_setted_data.base_adaption=round(data_change_after);
    in_setted_data.base_trainning_zone=round(data_change_after);
    in_setted_data.base_repeat_filtration=round(data_change_after);

    %in_setted_data.base_value_filtration_for_LMS=data_change_after;
    %in_setted_data.base_value_filtration_for_RLS=data_change_after;
    %in_setted_data.base_value_filtration_for_Kalmans=[1,round(data_change_after)];
    %================================set_data==============================
    save_before_data=exit_data.score_SQ_PESQ_filtered(1)-exit_data.score_SQ_PESQ_with_noise(1);
    exit_data=main(in_setted_data);
    TimeSt=toc(timeS);
    disp(append(num2str(TimeSt),' in seconds worked ',num2str(data_change_after),' is current number'))
    
    array_long(1,i)=exit_data.score_SQ_PESQ_filtered(1)-exit_data.score_SQ_PESQ_with_noise(1);
    array_long(2,i)=data_change_after;
    if exit_data.score_SQ_PESQ_filtered(1)-exit_data.score_SQ_PESQ_with_noise(1) > best_data
        best_data=exit_data.score_SQ_PESQ_filtered(1)-exit_data.score_SQ_PESQ_with_noise(1);
        best_value=data_change_after;
    end
array_long=single(array_long);
exit_table=struct('score_SQ_delta',{array_long(1,:)'},'current_value',{array_long(2,:)'},'best_delta',{(ones(1,numel(array_long(1,:))))'*best_data},'by_value',{(ones(1,numel(array_long(1,:))))'*best_value});
writetable(struct2table(exit_table),'exit_data.xlsx', 'sheet',1,'Range','A1');


end
clear all