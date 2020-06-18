@ECHO iisRestart 192.168.11.148
wmic process where "name = 'java.exe' and commandline like '%%webtlv%%'" get CommandLine 
timeout /t 1000