@echo off
setlocal enabledelayedexpansion
for /f %%c in ('dir /a:d /b') do (
	echo %%c
	for /f "delims=- tokens=1-2" %%a in ("%%c") do (
		set dest=G:\Macros\%%a\%%b
		echo !dest!
		echo %%a
		echo a
		echo %%b
		echo b
		rem if %%a=="00" do (
		rem	echo %%a
		rem	)
		if not exist !dest! mkdir !dest!
		rem move "%~dp0\%%c" "G:\Macros\%%a\%%b"
		)
	)
pause