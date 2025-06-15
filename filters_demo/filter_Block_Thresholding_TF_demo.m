function output_signal = filter_Block_Thresholding_TF_demo(Data_input,Desired_signal,Fs,Block_size,Length)

 %=== Global_export ===
  global trainning;
  global load_weight;
  global save_weight;
 %=====================

adaption=numel(Data_input);

short_cut=512*16*2;


[input.Amlitude,input.Freq,input.Time] = spectrogram(Data_input,round(short_cut/2),round(short_cut/2-1),[],Fs,"yaxis");
[Desired.Amlitude,Desired.Freq,Desired.Time] = spectrogram(Desired_signal,round(short_cut/2),round(short_cut/2-1),[],Fs,"yaxis");
%we had the up * freq label, also we had the desired col label

%we can repsictate like that:
%/\ freq
%|
%|     +---+
%|     |   |
%|     +---+
%|
%|
%|
%|_______________________>time


F_zone=[0,0.2]*1000;

T_zone=[0.1,0.2];

Est = zeros(adaption,1);
for T_square = 1:1:numel(Data_input)
                if(T_zone(1) < T_square/Fs && T_square/Fs < T_zone(2))
    for F_square = 1:1:Fs/2
    for F_setted_by_now = 1:1:numel(input.Freq)


%from input.Amlitude we gathering Q and I data where we can get the phase
%and amplitude to clear the F and T zone satted
    if(T_zone(1) < T_square/Fs && T_square/Fs < T_zone(2))

            if(F_zone(1) < F_square && F_square < F_zone(2) && F_zone(1) < input.Freq(F_setted_by_now) && input.Freq(F_setted_by_now) < F_zone(2))

    Est(T_square)=Est(T_square)+abs(input.Amlitude(F_setted_by_now,round(T_square*numel(input.Time)/numel(Data_input))))*cos(T_square*F_square*2*pi+phase(input.Amlitude(F_setted_by_now,round(T_square*numel(input.Time)/numel(Data_input)))));
    %Est(T_square)=Est(T_square)+real(input.Amlitude(F_setted_by_now,round(T_square*numel(input.Time)/numel(Data_input))));



end
            end




    end
    end
                 end
end
output_signal= Data_input - Est;   

end

function OutData = create_same_length_an_data(Indata,InDesired)
[rows,cols]=size(InDesired);
[rowsData,colsData]=size(Indata);
InResided=Indata;

OutData = InResided(rowsData, 1:rows);
end