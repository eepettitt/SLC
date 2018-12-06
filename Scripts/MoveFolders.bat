:: MoveFolders - Erik Pettitt (dirkalmighty@gmail.com), 2018
:: Move all folders starting with P or 0 in the current folder to their -Scott part folder locations

@echo off
setlocal enabledelayedexpansion
set maindest=G:\Solid Works Drawing Files\-SCOTT
for /f %%c in ('dir /a:d /b') do (
	set check=0
	set c1=%%c
	set c1=!c1:~0,1!
	if !c1!==P set check=1
	if !c1!==0 set check=1
	if !check!==1 (
		for /f "delims=- tokens=1,2" %%a in ("%%c") do (
			set dest=!maindest!\%%a\%%b
			if %%a==P9 (
				set b1=%%b
				set b1=!b1:~0,1!
				set b2=%%b
				set b2=!b2:~0,2!
			)
			if %%a==00 set dest=!maindest!\00 - Cloth Shade
			if %%a==0 set dest=!maindest!\0 - Glass Shade
			if %%a==01 set dest=!maindest!\01 - Acrylic Shade
			if %%a==02 set dest=!maindest!\02 - Flat Glass
			if !b1!==B set dest=!maindest!\%%a\!b1!
			if !b2!==BP set dest=!maindest!\%%a\!b2!
			if !b2!==12 set dest=!maindest!\%%a\!b2!
			if not exist "!dest!" mkdir "!dest!"
			if not exist "!dest!"\%%c (
				move "%~dp0\%%c" "!dest!" >nul
				echo Moved %%c to !dest!\
			) else (
				echo Cannot overwrite %%c at !dest!\
			)
		)
	)
)
if %check%==0 echo No part folders found
pause