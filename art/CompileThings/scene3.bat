@Echo off
Echo FNF Compiler by: Merphi

:choice3
Echo.
Echo Build - The game will just compile into a folder
Echo Test - The game will compile into a folder and open
Echo.
Echo 1 - Build
Echo 2 - Test
 
echo.
Set /p choice="Choice: "
if not defined choice goto choice3
if "%choice%"=="1" (
    start art\CompileThings\scene2.bat
    exit
    )
if "%choice%"=="2" (
    start art\CompileThings\scene4.bat
    exit
    )
Echo.
Echo.
Echo.
goto choice3