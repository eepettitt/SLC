:: CheckFlat - Erik Pettitt (dirkalmighty@gmail.com), 2017
:: Type a full or partial part number to display all matching files in the flat pattern folder (Z:\)

@echo off & setlocal
:begin
set /p part=Enter part number: 
if exist Z:\*%part%*.DXF (dir /a:-d /b Z:\*%part%*) else (echo No Flat)
echo:
goto begin
pause