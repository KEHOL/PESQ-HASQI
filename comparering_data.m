function compared_data = comparering_data(setted_data_struct,base_data_struct)
setted_fields_data = fieldnames(setted_data_struct);
compared_data = base_data_struct;
    for i = 1:length(setted_fields_data)
        data=string(setted_fields_data(i));
        if isfield(setted_data_struct,data); compared_data.(data) = setted_data_struct.(data);end;
    end
end