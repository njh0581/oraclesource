-- scott 권한 
GRANT connect, resource TO scott;
GRANT CREATE VIEW TO scott;

--데이터를 저장할 수 있는 저장공간 할당
ALTER USER SCOTT DEFAULT TABLESPACE USERS;
ALTER USER SCOTT TEMPORARY TABLESPACE TEMP;
ALTER USER SCOTT QUOTA 10M ON USERS;

ALTER ssession SET "_oracle_script"=TRUE;

--DBA 권한을 가진 사용자만 사용자를 생성하고 권한 부여
--SYSTEM, SYS AS SYSDBA
--CREATE USER 아이디 IDENTIFIED BY 비밀번호;

--TEST 생성
CREATE USER C##TEST IDENTIFIED BY test;

--CREATE SESSION 권한을 가지고있지 않음 로그온이 거절
--권한 부여
--SESSION, CREATE(USER, TABLE, SEQUENCE, VIEW)
--권한 그룹 => 롤
--CONNENCT, RESOURCE
--CONNECT(SESSIONM, CREATE, TABLE, CREATE VIEW...)
--RESOURCE(SEQUENCE, 프로시저, 테이블)

--GRANT 권한이름,....... TO 아이디
--GRANT 롤이름,..........TO 아이디
GRANT CONNECT, RESOURCE TO C##TEST;

CREATE USER C##TEST2 IDENTIFIED BY test
DEFAULT TABLESPACE users
TEMPORARY TABLESPACE TEMP
QUOTA 10M ON USERS;

GRANT CONNECT, RESOURCE TO C##TEST2;

--REVOKE 취소할 권한이름,........FROM 아이디

--비밀번호 변경
ALTER USER C##TEST2 INDENTIFIED BY TEST;







