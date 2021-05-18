@echo off
cls
echo.
echo Build Atari Jaguar libsmacker's test application
echo.

if %1.==. goto usage
if %1.==HELP. goto usage
if %2.==. goto builwo2
if %2.==ALL. goto ALL
if %3.==. goto builwo3
make -f Makefile %1 cmd=%1 env=%2 support=%3
goto end

:ALL
if %3.==. goto ALLwo3
:ALLw3
make -f Makefile %1 cmd=%1 env=Debug support=%3
make -f Makefile %1 cmd=%1 env=Profile support=%3
make -f Makefile %1 cmd=%1 env=Release support=%3
goto end
:ALLwo3
make -f Makefile %1 cmd=%1 env=Debug support=NULL
make -f Makefile %1 cmd=%1 env=Profile support=NULL
make -f Makefile %1 cmd=%1 env=Release support=NULL
goto end

:builwo2
make -f Makefile %1 cmd=%1 env=Debug support=NULL
goto end

:builwo3
make -f Makefile %1 cmd=%1 env=%2 support=NULL
goto end

:usage
echo Usage:
echo:build HELP
echo -----
echo "build <all | clean[_...] | compile[_...] | config[_...] | HELP | library[_...] | makedirs | mkdir_[...] | rebuild | report_[...] | reports> <ALL | Debug | Profile | Release> <SKUNKBOARD | NULL>"
echo -----
echo Debug (default)
echo NULL (default)
if %1.==HELP. goto HELP
goto end

:HELP
echo -----
echo all : incremental build source
echo -----
echo clean : clean all
echo -----
echo clean[_...] can be empty or be completed with:
echo d : remove the *.d files from the project
echo libs : remove the libraries (images included)
echo obj : remove the *.o files from the project (Runtime not included)
echo reports : remove the dump and report text files
echo s : remove the *.s files (from C compilation in case of -S option has been set)
echo su : remove the *.su files from the project
echo -----
echo compile : compile all
echo -----
echo compile[_...] can be empty or be completed with:
echo libsmacker : smacker libraries compilation
echo -----
echo config : display the makefile configuration
echo -----
echo config[_...] can be empty or be completed with:
echo command : display command configuration
echo generic : display generic configuration
echo -----
echo HELP : display this help page
echo -----
echo makedirs : create the necessary directories
echo -----
echo mkdir_[...] must be completed with:
echo d : create d's directories
echo obj : create obj's directories
echo reports : create reports's directories
echo s : create s's directories
echo su : create su's directories
echo -----
echo rebuild : clean, rebuild sources to make a fresh new build
echo -----
echo report_[...] must be completed with:
echo stack : generate a stack usage report based on generated *.su files
echo -----
echo reports : generate all reports available
goto end

:end
echo.
@echo on
