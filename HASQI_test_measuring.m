function score_output = HASQI_test_measuring(Data_input,Data_reference,fs_used,mode)

%write mode 'narrowband' or 'wideband' or both

dir_before = pwd;
Path_To_work='haaqi-master-peace'
            if isfolder(Path_To_work)
cd(append(Path_To_work,'\')) %change directory into working place

%used HASQI https://ieeexplore.ieee.org/document/6082343/
%no opened to use free without license
%have captured from https://github.com/dhimnsen/OpenSpeechPlatform-UCSD/tree/master/matlab/HASPI_HASQI

score_output=[];
switch lower(mode)
    case '1'
score_output = HASQI_v2(Data_input,fs_used,Data_reference,fs_used,[1,2,3,4,5,6],1);
    case '2'
score_output = HASQI_v2(Data_input,fs_used,Data_reference,fs_used,[1,2,3,4,5,6],2);
    case 'both'
score_output(1) = HASQI_v2(Data_input,fs_used,Data_reference,fs_used,[1,2,3,4,5,6],1);
score_output(2) = HASQI_v2(Data_input,fs_used,Data_reference,fs_used,[1,2,3,4,5,6],2);
    otherwise
        error(['''' mode ''' is not a recognised ''mode'' value.'])
end   





  else
            disp('Sorry but u not have produced the HASQI module');
            score_output=[];
switch lower(mode)
    case '1'
score_output = 0;
    case '2'
score_output = 0;
    case 'both'
score_output(1) = 0;
score_output(2) = 0;
    otherwise
        error(['''' mode ''' is not a recognised ''mode'' value.'])
end   

end
cd(dir_before); %get back after all iterations
for i=1:2
if isnan(score_output(i)) 
score_output(i)=-1;else;end
end
end