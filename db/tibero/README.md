# 사용자 등록
CREATE USER logapi IDENTIFIED BY logapi  
DEFAULT TABLESPACE TS_EAMS;  

# 사용자 수정  
ALTER USER LOGAPI IDENTIFIED BY logapi;

# tablespace 생성 시 파일을 분할하여 생성하는 것이 좋다

# 사용자 정보 수정은 Tibero Admin툴에서 Security Manager메뉴에서 수정 가능
 > 수정 시 롤 그룹을 만들어 그 그룹을 유저에게 적용 할 수 있다  
 > 기존에 존재하는 룰은 너무 포괄적이거나 제한적이거나 한다.

# 테이블 복사 (백업용 쿼리)
create table 새로운테이블명 as select * from 기존테이블명  
[참고문헌] https://infovider.tistory.com/9
