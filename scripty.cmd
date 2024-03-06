@echo off
chcp 65001
setlocal enabledelayedexpansion
:: variables

:: -- color variables --
set brightred=[40;91m
set brightyellow=[40;93m
set brightgreen=[40;92m
set brightblue=[40;94m
set brightpurple=[40;95m
set brightcyan=[40;96m
set brightwhite=[40;97m
set darkred=[40;31m
set darkyellow=[40;33m
set darkgreen=[40;32m
set darkblue=[40;34m
set darkpurple=[40;35m
set darkcyan=[40;36m
set darkwhite=[40;37m
:: -- ide colors --
set textcolor=%brightwhite%
set columnclr=%brightgreen%

:: -- link variables --
::
::
::                             _          __                       _ _  __ _           _   _                             
::               ___ _ __   __| |   ___  / _|  _ __ ___   ___   __| (_)/ _(_) ___ __ _| |_(_) ___  _ __  ___             
::  _____ _____ / _ \ '_ \ / _` |  / _ \| |_  | '_ ` _ \ / _ \ / _` | | |_| |/ __/ _` | __| |/ _ \| '_ \/ __|_____ _____ 
:: |_____|_____|  __/ | | | (_| | | (_) |  _| | | | | | | (_) | (_| | |  _| | (_| (_| | |_| | (_) | | | \__ \_____|_____|
::              \___|_| |_|\__,_|  \___/|_|   |_| |_| |_|\___/ \__,_|_|_| |_|\___\__,_|\__|_|\___/|_| |_|___/            
::                                                                                                                       
::
::
:: if you move forward please read,
::  changing code beyond this line may change the way the code interacts and may produce improperfunction
::  please proceed with caution
:: color bars
set brightcolortest=%brightred%━━%brightyellow%━━%brightgreen%━━%brightblue%━━%brightpurple%━━%brightcyan%━━%brightwhite%━━
set darkcolortest=%darkred%━━%darkyellow%━━%darkgreen%━━%darkblue%━━%darkpurple%━━%darkcyan%━━%darkwhite%━━
:: scripty file interaction
if exist plant.scripty goto plant
:startscreen
REM Clear any existing variables
set "file_count=0"

REM Get the files with specified extensions in the directory
for /f "tokens=*" %%a in ('dir /b /a-d *.cmd *.bat *.py *.txt *.scripty') do (
    set /a file_count+=1
    set "file_!file_count!=%%a"
)

REM Display the file names
for /l %%i in (1, 1, %file_count%) do (
    echo - !file_%%i!
)

REM Print the first file name outside the loop
if defined file_1 (
    echo First file assigned to %file_1% is: %file_1%
)
REM Print %file1% outside the block

cls
echo %brightwhite%
echo                                                                              │
echo                                                                              │
echo                                                                              │
echo                      Scripty Version %brightgreen%2024.01%brightwhite%                                 │           Files In Directory
echo                       %brightgreen%http://surl.li/rgntv%brightwhite%                                   │           %brightgreen%------------------%brightwhite%
echo                                                                              │            → %file_1%
echo                   /commands - switches to commands                           │            → %file_2%
echo                   /code     - switches to code                               │            → %file_3%
echo                   /console  - switches to console                            │            → %file_4%
echo                   /help     - switches to help menu                          │            → %file_5%
echo                                                                              │            → %file_6%
echo                                                                              │            → %file_7%
echo                                                                              │            → %file_8%
echo                                                                              │            → %file_9%
echo                                                                              │            → %file_10%
echo                                                                              │
set "filenumber=1"
set /p "filename=Filename→ "
if not defined filename goto namefile
goto cont
:namefile
if not exist "untitledfile_!filenumber!.bat" (
    set "filename=untitledfile_!filenumber!.bat"
) else (
    set /a "filenumber+=1"
    goto namefile
)

:cont
cls
echo ~~~│ %CD%\%brightgreen%%filename%%brightwhite% 
set number=0
:numberline
set previousline=%linecommand%
set /a "number+=1"
set "padded_number=00%number%"
set "padded_number=!padded_number:~-3!"
set /p "linecommand=%columnclr%!padded_number![40;97m│%textcolor%"
::shortcuts
if "%linecommand%" == ";q" goto end
if "%linecommand%" == ";d" goto dellast
if "%linecommand%" == ";s" start %filename% && goto numberline
:: full commands
if "%linecommand%" == "/help" goto help
if "%linecommand%" == "/commands" goto commands
echo %linecommand%>>%filename%
goto numberline

:end
echo  %brightgreen%~%brightwhite% │ GoodBye!
timeout 2 >nul
exit

:dellast
rem Check if the file exists
if not exist "%filename%" (
    echo File "%filename%" does not exist.
    exit /b
)

rem Read the file line by line and store them in an array
set "count=0"
for /f "delims=" %%a in (%filename%) do (
    set /a count+=1
    set "line[!count!]=%%a"
)

rem Overwrite the original file with the lines except the last one
(for /l %%i in (1,1,%count%) do (
    if %%i neq %count% echo !line[%%i]!
)) > "%filename%.temp"

rem Replace the original file with the modified one
move /y "%filename%.temp" "%filename%" > nul
echo Removed "%previousline%"
goto numberline

:commands
echo  %brightgreen%~%brightwhite% │ Please Enter A Command.
echo  %brightgreen%~%brightwhite% │  -"/code" to return
set /p commands=INP│ 
:: commands
if "%commands%" =="/code" goto numberline
if "%commands%" =="/plantfile" goto plant
if "%commands%" =="/editfile" goto editfile
goto commands

:help
echo  %brightgreen%~%brightwhite% │ %brightgreen%~~~ GENERAL ~~~%brightwhite%
echo  %brightgreen%~%brightwhite% │ "/commands" :--: allows user to enter commands
echo  %brightgreen%~%brightwhite% │ "/code" :------: allows user to enter code
echo  %brightgreen%~%brightwhite% │ "/console" :---: allows user to access console
echo  %brightgreen%~%brightwhite% │ "/help" :------: allows user to view help
echo  %brightgreen%~%brightwhite% │ %brightgreen%~~~ COMMANDS ~~~%brightwhite%
echo  %brightgreen%~%brightwhite% │ "/plantfile" :-: plants this file into [C:\users\%username%] for easy access
echo  %brightgreen%~%brightwhite% │ "/editfile" :--: edit this file to alter settings
echo  %brightgreen%~%brightwhite% │ %brightgreen%~~~ SHORTCUTS ~~~%brightwhite%
echo  %brightgreen%~%brightwhite% │ ";q" :---------: exits file
echo  %brightgreen%~%brightwhite% │ ";s" :---------: starts current file
echo  %brightgreen%~%brightwhite% │ ";d" :---------: deletes last line
goto numberline

:plant
if exist plant.scripty del plant.scripty
echo x=msgbox("Scripty Has Been Planted Into [C:\users\%username%]. Access Scripty in CMD By Typing Scripty" ,64, "Plant Successful!") >> msgbox.vbs
start msgbox.vbs
timeout 1 >nul
del msgbox.vbs
move scripty.cmd C:\users\%username%
goto startscreen

:editfile
md backup
copy scripty.cmd backup
rename scripty.cmd scripty.txt
start scripty.txt
goto startscreen
