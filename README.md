To start work with filter u have be able to use:

main.m - to fast check configuration;
User_main.m - to check non stapable array of possible configuration with table export to Excel;
SuperVisor_main.m to fast search need configuration by changing it fast as possible and checks by score_SQ stops while change less than 1e-3.

The configuration to set be ablied by base_data_saved.m or same as an User_main.m exercise

To have stably working PESQ measurements MinGW64 Compilier ideally from matlab
https://www.mathworks.com/matlabcentral/fileexchange/52848-matlab-support-for-mingw-w64-c-c-fortran-compiler

,eather by installing through msys64
https://packages.msys2.org/packages/mingw-w64-x86_64-gcc-fortran

If had'n the MinGW64 Compilier, set in base_data_saved.m and User_main.m base_speech_measuring= "HAAQI" instead "Duo" to set Score_SQ getging only from HAAQI mesurements
