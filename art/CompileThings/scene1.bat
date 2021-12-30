@Echo off
Echo FNF Compiler by: Merphi

:choice1
Echo.
Echo Compile?
Echo.
Echo 1 - Compile
Echo 2 - Choose the type
Echo 3 - Exit
 
echo.
Set /p choice="Choice: "
if not defined choice goto choice1
if "%choice%"=="1" (lime test windows)
if "%choice%"=="2" (
    start art\CompileThings\scene3.bat
    exit
    )
if "%choice%"=="3" (exit)
Echo.
Echo.
Echo.
goto choice1