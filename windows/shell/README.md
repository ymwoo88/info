# bat안에서 다른 bat을 호출 할 때 사용하는 팁
https://m.blog.naver.com/PostView.nhn?blogId=dhcho347&logNo=220038613759&proxyReferer=https:%2F%2Fwww.google.com%2F

# test.bat
## 윈도우에서 프로세스가 실행되고 있는지 감지하여 죽어있으면 해당 프로세스를 실행하도록 하는 쉘 
 goto 부분을 해석하면 해당 구분이 왔을 때 지정 된 코드로 이동하도록 한다.
```
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
```
