function listen_audio(signal_listen,Fs_listen)
sound(signal_listen,Fs_listen);
        timeout = 5; %seconds
start=tic;
while true
        continuedTime = toc(start);
        if continuedTime > timeout
          break;
        end
            pause(0.1);
end

  clear sound;

end
