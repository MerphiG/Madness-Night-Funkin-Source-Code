@Echo off
Echo FNF Compiler by: Merphi

:choice4
Echo.
Echo Choose compile type (test)
Echo.
Echo 1 - Windows x64
Echo 2 - Windows x32
Echo 3 - Android
Echo 4 - HTML
Echo 5 - Back
 
echo.
Set /p choice="Choice: "
if not defined choice goto choice4
if "%choice%"=="1" (lime test windows -release)
if "%choice%"=="2" (lime test windows -32 -release)
if "%choice%"=="3" (lime test android -release)
if "%choice%"=="4" (lime test html5 -release)
if "%choice%"=="5" (
    start art\CompileThings\scene1.bat
    exit
    )
Echo.
Echo.
Echo.
goto choice4