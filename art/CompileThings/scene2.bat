@Echo off
Echo FNF Compiler by: Merphi

:choice2
Echo.
Echo Choose compile type (build)
Echo.
Echo 1 - Windows x64
Echo 2 - Windows x32
Echo 3 - Android
Echo 4 - HTML
Echo 5 - Back
 
echo.
Set /p choice="Choice: "
if not defined choice goto choice2
if "%choice%"=="1" (lime build windows -release)
if "%choice%"=="2" (lime build windows -32 -release)
if "%choice%"=="3" (lime build android -release)
if "%choice%"=="4" (lime build html5 -release)
if "%choice%"=="5" (
    start art\CompileThings\scene1.bat
    exit
    )
Echo.
Echo.
Echo.
goto choice2