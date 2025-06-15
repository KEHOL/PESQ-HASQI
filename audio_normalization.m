function output_data = audio_normalization(input_data,Desired_Amplitude)
if ~exist('Desired_Amplitude') || Desired_Amplitude >1 || Desired_Amplitude < 0; Desired_Amplitude=1 ; else;end; 
output_data=input_data*(Desired_Amplitude/max(abs(input_data)));
end