function output_noised = noise_add(data_input,SNRdb,type,timedelay,input_Fs)
addpath('Variance_noises\');



speaking_strong='beach-bar-ambient-16957'; speaking_strong_type='.mp3';
speaking_calm='people-speaking-french-51882'; speaking_calm_type='.mp3';
dog_and_people='dog-and-people-33723'; dog_and_people_type='.mp3';
building_side='demolition-building-side-61383'; building_side_type='.mp3';
highway_side='autobahn-symphonie-fahrzeuggerausche-und-verkehrslarm-173757'; highway_side_type='.mp3';
subway_arrive='subway-train-arrive-69678'; subway_arrive_type='.mp3';
% \/ there can add self noise or tone \/
self='self_noise'; self_noise_type='.wav';



switch type
    case 'gaussian'; noise_signal = awgn(zeros(size(data_input)),0);
    case 'rand'; noise_signal = (rand(size(data_input))-0.5)*2;
    % \/ used https://pixabay.com - the base of hight roally free audio \/
    case 'speaking strong';[noise_unResampled,fs]=import_file(speaking_strong,speaking_strong_type);noise_unResampled = circshift(noise_unResampled,-timedelay*fs);noise_Resampled=resample(noise_unResampled,input_Fs,fs); noise_signal = audio_normalization(create_same_length_an_data(noise_Resampled,data_input));
    case 'speaking calm';[noise_unResampled,fs]=import_file(speaking_calm,speaking_calm_type);noise_unResampled = circshift(noise_unResampled,-timedelay*fs);noise_Resampled=resample(noise_unResampled,input_Fs,fs); noise_signal = audio_normalization(create_same_length_an_data(noise_Resampled,data_input));
    case 'dog and people';[noise_unResampled,fs]=import_file(dog_and_people,dog_and_people_type);noise_unResampled = circshift(noise_unResampled,-timedelay*fs);noise_Resampled=resample(noise_unResampled,input_Fs,fs); noise_signal = audio_normalization(create_same_length_an_data(noise_Resampled,data_input));
    case 'building side';[noise_unResampled,fs]=import_file(building_side,building_side_type);noise_unResampled = circshift(noise_unResampled,-timedelay*fs);noise_Resampled=resample(noise_unResampled,input_Fs,fs); noise_signal = audio_normalization(create_same_length_an_data(noise_Resampled,data_input));
    case 'highway side';[noise_unResampled,fs]=import_file(highway_side,highway_side_type);noise_unResampled = circshift(noise_unResampled,-timedelay*fs);noise_Resampled=resample(noise_unResampled,input_Fs,fs); noise_signal = audio_normalization(create_same_length_an_data(noise_Resampled,data_input));
    case 'subway arrive';[noise_unResampled,fs]=import_file(subway_arrive,subway_arrive_type);noise_unResampled = circshift(noise_unResampled,-timedelay*fs);noise_Resampled=resample(noise_unResampled,input_Fs,fs); noise_signal = audio_normalization(create_same_length_an_data(noise_Resampled,data_input));
    %-------------------------------------------------------------------
    case 'self noise';[noise_unResampled,fs]=import_file(self,self_noise_type);noise_Resampled=resample(noise_unResampled,input_Fs,fs); noise_signal = audio_normalization(create_same_length_an_data(noise_Resampled,data_input));
    %-------------------------------------------------------------------
    otherwise
        noise_signal=zeros(size(data_input));
end
%calculation adding noise:
sig_power = 1; %linier use an default
%sig_power = sum(abs(data_input(:)).^2)/numel(data_input); %measured 
switch type 
    case 'gaussian';sig_power = 1;scalling=sqrt(sig_power/10^(SNRdb/10));
    case 'rand';sig_power = 1;scalling=sqrt(sig_power/10^(SNRdb/10));
    otherwise
%noise_power = 1; %linier use an default
noise_power = sum(abs(noise_signal(:)).^2)/numel(noise_signal); %measured 

%combining the noise signal with input 
scalling = sqrt(sig_power/(10^(SNRdb/10))/noise_power);
    end
%combining the noise signal with input 
output_noised = data_input + scalling*noise_signal;
output_noised = audio_normalization (output_noised);
end

function OutData = create_same_length_an_data(Indata,InDesired)
[rows,colsImportant]=size(InDesired); [rowsData,cols]=size(Indata); InResided=Indata;
while rowsData<rows
InResided=[InResided;InResided]; [rowsData,cols]=size(InResided);
end
OutData = InResided(1:rows, colsImportant);
end

function output_data = audio_normalization(input_data,Desired_Amplitude)
%if no Desired amlitude, than use default value Desired_Amplitude=1 
if ~exist('Desired_Amplitude') || Desired_Amplitude >1 || Desired_Amplitude < 0; Desired_Amplitude=1 ; else;end; 
output_data=input_data*(Desired_Amplitude/max(abs(input_data)));
end