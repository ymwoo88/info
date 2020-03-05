# logback.xml 설정 예제
```
<?xml version="1.0" encoding="UTF-8"?>
<configuration scan="true" scanPeriod="30 seconds">
	<appender name="consoleAppender" class="ch.qos.logback.core.ConsoleAppender">
		<encoder>
			<Pattern>.%d{HH:mm:ss.SSS} %X{client-ip} [%thread] %-5level %logger{36} - %msg %n
			</Pattern>
		</encoder>
	</appender>

  <appender name="dailyRollingFileAppender1" class="ch.qos.logback.core.rolling.RollingFileAppender">
    <File>D:\88_ymwoo${HOSTNAME}.test1.log</File>
    <rollingPolicy class="ch.qos.logback.core.rolling.TimeBasedRollingPolicy">
        <!-- daily rollover -->
      <FileNamePattern>D:\88_ymwoo${HOSTNAME}.test1.%d{yyyy-MM-dd}.log.zip</FileNamePattern>

      <!-- keep 90 days' worth of history -->
      <maxHistory>90</maxHistory>
    </rollingPolicy>

    <encoder>
      <Pattern>.%d{HH:mm:ss.SSS} %X{client-ip} [%thread] %-5level %logger{36} - %msg %n</Pattern>
    </encoder> 	    
  </appender>
	
  <appender name="dailyRollingFileAppender2" class="ch.qos.logback.core.rolling.RollingFileAppender">
    <File>D:\88_ymwoo${HOSTNAME}.test2.log</File>
    <rollingPolicy class="ch.qos.logback.core.rolling.TimeBasedRollingPolicy">
        <!-- daily rollover -->
      <FileNamePattern>D:\88_ymwoo${HOSTNAME}.test2.%d{yyyy-MM-dd}.log.zip</FileNamePattern>

      <!-- keep 90 days' worth of history -->
      <maxHistory>90</maxHistory>
    </rollingPolicy>

    <encoder>
      <Pattern>.%d{HH:mm:ss.SSS} %X{client-ip} [%thread] %-5level %logger{36} - %msg %n</Pattern>
    </encoder> 	    
  </appender>
  
  <!-- additivity="false"는 글로벌하게 적용 된 com패키지 하위 존재하는 것 중 별도로 빼서 로그를 적용한다.-->
	<logger name="eams.security.SecurityConfig" additivity="false">
	    <level value="INFO" />
		<appender-ref ref="dailyRollingFileAppender"/>
		<appender-ref ref="consoleAppender" />
	</logger>

  <!-- appender-ref ref 설정은 위에 정의 된 appender를 상황에 맞게 적용하면 된다.-- >
	<logger name="com">
	    <level value="DEBUG" />
		<appender-ref ref="dailyRollingFileAppender1"/>
	</logger>

	<logger name="LoginLog">
	    <level value="DEBUG" />
		<appender-ref ref="dailyRollingFileAppender2"/>
	</logger>

	<root>
		<level value="INFO" />
		<appender-ref ref="consoleAppender" />
	</root>
</configuration>
```
