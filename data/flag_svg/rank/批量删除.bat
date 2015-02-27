@echo off & setlocal enabledelayedexpansion

set "str_del=-01"

for /f "delims=" %%i in ('dir /s/b') do (
 set "foo=%%~nxi"
 set foo=!foo:%str_del%=!
 ren "%%~i" "!foo!"
)
exit