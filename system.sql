-- scott 권한 
GRANT connect, resource TO scott;
GRANT CREATE VIEW TO scott;

--데이터를 저장할 수 있는 저장공간 할당
ALTER USER SCOTT DEFAULT TABLESPACE USERS;
ALTER USER SCOTT TEMPORARY TABLESPACE TEMP;
ALTER USER SCOTT QUOTA 10M ON USERS;

ALTER ssession SET "_oracle_script"=TRUE;