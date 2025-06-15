%% compile and test file

fprintf('start compiling ...\n');

mex *.c -output ./bin/PESQ_MEX

addpath('./bin');

fprintf('\n ======================================= \n source codes are compiled successfully.\n');

fprintf('start testing\n');

[ref, ~] = audioread('./audio/O-Zone - Dragostea Din Tei Speech Greatings.wav');
[deg, fs] = audioread('./audio/O-Zone - Dragostea Din Tei Speech Greatings.wav');
fs=16000
fprintf('testing narrowband.\n');
pesq_mex(ref, deg, fs, 'narrowband')


fprintf('testing wideband.\n');
disp(pesq_mex(ref, deg, fs, 'wideband'));

fprintf('testing both.\n');
disp(pesq_mex(ref, deg, fs, 'both'));

fprintf('done.\n');



