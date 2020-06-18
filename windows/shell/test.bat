@echo off

rem 명령어 실행 후 출력되는 문자열 저장
set "getclip=wmic process where "name = 'java.exe' and commandline like '%%webtlv%%'" get CommandLine"

rem 출력된 문자열을 1줄씩 비교하여 원하는 문자열이 있는지 검색
for /f "delims=" %%l in ('%getclip% ^| findstr /n "^"') do (
	setlocal enabledelayedexpansion

	rem 출력된 문자열 1줄을 저장
	set "line=%%l" & set "line=!line:*:=!"
	rem echo(!line!
	
	rem 문자열 검색
	echo "!line!" | find "java  -jar ./webtlv-0.0.1-SNAPSHOT.war" > nul
	if errorlevel 1 (
		echo not found > nul
	) else (
		rem 찾으면  for문 종료
		rem echo found
		goto EXIT
	)
	endlocal
)

call startWebTlv.bat
goto EXIT

:EXIT
