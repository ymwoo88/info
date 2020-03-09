# Tomcat catalina.out 파일을 날짜별로 더 쉽게 저장하도록 설정하는 방법

기존에 Apache httpd's rotatelogs을 이용할 경우
1.	추가로 Apache를 설치해야 하고 
2.	Tomcat의 catalina.sh를 수정해야 했습니다.
3.	물론 수정한 후 Tomcat 재기동도 해야합니다.

이번 방법을 이용하면 위에 3가지를 안 해도 됩니다.

1.	/etc/logrotate.d 디렉토리 안에 아래의 파일을 생성(root 계정만 가능)  
```
$ cd /etc/logrotate.d
$ vi  tomcat
```

```
${CATALINA_HOME}/logs/catalina.out {
copytruncate
daily
rotate 30
compress
missingok
notifempty
dateext
}
```

로그파일 순환 테스트  
`$logrotate -f /etc/logrotate.d/tomcat `


위와 같이 파일만 생성하면 매일 지난 로그파일은 날짜별로 gzip으로 압축해서 변환하며
이 로그 파일은 30개만큼만 저장됩니다.

참고 : http://www.mimul.com/pebble/default/2009/12/27/1261911840000.html
https://enterkey.tistory.com/396

이렇게 하면 Tomcat 설정을 수정하거나 재기동 할 필요가 없습니다.
Apache rotatelogs 보다 더 쉽고 기능도 다양합니다.

# 내장톰캣
일반적으로 war로 프로세스 기동 할 때 쓰이는 간단한 스크립트 구문 이다
```
[eams@attend_was1 bin]$ cat run.sh
#!/bin/sh

PROFILE=prod
FILENAME=adms_tcp.war
BASEPATH=/home/eams/adms_tcp

DATE=`date +'%Y%m%d_%H%M%S'`
EXECUTABLE=`nohup java -server -Dfile.encoding=utf-8 -jar "$BASEPATH"/lib/"$FILENAME" --spring.profiles.active="$PROFILE" > /log/eams/adms/tomcat/console.out &`

eval exec "$EXECUTABLE"
```

```
[eams@attend_was1 bin]$ cat stop.sh
ps ax | grep java | grep adms_tcp.war | awk '{print $1}' | xargs kill -15

```
