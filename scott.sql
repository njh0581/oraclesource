-- scott

-- SELECT(데이터 조회 목적)
-- e : 별칭(임의 지정 가능)/ 없어도 됨
-- * : 전체필드를 의미함
SELECT * FROM EMP ;


--특정 컬럼에 해당하는 내용 보기
SELECT
	empno,
	ename,
	job
FROM
	emp;

--emp 테이블
--empno(사원번호), ename(사원명), job(직책), mgr(매니저번호), hiredate(고용일), sal(급여), comm(보너스), deptno(부서번호) 

-- emp 테이블에서 사원번호, 매니저번호, 부서번호만 조회
SELECT
	empno,
	mgr,
	deptno
FROM
	emp; 

-- emp테이블에서 부서번호만(중복데이터는 제거) 조회	
SELECT DISTINCT
	deptno
FROM
	emp;

-- 데이터 출력 시 필드명 별칭 부여	
SELECT
	empno AS 사원번호,
	mgr 매니저번호,-- AS 생략이 가능
	deptno "부서 번호" --쌍따옴표 별칭에 공백이 있는경우 무조건 사용한다
FROM
	emp ;
	
--연봉 계산
--월급 * 12 + 수당
SELECT empno, sal, sal *12 + comm AS 연봉
FROM emp;

--정렬
--order by 정렬기준컬럼명 DESC or ASC
--DESC(내림차순), ASC(오름차순-default)
SELECT
	*
FROM
	emp
ORDER BY sal DESC;

--emp테이블에서 empno, ename, sal 조회(단, empno 내림차순)
SELECT
	empno,
	ename,
	sal
FROM
	emp
ORDER BY
	empno desc;

--전체조회, 부서번호 오름차순, sal 내림차순
SELECT
	*
FROM
	emp
ORDER BY
	deptno,
	sal DESC;

--조건
--부서번호가 30번인 사원 조회
-- = : 같다, 산술연산자(>, <, >=, <=)
SELECT
	*
FROM
	emp
WHERE
	deptno = 30;
--sal >= 1000 인 사원 조회 내림차순
SELECT
	*
FROM
	emp
WHERE
	sal >= 1000
ORDER BY sal desc;

--empno가 7782 인 사원 조회
SELECT * FROM emp WHERE empno=7782;
--deptno가 30번이고 job이 slaesman인 사원 조회
--데이터는 대소문자 구분
SELECT * FROM emp WHERE deptno=30 and job='SALESMAN';

--사원번호가 7499 이고 부서번호가 30인 사원 조회
SELECT * FROM EMP WHERE EMPNO=7499 AND DEPTNO=30 ;

--이거나(혹은) : OR
--부서번호가 30이거나 JOB이 SALESMAN인 사원 조회
SELECT * FROM EMP WHERE DEPTNO=30 OR JOB='SALESMAN';

--연봉이 36000인 사원 조회
--연봉 SAL*12+COMM
SELECT * FROM EMP WHERE SAL*12+COMM=36000;
--문자비교도 가능-산술연산 기호 가능
--알파벳 순서로 F 다음에 있는 
SELECT * FROM EMP WHERE ENAME >='F';

--sal 이 3000이 아닌 사원 조회
-- !=, <>, ^=
SELECT * FROM emp WHERE sal !=3000;

SELECT * FROM emp WHERE sal <>3000;

SELECT * FROM emp WHERE sal ^=3000;

--job이 manager or SALESMAN OR CLERK
SELECT * FROM emp WHERE JOB='MANAGER'OR JOB='SALESMAN'OR JOB='CLERK';

-- IN 
SELECT * FROM emp WHERE JOB IN('MANAGER','SALESMAN','CLERK');

SELECT * FROM emp WHERE JOB NOT IN('MANAGER','SALESMAN','CLERK');

--HIREDATE가 1981.10.31 이후에 고용된 사원 조회
SELECT * FROM EMP WHERE HIREDATE >'1981-10-31';

-- BETWEEN A AND B
-- SAL 2000 이상 3000이하인 사원 조회
SELECT *
FROM EMP e
WHERE SAL >=2000 AND SAL <= 3000;

SELECT *
FROM EMP e
WHERE SAL BETWEEN 2000 AND 3000;


-- NOT BETWEEN A AND B
-- SAL 2000 이상 3000이하가 아닌 사원 조회
SELECT *
FROM EMP e
WHERE SAL NOT BETWEEN 2000 AND 3000;


--LIKE 연산자와 와일드 카드(_, %)
--사원 이름이 S로 시작한느 사원 조회
SELECT *
FROM EMP
WHERE ENAME LIKE 'S%'; -- % : 문자 개수는 무한대

--사원 이름의 두번째 글자가 L인 사원 조회
SELECT *
FROM EMP e 
WHERE ENAME LIKE '_L%'; -- _ : 문자 하나

--사원 이름에 AM 문자가 포함된 사원 조회
SELECT *
FROM EMP e 
WHERE ENAME LIKE '%AM%';

--사원 이름에 AM 문자가 포함되지 않은 사원 조회
SELECT *
FROM EMP e 
WHERE ENAME NOT LIKE '%AM%';

SELECT * FROM emp;
-- NULL : 값이 없는 상태
-- '' : 빈값
-- ' ' : 스페이스바도 문자 

--comm 이 null 인 사원 조회
--NULL 비교 : IS
SELECT * FROM emp WHERE comm IS NULL;
--MGR 이 NULL인 사원 조회
SELECT *  FROM EMP WHERE MGR IS NULL;
--MGR이 NULL이 아닌 사원 조회
SELECT * FROM EMP WHERE MGR IS NOT NULL;

--집합 연산자
--합집합(UNION, UNION ALL), 교집합(INTERSECT), 차집합(MINUS)

--부서번호가 10 혹은 20 사원 조회
--OR 사용해서 추출
--합집합
--질의 블록은 부정확한 수의 결과 열을 가지고 있다
--집합 연산자 UNION을 사용할 때 출력 열 개수, 타일 동일
SELECT EMPNO, ENAME, SAL, DEPTNO 
FROM EMP
WHERE DEPTNO = 10
UNION
SELECT EMPNO, ENAME, SAL, DEPTNO 
FROM EMP
WHERE DEPTNO = 20;

SELECT EMPNO, ENAME, SAL, DEPTNO 
FROM EMP
WHERE DEPTNO = 10
UNION
SELECT SAL, JOB, DEPTNO, SAL 
FROM EMP
WHERE DEPTNO = 20;

-- 결과값 중복 삭제
SELECT EMPNO, ENAME, SAL, DEPTNO 
FROM EMP
WHERE DEPTNO = 10
UNION
SELECT EMPNO, ENAME, SAL, DEPTNO 
FROM EMP
WHERE DEPTNO = 10;

--결과값 중복 제거X
SELECT EMPNO, ENAME, SAL, DEPTNO 
FROM EMP
WHERE DEPTNO = 10
UNION ALL 
SELECT EMPNO, ENAME, SAL, DEPTNO 
FROM EMP
WHERE DEPTNO = 10;

-- MINUS
SELECT EMPNO, ENAME, SAL, DEPTNO 
FROM EMP
MINUS
SELECT EMPNO, ENAME, SAL, DEPTNO 
FROM EMP
WHERE DEPTNO = 10;

--INTERSECT
SELECT EMPNO, ENAME, SAL, DEPTNO 
FROM EMP
INTERSECT
SELECT EMPNO, ENAME, SAL, DEPTNO 
FROM EMP
WHERE DEPTNO = 10;

--오라클 함수
--함수는 사용하는 DBMS에 따라 다르게 제공
--1.문자 함수
--대소문자 변경
--UPPER(문자열) : 괄호 안 문자를 모두 대문자로 변환하여 반환
--LOWER(문자열) : 괄호 안 문자를 모두 소문자로 변환하여 반환
--INITCAP(문자열) : 괄호 안 문자 데이터중 첫번째 문자만 대문자로 나머지는 소문자로 변환하여 반환
SELECT ENAME, UPPER(ENAME), LOWER(ENAME), INITCAP(ENAME)
FROM EMP;

SELECT *
FROM EMP
WHERE ENAME  = upper('clark');
SELECT *
FROM EMP
WHERE LOWER(ENAME)  = 'clark';

--2.문자열 길이 : LENGTH, LENGTHB
--LENGTHB : 문자열에 사용된 바이트 수 변환
SELECT ENAME, LENGTH(ENAME), LENGTHB(ENAME)
FROM EMP;

--함수 결과를 보고싶은데 테이블이 없는경우 임시 테이블로 DUAL 사용
--한글은 문자 하나당 3byte 할당
SELECT LENGTHB('한글') FROM DUAL;

--직책 이름이 6글자 이상인 사원 조회
SELECT * FROM emp WHERE LENGTH(job) >=6 ;

--3.문자열 일부 추출 : substr(문자열데이터, 시작위치, 추출길이)
--                     substr(문자열데이터, 시작위치,) : 시작위치~마지막까지
--                     시작위치가 음수라면 오른쪽 끝부터 시작
SELECT JOB, SUBSTR(JOB,1,2), SUBSTR(JOB,3,2), SUBSTR(JOB,5) 
FROM EMP e ;

SELECT JOB, SUBSTR(JOB,-1,2), SUBSTR(JOB,-3,2), SUBSTR(JOB,-5) 
FROM EMP e ;

--4. INSTR(문자열데이터, 위치를 찾으려는 문자, 시작위치, 시작위치에서 몇번째 위치)
--   문자열 데이터 안에서 특정 문자 위치 찾기
SELECT INSTR('HELLO, ORACLE!','L') AS INSTR_1,
       INSTR('HELLO, ORACLE!','L', 5) AS INSTR_2,
       INSTR('HELLO, ORACLE!','L', 2, 2) AS INSTR_3
FROM DUAL;

--사원 이름에 S가 들어있는 사원 조회
SELECT * 
FROM EMP 
WHERE INSTR(ENAME,'S') >0 ;

--5. REPLACE : 특정 문자를 다른 문자로 변경
--             REPLACE(문자열데이터,찾는문자,변경할문자)
SELECT '010-1234-5678' AS REPLACE_BEFORE,
        REPLACE('010-1234-5678','-','') AS REPLACE_1,
        REPLACE('010-1234-5678','-') AS REPLACE_2,
        REPLACE('010-1234-5678','-',' ') AS REPLACE_3
FROM DUAL;

--6. CONCAT : 두 문자열 데이터를 합하는 함수
--            CONCAT(문자열데이터1, 문자열데이터2)
--SELECT CONCAT(EMPNO,ENAME), CONCAT(EMPNO,ENAME,JOB)
--FROM EMP
--WHERE ENAME='SCOTT';

-- 7369 : SMITH
SELECT CONCAT(EMPNO,ENAME), CONCAT(EMPNO,CONCAT(' : ',ENAME))
FROM EMP
WHERE ENAME='SMITH';

SELECT EMPNO || ' : ' || ENAME
FROM EMP
WHERE ENAME='SMITH';

--7.TRIM : 공백제거
--  TRIM(삭제옵션(선택), 삭제할문자)
-- 'SMITH' = 'SMITH '
SELECT '[' || '   __Oracle__   ' || ']' AS TRIM_BEFORE,
       '[' || TRIM(' __Oracle__ ') || ']' AS TRIM
FROM DUAL;

SELECT '[' || '   __Oracle__   ' || ']' AS TRIM_BEFORE,
       '[' || TRIM(LEADING '_'FROM '__Oracle__') || ']' AS TRIM_LEADING,
       '[' || TRIM(TRAILING '_'FROM '__Oracle__') || ']' AS TRIM_TRAILING,
       '[' || TRIM(BOTH '_'FROM '__Oracle__') || ']' AS TRIM_BOTH
FROM DUAL;

SELECT '[' || '   __Oracle__   ' || ']' AS TRIM_BEFORE,
       '[' || TRIM('  __Oracle__  ') || ']' AS TRIM,
       '[' || LTRIM('  __Oracle__  ') || ']' AS LTRIM,
       '[' || RTRIM('  __Oracle__  ') || ']' AS RTRIM
FROM DUAL;

--2. 숫자함수 : 숫자 데이터에 적용
--   반올림, 올림, 버림, 나머지 값 구하기
--   ROUND, CEIL, FLOOR, TRUNC, MOD
--   ROUND(숫자, 반올림위치)

SELECT ROUND(1234.5678) AS ROUND,
       ROUND(1234.5678,0) AS ROUND1,
       ROUND(1234.5678,1) AS ROUND2,
       ROUND(1234.5678,2) AS ROUND3,
       ROUND(1234.5678,-1) AS ROUND_MINUS1,
       ROUND(1234.5678,-2) AS ROUND_MINUS2
FROM DUAL;

--TRUNC(숫자,버릴위치) : 버림
SELECT TRUNC(1234.5678) AS TRUNC,
       TRUNC(1234.5678,0) AS TRUNC0,
       TRUNC(1234.5678,1) AS TRUNC1,
       TRUNC(1234.5678,2) AS TRUNC2,
       TRUNC(1234.5678,-1) AS TRUNC_MINUS1,
       TRUNC(1234.5678,-2) AS TRUNC_MINUS2
FROM DUAL;
       
-- CEIL, FLOOR : 지정한 숫자와 가까운 정수를 찾기
-- CEIL : 지정한 숫자보다 큰 정수 중 가장 작은 정수 반환
-- FLOOR : 지정한 숫자보다 작은 정수 중 가장 큰 정수 반환
SELECT CEIL(3.14), FLOOR(3.14), CEIL(-3.14), FLOOR(-3.14)
FROM DUAL;

--MOD : SKAJWL
SELECT 11/5, MOD(11,5)
FROM DUAL;

--3.날짜 함수
--2024-01-24 OR 2024-01-24

--오늘날짜
SELECT SYSDATE,CURRENT_DATE ,CURRENT_TIMESTAMP 
 FROM DUAL ;

--날짜데이터+ 숫자 : 날짜 데이터보다 숫자만큼 이후의 날짜
SELECT SYSDATE, SYSDATE+1, SYSDATE-1
FROM DUAL;

--ADD_MONTHS() : 몇 개월 이후의 날짜 구하기
SELECT SYSDATE, ADD_MONTHS(SYSDATE,3)
FROM DUAL;
--입사 30주년이 되는 날짜 구하기
SELECT EMPNO, ENAME, HIREDATE,ADD_MONTHS(HIREDATE,360)
FROM EMP e ;


--MONTS_BETWEEN() : 두 개의 날짜 데이터를 입력하고 두 날짜간의 개 월 수 차이 구하기
--고용일과 오늘날짜 차이
SELECT
	EMPNO ,
	ENAME,
	HIREDATE,
	SYSDATE,
	MONTHS_BETWEEN(HIREDATE, SYSDATE) AS MONTHS1,
	MONTHS_BETWEEN(SYSDATE, HIREDATE) AS MONTHS2
FROM
	EMP;

--NEXT_DAY, LAST_DAY
--NEXT_DAY(날짜,요일) : 특정 날짜를 기준으로 돌아오는 요일의 날짜 출력
--LAST_DAY(날짜) : 특정 날짜가 속한 달의 마지막 날짜 출력
SELECT SYSDATE, NEXT_DAY(SYSDATE,'월요일'), LAST_DAY(SYSDATE)
FROM DUAL;

--데이터타입
--NUMBER(숫자), VARCHAR2(문자), DATE(날짜/시간)
--자료형 변환(날짜 -> 문자, 문자 -> 숫자)
--NUMBER + 문자숫자 : 자동 형 변환으로 계산 처리
SELECT EMPNO , ENAME, EMPNO + '500'
FROM EMP e 
WHERE ENAME ='FORD';

--명시적 형변환
--TO_CHAR(날짜(숫자)데이터,'출력되기를 원하는 문자 형태') : 숫자, 날짜 데이터를 문자로 변환
--TO_NUMBER(문자열, 숫자형식) : 문자 데이터를 숫자로 변환
--TO_DATE() : 문자 데이터를 날짜로 변환

--Y : 연도 M : 월 D : 일 HH : 시 MI : 분 SS : 초 HH24 : 시를 24시간으로 AM(PM) : 오전 오후
SELECT TO_CHAR(SYSDATE, 'YYYY/MM/DD'),SYSDATE, TO_CHAR(SYSDATE, 'YY/MM/DD HH24:MI:SS AM')
FROM DUAL;

SELECT 1300- '1500' , '1300' + 1500
FROM DUAL;

--수치가 부적합
--SELECT '1,300' + '1,500'
--FROM DUAL;

-- 9 : 숫자의 한 자리를 의미함
-- 0 : 빈 자리를 0으로 채움
SELECT TO_NUMBER('1,300','999,999') + TO_NUMBER('1,500','999,999')
FROM DUAL;

SELECT TO_CHAR(SAL, '999,999.00') AS SAL1,
       TO_CHAR(SAL, '000,999,999.00') AS SAL2
FROM EMP;

--TO_DATE(문자,'인식될 날짜 형태') : 문자 데이터를 날짜 데이터로 변환
SELECT
	TO_DATE('2024-10-24') AS TODATE1,
	TO_DATE('20241024') AS TODATE2
FROM
	DUAL;

SELECT TO_DATE('2024-01-24') - TO_DATE('2023-12-31')
FROM DUAL;

-- NULL 처리 함수
-- NULL * 숫자 = NULL , NULL + 숫자 = NULL
-- NULL을 다른 값으로 변경
SELECT EMPNO,ENAME ,SAL ,COMM ,SAL + COMM
FROM EMP;

--NVL(NULL인지 검사할 열이름(OR 데이터), 대체할 데이터)
SELECT EMPNO,ENAME ,SAL ,COMM ,SAL + NVL(COMM,0)
FROM EMP;

--NVL2(NULL인지 검사할 열이름(OR 데이터),NULL 이 아닌경우 반환 데이터(계산식), NULL인 경우 반환 데이터(계산식))
SELECT EMPNO,ENAME ,SAL ,COMM, NVL2(COMM,'O','X')
FROM EMP;

--NVL2
--COMM 이 NULL 이면 연봉= SAL * 12, NULL 이 아니면 연봉= SAL * 12 + COMM
SELECT
	EMPNO,
	ENAME,
	SAL,
	COMM,
	NVL2(COMM, SAL * 12 + COMM, SAL * 12) AS 연봉
FROM
	EMP;

--JOB이 MANAGER 라면 SAL * 1.1
--JOB이 SALESMAN 라면 SAL * 1.05
--JOB이 ANALYST 라면 SAL
-- 나머지 직무들은 SAL * 1.03
--DECODE 함수와 CASE 문

--DECODE(검사대상, 조건1, 조건1이 참일때 반환할 결과, 조건2,조건2가 참일때 반환할결과,......,조건1~조건n 일치하지 않는경우 반환할 결과)
SELECT
	EMPNO,
	ENAME,
	JOB,
	SAL,
	DECODE(JOB, 'MANAGER', SAL*1.1,'SALESMAN', SAL*1.05,'ANALYST',SAL, SAL*1.03 ) AS UPSAL
FROM
	EMP;

SELECT
	EMPNO,
	ENAME,
	JOB,
	SAL,
	CASE
		JOB 
		WHEN 'MANAGER' THEN SAL * 1.1
		WHEN 'SALESMAN' THEN SAL * 1.05
		WHEN 'ANALYST' THEN SAL 
		ELSE SAL * 1.03
    END AS UPSAL2,
		DECODE(JOB, 'MANAGER', SAL * 1.1, 'SALESMAN', SAL * 1.05, 'ANALYST', SAL, SAL * 1.03 ) AS UPSAL
	FROM
		EMP;
	

--COMM이 NULL일때 해당사항 없음
--       0일때 수당없음
--       > 0   수당 : COMM
SELECT
	EMPNO,
	ENAME,
	COMM,
	CASE 
	   WHEN COMM IS NULL THEN '해당사항 없음'
	   WHEN COMM = 0 THEN '수당없음'
	   WHEN COMM > 0 THEN '수당 : ' || COMM
	END AS COMM_TEXT
FROM
	EMP e;


--실습1
SELECT
	EMPNO,
	ENAME,
	SAL,
	TRUNC(SAL / 21.5, 2) AS DAY_PAY,
	ROUND(SAL / 21.5 / 8, 1) AS TIME_PAY
FROM
	EMP e ;

--EMP 테이블에서 사원들은 입사일을 기준으로 3개월이 지난 후 첫 월요일에 정직원이 된다.
--사원들이 정직원이 되는 날짜(R_JOB)를 YYYY-MM-DD 형식으로 아래와 같이 출력하시오
--단, 추가수당이 없는 사원츼 추가수당은 N/A로 출력하시오

SELECT
	EMPNO,
	ENAME,
	HIREDATE,MGR,
	NEXT_DAY(ADD_MONTHS(HIREDATE,3),'월요일') AS R_JOB,
	NVL(TO_CHAR(COMM),'N/A') AS COMM
FROM
	EMP;

--실습3
--SUBSTR(TO_CHAR(MGR),1,2)
SELECT EMPNO , ENAME, MGR,
      CASE
	   WHEN MGR IS NULL THEN '0000'
	   WHEN SUBSTR(TO_CHAR(MGR),1,2) = '75' THEN '5555'
	   WHEN SUBSTR(TO_CHAR(MGR),1,2) = '76' THEN '6666'
	   WHEN SUBSTR(TO_CHAR(MGR),1,2) = '77' THEN '7777'
	   WHEN SUBSTR(TO_CHAR(MGR),1,2) = '78' THEN '8888'
	   ELSE TO_CHAR(MGR)
	   END AS CHG_MGR
 FROM EMP e ;

SELECT
	EMPNO ,
	ENAME,
	MGR,
	DECODE(SUBSTR(TO_CHAR(MGR), 1, 2), NULL, '0000', '75', '5555', '76', '6666', '77', '7777', '78', '8888', SUBSTR(TO_CHAR(MGR), 1))AS CHG_MGR
FROM
	EMP;

SELECT EMPNO , ENAME, MGR,
      CASE SUBSTR(TO_CHAR(NVL(MGR,0)),1,2)
	   WHEN '0'  THEN '0000'
	   WHEN '75' THEN '5555'
	   WHEN '76' THEN '6666'
	   WHEN '77' THEN '7777'
	   WHEN '78' THEN '8888'
	   ELSE TO_CHAR(MGR)
	   END AS CHG_MGR
 FROM EMP e ;

--다중 행 함수
--SUM(),AVG(),COUNT(),MAX(),MIN()

--단일그룹의 그룹 함수가 아닙니다(여러 행이 나올 수 있는 컬럼을 추가한 경우)
SELECT SUM(SAL), AVG(SAL), COUNT(SAL), MAX(SAL), MIN(SAL)
FROM EMP;

--동일한 급여를 하나만 선택해서 합계
SELECT SUM(DISTINCT SAL)
FROM EMP;

--
SELECT COUNT(*)
FROM EMP e ;

--부서번호가 30인 사원 수 출력
SELECT COUNT(*)
FROM EMP e 
WHERE DEPTNO = 30;

--부서번호가 30인 사원중에서 급여의 최댓값
SELECT MAX(SAL)
FROM EMP e 
WHERE DEPTNO = 30;

--부서번호가 20인 사원의 입사일 중에서 제일 최근 입사일 조회
SELECT MAX(HIREDATE)
FROM EMP
WHERE DEPTNO = 20;

--부서번호가 30인 사원 중에서 SAL 중복값 제거한 후 평균 구하기
SELECT AVG(DISTINCT SAL)
FROM EMP e 
WHERE DEPTNO = 20 ;

--부서별 급여 합계
SELECT '10' AS DEPTNO , SUM(SAL)
FROM EMP e 
WHERE DEPTNO = 10
UNION
SELECT '20' AS DEPTNO ,SUM(SAL)
FROM EMP e 
WHERE DEPTNO = 20
UNION
SELECT '30' AS DEPTNO ,SUM(SAL)
FROM EMP e 
WHERE DEPTNO = 30;

--결과 값을 원하는 열로 묶기 : GROUP BY
--SELECT 보고싶은 컬럼(열이름)            ①
--FROM 테이블명                           ②
--WHERE 조건을 나열                       ③
--GROUP BY 그룹화할 열 이름               ④
--ORDER BY 정렬 조건                      ⑤

--GROUP BY 표현식이 아닙니다
--GROUP BY 옆에 오는 컬럼만 SELECT 절에 사용가능

--실행순서
-- ② --> ③ --> GROUP BY --> HAVING --> ① --> ⑤

SELECT DEPTNO ,SUM(SAL)
FROM EMP e 
GROUP BY DEPTNO ;

--부서별 급여 평균
SELECT DEPTNO, AVG(SAL)
FROM EMP e 
GROUP BY DEPTNO ;

--부서번호, 직무별 급여 평균
SELECT DEPTNO ,JOB, AVG(SAL)
FROM EMP e 
GROUP BY DEPTNO ,JOB 
ORDER BY DEPTNO ;

--HAVING : GROUP BY 절에 조건을 사용할 때
--부서별 직책의 평균 급여가 500 이상인 사원들의 부서번호, 직책, 부서별 직책 평균급여

SELECT DEPTNO , JOB ,AVG(SAL)
FROM EMP e 
GROUP BY DEPTNO , JOB HAVING AVG(SAL) >= 500
ORDER BY DEPTNO ,JOB ; 

SELECT DEPTNO , JOB ,AVG(SAL)
FROM EMP e 
WHERE SAL <= 3000
GROUP BY DEPTNO , JOB HAVING AVG(SAL) >= 2000
ORDER BY DEPTNO ,JOB ; 

--같은 직무에 종사하는 사원이 3명 이상인 직무와 인원수 조회
SELECT JOB ,COUNT(JOB)
FROM EMP e 
GROUP BY JOB HAVING  COUNT(JOB)>= 3
ORDER BY JOB ; 

--사원들의 입사연도를 기준으로 부서별 몇명이 입사했는지 조회
--1981 10 3

SELECT TO_CHAR(HIREDATE,'YYYY')AS HIRE_YEAR,DEPTNO , COUNT(*)AS 인원수
FROM EMP e 
GROUP BY TO_CHAR(HIREDATE,'YYYY'),DEPTNO 
ORDER BY DEPTNO ;

--JOIN : 여러 테이블을 하나의 테이블 처럼 사용
--1) 내부조인(일치하는 값이 있는 경우)

--EMP와 DEPT 조인
SELECT *
FROM EMP e, DEPT d
WHERE e.DEPTNO = d.DEPTNO;

--열의 정의가 애매합니다(조인 할 경우 테이블에 동일한 컬럼명이 존재하는 경우)
SELECT e.ENAME, e.SAL,d.DEPTNO, d.DNAME , d.LOC 
FROM EMP e, DEPT d
WHERE e.DEPTNO = d.DEPTNO;

--JOIN 조건이 없을때 나올 수 있는 모든 조합이 결과로 나옴
SELECT e.ENAME, e.SAL,d.DEPTNO, d.DNAME , d.LOC 
FROM EMP e, DEPT d


SELECT e.ENAME, e.SAL,d.DEPTNO, d.DNAME , d.LOC 
FROM EMP e INNER JOIN DEPT d ON e.DEPTNO = d.DEPTNO
WHERE e.SAL >= 3000;


-- EMP, SALGADE 조인
SELECT *
FROM EMP e, SALGRADE s
WHERE e.SAL BETWEEN s.LOSAL AND s.HISAL;

--EMP, EMP 조인(SELF 조인)
SELECT e.EMPNO, e.ENAME, e.MGR, e2.ENAME AS MGR_NAME
FROM EMP e , EMP e2 
WHERE e.MGR = e2.EMPNO ;


--2) 외부조인
--(1) 왼쪽 외부조인 : LEFT OUTER JOIN
--(2) 오른쪽 외부조인 RIGHT OUTER JOIN

SELECT e.EMPNO, e.ENAME, e.MGR, e2.ENAME AS MGR_NAME
FROM EMP e LEFT OUTER JOIN  EMP e2 ON e.MGR = e2.EMPNO ;



SELECT e.EMPNO, e.ENAME, e.MGR, e2.ENAME AS MGR_NAME
FROM EMP e RIGHT OUTER JOIN  EMP e2 ON e.MGR = e2.EMPNO ;


--각 부서별 평균급여, 최대급여, 최소급여, 사원수
--부서번호,부서명, 평균급여,최대급여,최소급여, 사원순
SELECT e.DEPTNO, d.DNAME ,MIN(SAL), MAX(SAL),MIN(SAL),COUNT(*)
FROM EMP e JOIN DEPT d ON e.DEPTNO = d.DEPTNO
GROUP BY e.DEPTNO , d.DNAME;

--세 개의 테이블 조인하기
SELECT
	*
FROM
	EMP e1
JOIN EMP e2 ON
	e1.EMPNO = e2.EMPNO
JOIN EMP e3 ON
	e2.EMPNO = e3.EMPNO;

--모든 부서 정보와 사원 정보를 출력
--부서번호, 사원 이름 순으로 정렬하여 출력
--부서번호, 부서명, 사원번호, 사원명, 직무명, 급여
--DEPT 테이블 기준 출력

SELECT d.DEPTNO , d.DNAME , e.EMPNO, e.ENAME, e.JOB, e.SAL
FROM DEPT d LEFT OUTER JOIN EMP e ON d.DEPTNO = e.DEPTNO 
ORDER BY d.DEPTNO , e.ENAME ;

SELECT d.DEPTNO , d.DNAME , e.EMPNO, e.ENAME, e.JOB, e.SAL
FROM EMP e RIGHT OUTER JOIN DEPT d  ON d.DEPTNO = e.DEPTNO 
ORDER BY d.DEPTNO , e.ENAME ;

--모든 부서 정보와 사원 정보를 출력
--부서번호, 사원 이름 순으로 정렬하여 출력
--부서번호, 부서명, 사원번호, 사원명, 직무명, 급여, LOSAL,HISAL,GRADE
--DEPT 테이블 기준 출력

SELECT
	d.DEPTNO ,
	d.DNAME ,
	e.EMPNO,
	e.ENAME,
	e.JOB,
	e.SAL,
	s.LOSAL ,
	s.HISAL ,
	s.GRADE
FROM
	EMP e
RIGHT OUTER JOIN DEPT d ON
	d.DEPTNO = e.DEPTNO
LEFT OUTER JOIN
	SALGRADE s
	ON
	e.SAL BETWEEN s.LOSAL AND s.HISAL
ORDER BY
	d.DEPTNO ,
	e.ENAME ;


--서브 쿼리
--SQL문 안에 내부에서 SELECT 문을 사용
--괄호로 묶어서 사용
--메인쿼리의 비교대상과 같은 자료형과 같은개수로 지정해야 한다.

--JONES 사원의 급여보다 높은 급여를 받는 사원 조회
--JONES 급여 알아내기 => 급여 비교
SELECT SAL
FROM EMP
WHERE ENAME = 'JONES';

SELECT *
FROM EMP
WHERE SAL > 2975;

SELECT *
FROM EMP
WHERE SAL >(
	SELECT
		SAL
	FROM
		EMP
	WHERE
        ENAME = 'JONES');
       
--ALLEN 이받는 COMM 보다 많은 추가수당을 받는 사원 조회
SELECT *
FROM EMP 
WHERE COMM > (SELECT COMM FROM EMP WHERE ENAME = 'ALLEN');

--WARD 사원의 입사일보다 빠른 입사자 조회
SELECT * 
FROM EMP 
WHERE HIREDATE > (SELECT HIREDATE FROM EMP WHERE ENAME = 'WARD');

--20번 부서에 속한 사원중 전체 사원의 평균 급여보다 높은 급여를 받는 사원 조회
--사원번호, 사원명, 직무, 급여 부서번호, 부서명, 지역
SELECT e.EMPNO , e.ENAME , e.JOB, e.SAL, e.DEPTNO , d.DNAME , d.LOC
FROM EMP e JOIN DEPT d ON e.DEPTNO = d.DEPTNO WHERE e.DEPTNO = 20 AND e.SAL  > (SELECT AVG(SAL) FROM EMP e );

--단일행 서브쿼리 : 서브쿼리 실행 결과가 단 하나의 행으로 나오는 서브쿼리
--사용가능한 연산자 : > , < , >=, <=, <>, ^=, !=

--다중행 서브쿼리 : 서브쿼리 실행 결과가 여러개의 행으로 나오는 서브쿼리
--사용가능한 연산자 : IN, ANY(SOME), ALL, EXISTS
--                    IN, ANY(SOME) : 메인 쿼리의 조건식을 만족하는 서브쿼리가 하나이상
--                    ALL(메인쿼리의 조건식을 서브쿼리의 결과 모두가 만족)
--                    EXISTS(서브 쿼리의 결과가 존재하면)


--단일 행 하위질의에 2개 이상의 행이 리턴되었습니다.
--서브쿼리가 여러 개의 결과값을 리턴하는데 단일행 서브쿼리에 사용하는 연산자가 사용된 경우
--SELECT * FROM EMP WHERE SAL >= (SELECT MAX(SAL) FROM EMP GROUP BY DEPTNO);

SELECT * FROM EMP WHERE SAL IN (SELECT MAX(SAL) FROM EMP GROUP BY DEPTNO);
--IN 사용과 동일한 결과
SELECT * FROM EMP WHERE SAL = ANY (SELECT MAX(SAL) FROM EMP GROUP BY DEPTNO);
--30번 부서 사원들의 최대 급여보다 적은 급여를 받는 사원 조회
SELECT * FROM EMP WHERE SAL < ANY (SELECT SAL FROM EMP WHERE DEPTNO = 30);

SELECT * FROM EMP WHERE SAL < ALL (SELECT SAL FROM EMP WHERE DEPTNO = 30);

SELECT * FROM EMP WHERE EXISTS (SELECT DNAME FROM DEPT WHERE DEPTNO = 20);

--실습1 전체 사원중 ALLEN과 같은 직책인 사원들의 사원정보, 부서정보를 다음과 같이 출력하는 SQL문을 작성하시오
SELECT
	e.JOB,
	e.EMPNO,
	e.ENAME ,
	e.SAL,
	e.DEPTNO ,
	d.DNAME
FROM
	EMP e
JOIN DEPT d ON
	e.DEPTNO = d.DEPTNO
WHERE
	e.JOB IN (
	SELECT
		JOB
	FROM
		EMP
	WHERE
		ENAME = 'ALLEN');

--실습2 전체 사원의 평균 급여보다 높은 급여를 받는 사원들의 사원정보, 부서정보, 급여등급 정보를 출력하는 SQL문을 작성하시오
--단, 출력할때 급여가 많은 순으로 정렬하되 급여가 같을 경우는 사원 번호를 기준으로 오름차순으로 정렬하기
SELECT
	e.EMPNO,
	e.ENAME ,
	d.DNAME ,
	e.HIREDATE ,
	d.LOC ,
	e.SAL ,
	s.GRADE
FROM
	EMP e
JOIN DEPT d ON
	e.DEPTNO = d.DEPTNO
JOIN SALGRADE s ON
	e.SAL BETWEEN s.LOSAL AND s.HISAL
WHERE e.SAL > (SELECT AVG(e.SAL) FROM EMP e)
ORDER BY e.SAL DESC, e.EMPNO ASC ;

--다중 열 서브쿼리
--부서별 급여 최대값
SELECT *
FROM EMP e WHERE (DEPTNO ,SAL) IN
(SELECT DEPTNO, MAX(SAL)
FROM EMP e 
GROUP BY DEPTNO);

--FROM절에 사용하는 서브 쿼리(인라인뷰)
SELECT E10.EMPNO, E10.ENAME, E10.DEPTNO, D.DNAME, D.LOC
FROM (SELECT * FROM EMP WHERE DEPTNO=10) E10,
     (SELECT * FROM DEPT) D
WHERE E10.DEPTNO = D.DEPTNO;

--SELECT절에 사용하는 서브쿼리(스칼라 서브쿼리)
SELECT
	EMPNO,
	ENAME,
	JOB,
	SAL,
	(
	SELECT
		GRADE
	FROM
		SALGRADE s
	WHERE
		e.SAL BETWEEN s.LOSAL AND s.HISAL) AS SALGRADE
FROM
	EMP e ;
	

-- DML(Data Manipulation Language-데이터 조작 언어)
-- SELECT (조회), INSERT(삽입), UPDATE(수정), DELETE(삭제)

-- 기존 테이블 복제해서 새로운 테이블 생성
CREATE TABLE DEPT_TEMP AS SELECT * FROM DEPT;

--새로운 부서 추가
--INSERT INTO 테이블명(열이름1, 열이름2 .....)
--VALUES(데이터, 데이터,.....)
INSERT INTO DEPT_TEMP(DEPTNO,DNAME,LOC)
VALUES(60,'DATABASE','BUSAN');

INSERT INTO DEPT_TEMP
VALUES(70,'DATABASE','BUSAN');

INSERT INTO DEPT_TEMP(DEPTNO,DNAME)
VALUES (80,'DATABASE');

--이 열에 대해 지정된 전체 자릿수보다 큰 값이 허용됩니다
INSERT INTO DEPT_TEMP(DEPTNO,DNAME)
VALUES(800,'DATABASE');

INSERT INTO DEPT_TEMP(DEPTNO,DNAME,LOC)
VALUES(90,'DATABASE',NULL);

CREATE TABLE EMP_TEMP AS SELECT * FROM EMP;

INSERT INTO EMP_TEMP(EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,COMM,DEPTNO)
VALUES(8000,'HONG','MANAGER',7902,'2015-03-15',1000,NULL,50);

INSERT INTO EMP_TEMP(EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,COMM,DEPTNO)
VALUES(9000,'SUNG','MANAGER',7782,SYSDATE,1200,800,50);

--테이블의 구조만 복사(데이터는 복사하지 않을때)
CREATE TABLE EMP_TEMP2 AS SELECT * FROM EMP WHERE 1<>1;

--수정
--UPDATE 테이블명 SET 수정할 내용, ...., ;
--UPDATE 테이블명 SET 수정할 내용, ...., WHERE 조건;

UPDATE DEPT_TEMP
SET LOC = 'BUSAN';

UPDATE DEPT_TEMP
SET LOC = 'SEOUL'
WHERE DEPTNO = 50;

UPDATE DEPT_TEMP
SET LOC = 'SEOUL', DNAME = 'NETWORK'
WHERE DEPTNO = 40;

--삭제
--DELETE 테이블명 WHERE 조건
--DELETE * FORM 테이블명 WHERE 조건

DELETE DEPT_TEMP 
WHERE DEPTNO = 20;

DELETE FROM DEPT_TEMP 
WHERE DEPTNO = 30;


--서브쿼리 + DELETE
--급여등급이 3등급이고 30번 부서의 사원 삭제
DELETE
FROM
	EMP_TEMP
WHERE
	EMPNO IN (
	SELECT
		EMPNO
	FROM
		EMP_TEMP et
	JOIN SALGRADE s ON
		et.SAL BETWEEN s.LOSAL AND s.HISAL AND s.GRADE = 3 AND et.DEPTNO = 30);
	
--서브쿼리 + UPDATE
UPDATE DEPT_TEMP 
SET (DNAME,LOC) = (SELECT DNAME, LOC FROM DEPT WHERE DEPTNO=40)
WHERE DEPTNO =40;

--서브쿼리 + INSERT

INSERT INTO EMP_TEMP(EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,COMM,DEPTNO)
SELECT E1.EMPNO,E1.ENAME,E1.JOB,E1.MGR,E1.HIREDATE,E1.SAL,E1.COMM,E1.DEPTNO
FROM EMP E1 JOIN SALGRADE s ON E1.SAL BETWEEN S.LOSAL AND S.HISAL AND S.GRADE = 1

--실습1
CREATE TABLE EXAM_EMP AS SELECT * FROM EMP;
CREATE TABLE EXAM_DEPT AS SELECT * FROM DEPT;
CREATE TABLE EXAM_SALGRADE AS SELECT * FROM SALGRADE;

--실습2
INSERT INTO EXAM_EMP(EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,COMM,DEPTNO) 
VALUES(7201,'TEST_USER1','MANAGER',7788,'2016-01-02',4500,NULL,50);
INSERT INTO EXAM_EMP(EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,COMM,DEPTNO) 
VALUES(7202,'TEST_USER2','CLERK',7201,'2016-02-21',1800,NULL,50);
INSERT INTO EXAM_EMP(EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,COMM,DEPTNO) 
VALUES(7203,'TEST_USER3','ANALYST',7201,'2016-04-11',3400,NULL,60);
INSERT INTO EXAM_EMP(EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,COMM,DEPTNO) 
VALUES(7204,'TEST_USER4','SALESMAN',7201,'2016-05-31',2700,300,60);
INSERT INTO EXAM_EMP(EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,COMM,DEPTNO) 
VALUES(7205,'TEST_USER5','CLERK',7201,'2016-07-20',2600,NULL,70);
INSERT INTO EXAM_EMP(EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,COMM,DEPTNO) 
VALUES(7206,'TEST_USER6','CLERK',7201,'2016-09-08',2600,NULL,70);
INSERT INTO EXAM_EMP(EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,COMM,DEPTNO) 
VALUES(7207,'TEST_USER7','LECTURER',7201,'2016-10-28',2300,NULL,80);
INSERT INTO EXAM_EMP(EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,COMM,DEPTNO) 
VALUES(7208,'TEST_USER8','SYUDENT',7201,'2018-03-09',1200,NULL,80);

--실습3
--EXAM_EMP에 속한 사원 중 50번 부서에서 근무하는 사원들의 평균 급여보다
--많은 급여를 받고 있는 사원들을 70번 부서로 옮기는 SQL문 작성하기
 UPDATE EXAM_EMP 
 SET DEPTNO=70
 WHERE SAL > (SELECT AVG(SAL) FROM EXAM_EMP WHERE DEPTNO=50);

--실습4
--EXAM_EMP에 속한 사원 중 60번 부서의 사원 중에서 입사일이 가장 빠른 사원보다
--늦게 입사한 사원의 급여를 10% 인상하고 80번 부서로 옮기는 SQL문 작성하기
UPDATE EXAM_EMP SET SAL=SAL*1.1, DEPTNO=80 WHERE
HIREDATE > (SELECT MIN(HIREDATE) FROM EXAM_EMP WHERE DEPTNO = 60);

--실습5
--EXAM_EMP 에 속한 사원 중, 급여 등급이 5인 사원을 삭제하는 SQL문을 작성하기
DELETE FROM EXAM_EMP WHERE EMPNO IN (SELECT EMPNO FROM EXAM_EMP,SALGRADE 
WHERE SAL BETWEEN LOSAL AND HISAL AND GRADE = 5);


--Transaction
--하나의 작업 또는 밀접하게 연관되어 있는 작업 수행을 위해 나눌 수 없는 최소 작업 단위
--최종 반영(COMMIT) / 모두 취소(ROLLBACK)
--ORACLE - COMMIT, ROLLBACK 쉬운편임
--MYSQL - MYSQL WORKBENCH 에디터(AUTO COMMIT임)
--LOCK : 한 세션에서 트랙잭션 작업이 완료되지 않으면
--       다른 세션에서 작업을 처리할 수 없는 상태
--       (DML - INSET, UPDATE, DELETE)

--DBEAVER 설정에서 커밋 모드 변경 가능
--AUTO COMMIT 상태임
INSERT INTO DEPT_TEMP VALUES (55,'NETWORK','SEOUL');
UPDATE DEPT_TEMP SET LOC='BUSAN' WHERE DEPTNO = 55;
COMMIT;
ROLLBACK; --COMMIT 하기전에 해야 함

SELECT * FROM DEPT_TEMP dt ;

DELETE FROM DEPT_TEMP dt  WHERE DEPTNO=55;
UPDATE DEPT_TEMP SET DNAME = 'WEB' WHERE DEPTNO=10;
COMMIT;


--SQL - 1.DDL(정의) 2.DML- SELECT,INSERT,UPDATE,DELETE 3.DCL(권한부여)

--데이터 정의어(DDL)
--테이블 정의, 사용자 정의, 권한 부여(취소)
-- CREATE

--1. 테이블 생성
--CREATE TABLE 테이블명(
--필드명, 필드타입, 제약조건
--)

--열이름 규칙
--문자로 시작/38byte 이하로 작성/ 한 테이블 안 열이름 중복 불가
--열이름은 문자 0~9, 특수문자 사용가능
--sq1키워드는 열 이름으로 사용불가

--문자
--1) CHAR 2) VARCHAR2 3) NCHAR 4) NVARCHAR2 5) CLOB 6) NCLOB 7) LONG
--CHAR OR VARCHAR : 열의 너비가 고정값인지 가변인지
--CHAR(10) : 'hong' => 10자리 다 사용
--VACHAR2(10) : 'hong' => 입력된 글자에 따라 가변

--VACHAR2, CHAR 가 한글, 영문 입려기 사용하는 바이트 수가 다름
--NCHAR, NVARCHAR 사용하는 바이트 수 통일해서 사용

--NCHAR(10) : 'hong' => 유니코드 문자열 타입, 고정
--NVARCHAR2(10) : 'hong' => 유니코드 문자열 타입이고, 가변

--CLOB : 문자열 데이터를 외부 파일로 저장
--       엄청 많은 텍스트 데이터 입력 시 사용(4기가)
--LONG : 2기가

--숫자
--NUMBER(전체자릿수, 소수점자릿수)
--BIBARY_FLOAT, BINARY_DOUBLE

--날짜
--DATE, TIMESTAMP, 
CREATE TABLE EMP_DDL(
    EMPNO NUMBER(4),
    ENMAE VARCHAR2(10),
    JOB VARCHAR2(9),
    MGR NUMBER(4),
    HIREDATE DATE,
    SAL NUMBER(7,2),
    COMM NUMBER(7,2),
    DEPTNO NUMBER(2) );
   
SELECT * FROM EMP_DDL

--기본 테이블 열 구조와 데이터 복사해서 새 테이블 생성
CREATE TABLE EXAM_EMP AS SELECT * FROM EMP;

--기본 테이블 열 구조만 복수해서 새 테이블 생성
CREATE TABLE EMP_TEMP2 AS SELECT * FROM EMP WHERE 1<>1;

--DDL : CREATE ,ALTER
--2. 테이블 변경
--1) 열추가 (ADD)
--   ALTER TABLE 테이블명 ADD 추가할 열 이름 데이터타입(10)
-- EMP_DDL 새로운 컬럼 추가 HP(010-1234-5678)
ALTER TABLE EMP_DDL ADD HP VARCHAR2(15);

SELECT * FROM EMP_DDL;

--2) 열 이름 변경(RENAME)
--   ALTER TABLE 테이블명 RENAME COLUMN 기존이름 TO 변경이름
-- HP --> MOBILE
ALTER TABLE EMP_DDL RENAME COLUMN HP TO MOBILE;

SELECT * FROM EMP_DDL;


--3) 열 자료형 변경(MODIFY)
--   ALTER TABLE 테이블명 MODIFY 열이름 데이터타입(20)
--   EMPNO NUMBER(5)
ALTER TABLE EMP_DDL MODIFY EMPNO NUMBER(5);

SELECT * FROM EMP_DDL;

--4) 열 제거
-- ALTER TABLE 테이블명 DROP COLUMN 열이름;
ALTER TABLE EMP_DDL DROP COLUMN MOBILE;

--테이블 이름 변경
--RENAME 변경전 테이블명 TO 변경할테이블명
--EMP_DDL --> EMP_ALTER
RENAME EMP_DDL TO EMP_ALTER;

SELECT * FROM EMP_ALTER;

--CREATE, ALTER, DROP
--3) 삭제 : DROP
--DROP TABLE 테이블명;
DROP TABLE EMP_ALTER;

--VIEW : 가상테이블
--CREATE VIEW 뷰이름 AS (SELECT * FROM 원본 테이블명)
--뷰를 통해 원본 수정이 가능
--편리성, 보안성

--권한이 불충분합니다
--권한을 가진 사용자만 생성가능
CREATE VIEW VM_EMP20 AS (SELECT * FROM EMP WHERE DEPTNO=20);

SELECT * FROM VM_EMP20;

--뷰를 통해 데이터 삽입 시 원본에도 영향을 미침
INSERT INTO VM_EMP20
VALUES(8888,'HONG', 'ANALYST',7902 ,SYSDATE, 2500,NULL,20);

SELECT * FROM EMP;


SELECT * 
FROM USER_UPDATABLE_COLUMNS
WHERE TABLE_NAME='VM_EMP20';

--CREATE VIEW 뷰이름 AS (SELECT * FROM 원본 테이블명) WITH READ ONLY
--뷰를 통해 읽기만 가능

CREATE VIEW VM_EMP30 AS (SELECT * FROM EMP WHERE DEPTNO=30) WITH READ ONLY;
SELECT * 
FROM USER_UPDATABLE_COLUMNS
WHERE TABLE_NAME='VM_EMP30';

--VIEW 삭제
DROP VIEW VM_EMP20;

--INDEX 생성, 삭제
--INDEX(색인, 목차)
--인덱스 : 기본키, 고유키 일 때 자동으로 생성됨
--CREATE INDEX 인덱스명 ON 테이블명 (인덱스로 사용할 필드명)
CREATE INDEX IDX_EMP_SAL ON EMP(SAL);

SELECT * FROM USER_IND_COLUMNS;

DROP INDEX IDX_EMP_SAL;

--시퀀스 생성/삭제
--오라클 객체, 하나씩 증가하는 값이 필요 할 때 주로 사용
--다른 DB의 AUTO_INCREMENT 과 동일한 역할
--CREATE SEQUENCE 시퀀스명 
--INCREMENT BY 증감값 START WITH 시작값 MAXVALUE 최대값 MINVALUE 최소값 
--NOCYCLE CACHE 숫자;

--1에서 시작 ~ 9999999999999999999999999999
--1씩 증가하면서 숫자 생성
CREATE SEQUENCE dept_seq;
DROP SEQUENCE dept_seq;

SELECT * FROM USER_SEQUENCES;

CREATE TABLE dept_sequence AS SELECT * FROM dept WHERE 1<>1;
CREATE SEQUENCE dept_seq
INCREMENT BY 10 START WITH 10 MAXVALUE 90 MINVALUE 0
NOCYCLE CACHE 2;

INSERT INTO dept_sequence(DEPTNO,DNAME,LOC)
VALUES(dept_seq.NEXTVAL, 'DATABASE', 'SEOUL');

SELECT * FROM dept_sequence ;

ALTER SEQUENCE dept_seq INCREMENT BY 3 MAXVALUE 99 CYCLE;

--마지막으로 생성된 시퀀스 확인
SELECT dept_seq.CURRVAL FROM DUAL;

--제약조건
--테이블의 특정 열에 지정
--1) NOT NULL : 열에 NULL을 허용하지 않음
--2) UNIQUE : 지정한 열이 유일한 값을 가져야함(NULL은 중복 시 따지지 않음)
--3) PRIMARY KEY : 지정한 열이 유일한 값이면서 NULL을 허용하지 않음(테이블당 하나만 지정)
--4) FOREIGN KEY : 다른 테이블의 열을 참조하여 존재하는 값만 입력
--5) CHECK : 설정한 조건식을 만족하는 데이터만 입력


CREATE TABLE TBL_NOTNULL(
   LOGIN_ID VARCHAR2(20) NOT NULL,
   LOGIN_PWD VARCHAR2(20) NOT NULL,
   TEL VARCHAR2(20)
  );

--NULL을 ("SCOTT"."TBL_NOTNULL"."LOGIN_PWD") 안에 삽입할 수 없습니다
INSERT INTO TBL_NOTNULL VALUES('TESTID1',NULL,'010-1234-5678');
INSERT INTO TBL_NOTNULL VALUES('TESTID1','TESTID1',NULL);

SELECT * FROM TBL_NOTNULL;

--제약조건 확인
SELECT OWNER, CONSTRAINT_NAME, CONSTRAINT_TYPE, TABLE_NAME
FROM USER_CONSTRAINTS;

CREATE TABLE TBL_NOTNULL2(
   LOGIN_ID VARCHAR2(20) CONSTRAINT TBLNN2_LOGIN_NN NOT NULL,
   LOGIN_PWD VARCHAR2(20) CONSTRAINT TBLNN2_LOGPWD_NN NOT NULL,
   TEL VARCHAR2(20)
  );

 
 --생성한 테이블에 제약 조건 추가
ALTER TABLE TBL_NOTNULL MODIFY(TEL NOT NULL);

ALTER TABLE TBL_NOTNULL2 MODIFY(TEL CONSTRAINT TBLNN2_TEL_NN NOT NULL);


UPDATE TBL_NOTNULL SET TEL = '010-1234-5678' WHERE LOGIN_ID = 'TESTID1';


--생성한 제약 조건 이름 변경
ALTER TABLE TBL_NOTNULL2 RENAME CONSTRAINT TBLNN2_TEL_NN TO TBL_NN2_TEL;

--제약 조건 삭제
ALTER TABLE TBL_NOTNULL2 DROP CONSTRAINT TBL_NN2_TEL;


--UNIQUE 
CREATE TABLE TBL_UNIQUE(
   LOGIN_ID VARCHAR2(20) UNIQUE,
   LOGIN_PWD VARCHAR2(20) NOT NULL,
   TEL VARCHAR2(20)
  );
--데이터 무결성 : 데이터 정확성, 일관성을 보장해야함
--무결성 제약 조건(SCOTT.SYS_C008361)에 위배됩니다
INSERT INTO TBL_UNIQUE VALUES('TESTID1','TESTID1','010-1234-5678');

CREATE TABLE TBL_UNIQUE2(
   LOGIN_ID VARCHAR2(20) CONSTRAINT TBL_UNQ_LOGIN_ID UNIQUE,
   LOGIN_PWD VARCHAR2(20) CONSTRAINT TBL_UNQ_LOGIN_PWD_NN NOT NULL,
   TEL VARCHAR2(20)
  );
 
 ALTER TABLE TBL_UNIQUE2 MODIFY(TEL UNIQUE);
 ALTER TABLE TBL_UNIQUE MODIFY(TEL CONSTRAINT TBL_UNQ_TEL_UNQ UNIQUE);		

ALTER TABLE TBL_UNIQUE DROP CONSTRAINT TBL_UNQ_TEL_UNQ;

--PRIMARY KEY : 기본키
--INDEX설정 자동으로 만들어짐
--NOT + UNIQUE ==> 회원아이디, 이메일, 상품코드, 글번호...
CREATE TABLE TBL_PRIMARY(
   LOGIN_ID VARCHAR2(20) PRIMARY KEY,
   LOGIN_PWD VARCHAR2(20) NOT NULL,
   TEL VARCHAR2(20)
  );
  
 INSERT INTO TBL_PRIMARY(LOGIN_ID,LOGIN_PWD,TEL)
 VALUES ('TESTID1','TESTID1','010-1234-5689');

-- FOREIGN KEY : 특정 테이블의 기본키로 지정한 열을 다른 테이블의 특정 열에서 참조
-- 부모키/자식키

CREATE TABLE DEPT_FK(
DEPTNO NUMBER(2) CONSTRAINT DEPTFK_DEPTNO_PK PRIMARY KEY,
DNAME VARCHAR2(20),
LOC VARCHAR2(20));


CREATE TABLE EMP_FK(
    EMPNO NUMBER(4) CONSTRAINT EMPKF_EMPNO_PK PRIMARY KEY,
    ENMAE VARCHAR2(10),
    JOB VARCHAR2(9),
    MGR NUMBER(4),
    HIREDATE DATE,
    SAL NUMBER(7,2),
    COMM NUMBER(7,2),
    DEPTNO NUMBER(2) CONSTRAINT EMPFK_DEPTNO_FK REFERENCES DEPT_FK(DEPTNO)
    );
 
--무결성 제약조건(SCOTT.EMPFK_DEPTNO_FK)이 위배되었습니다- 부모 키가 없습니다
INSERT INTO EMP_FK VALUES (1000,'HONG','CLERK',7700,SYSDATE,1200,NULL,50);

INSERT INTO DEPT_FK VALUES (50,'DATABASE','SEOUL');

DELETE FROM DEPT_FK WHERE DEPTNO = 50;

DROP TABLE EMP_FK ;

--FK
--1) ON DELETE CASCADE : 부모가 삭제되면 자식도 같이 삭제
--2) ON DELETE SET NULL : 부모가 삭제되면 자식이 참조하는 부모의 값을 NULL 변경
CREATE TABLE EMP_FK2(
    EMPNO NUMBER(4) CONSTRAINT EMPFK2_EMPNO_PK PRIMARY KEY,
    ENMAE VARCHAR2(10),
    JOB VARCHAR2(9),
    MGR NUMBER(4),
    HIREDATE DATE,
    SAL NUMBER(7,2),
    COMM NUMBER(7,2),
    DEPTNO NUMBER(2) CONSTRAINT EMPFK2_DEPTNO_FK REFERENCES DEPT_FK(DEPTNO) ON DELETE CASCADE
    );

INSERT INTO EMP_FK2 VALUES (1000,'HONG','CLERK',7700,SYSDATE,1200,NULL,50);
--부모가 제거되면서 자식도 제거
DELETE FROM DEPT_FK df WHERE DEPTNO=50;

DROP TABLE EMP_FK2;

CREATE TABLE EMP_FK3(
    EMPNO NUMBER(4) CONSTRAINT EMPFK3_EMPNO_PK PRIMARY KEY,
    ENMAE VARCHAR2(10),
    JOB VARCHAR2(9),
    MGR NUMBER(4),
    HIREDATE DATE,
    SAL NUMBER(7,2),
    COMM NUMBER(7,2),
    DEPTNO NUMBER(2) CONSTRAINT EMPFK3_DEPTNO_FK REFERENCES DEPT_FK(DEPTNO) ON DELETE SET NULL
    );

INSERT INTO DEPT_FK VALUES (50,'DATABASE','SEOUL');
INSERT INTO EMP_FK3 VALUES (1000,'HONG','CLERK',7700,SYSDATE,1200,NULL,50);

DELETE FROM DEPT_FK WHERE DEPTNO=50;

SELECT * FROM EMP_FK3

--5) CHECK : 열에 저장할 수 있는 값의 범위 혹은 패턴 정의

CREATE TABLE TBL_CHECK(
LOGIN_ID VARCHAR2(20) PRIMARY KEY,
LOGIN_PWD VARCHAR2(20) CONSTRAINT TBLCK_PWD_CK CHECK (LENGTH(LOGIN_PWD) > 3),
TEL VARCHAR2(20));

--체크 제약조건(SCOTT.TBLCK_PWD_CK)이 위배되었습니다
INSERT INTO TBL_CHECK VALUES('TESTID1','123',NULL);

CREATE TABLE TBL_CHECK2(
LOGIN_ID VARCHAR2(20) PRIMARY KEY,
LOGIN_PWD VARCHAR2(20) CONSTRAINT TBLCK2_PWD_CK CHECK (LENGTH(LOGIN_PWD) > 3),
GRADE VARCHAR2(20) CONSTRAINT TBLCK2_GRADE_CK CHECK(GRADE IN('SILVER','GOLD','VIP')),
TEL VARCHAR2(20));

--체크 제약조건(SCOTT.TBLCK2_GRADE_CK)이 위배되었습니다
INSERT INTO TBL_CHECK2 VALUES('TESTID1','1234','DIAMOND',NULL);

--DEFAULT : 기본값 주기
CREATE TABLE TBL_DEFAULT(
LOGIN_ID VARCHAR2(20) PRIMARY KEY,
LOGIN_PWD VARCHAR2(20) DEFAULT '1234',
TEL VARCHAR2(20));

INSERT INTO TBL_DEFAULT VALUES('TESTID1', '4678', NULL);
INSERT INTO TBL_DEFAULT(LOGIN_ID,TEL) VALUES('TESTID2','010-1234-5678');
SELECT * FROM TBL_DEFAULT ;

-- 한빛마트
CREATE TABLE COMPANY(
CODE NUMBER(4) CONSTRAINT COM_CODE_PK PRIMARY KEY,
NAME VARCHAR2(20) CONSTRAINT COM_NAME_NN NOT NULL,
LOC VARCHAR2(20) CONSTRAINT COM_LOC_NN NOT NULL,
WORKER VARCHAR2(20) CONSTRAINT COM_WORKER_NN NOT NULL
);

INSERT INTO COMPANY VALUES (1000,'오리온','대전','홍길동');

CREATE TABLE PRODUCT(
PCODE NUMBER(4) PRIMARY KEY,
CODE NUMBER(4) CONSTRAINT PRO_CODE_FK REFERENCES COMPANY(CODE),
PNAME VARCHAR2(20)NOT NULL,
AMOUNT NUMBER NOT NULL,
PRICE NUMBER NOT NULL,
SUPPLY_DATE DATE NOT NULL,
SUPPLY_AMOUNT NUMBER NOT NULL
);

CREATE SEQUENCE PRODUCT_SEQ;

INSERT INTO PRODUCT (PCODE,CODE,PNAME, AMOUNT, PRICE, SUPPLY_DATE, SUPPLY_AMOUNT)
VALUES(PRODUCT_SEQ.NEXTVAL, 1000 , '초코파이',100,5500,'2024-01-02',500);

SELECT *FROM PRODUCT;

CREATE TABLE MEMBER(
   USERID VARCHAR2(20) PRIMARY KEY,
   PASSWORD VARCHAR2(30) NOT NULL,
   NAME VARCHAR2(20) NOT NULL,
   AGE NUMBER(3) CHECK(AGE > 0),
   JOB VARCHAR2(20),
   GRADE VARCHAR2(20) DEFAULT 'SILVER' CHECK(GRADE IN('SILVER','GOLD','VIP')),
   POINT NUMBER(8) DEFAULT 0
   );
  INSERT  INTO MEMBER(USERID,PASSWORD,NAME)
  VALUES('KIM123','KIM123','김지호');
  
 SELECT * FROM MEMBER;

CREATE TABLE ORDER1 (
   ORDERCODE NUMBER PRIMARY KEY,
   USERID VARCHAR2(20) CONSTRAINT ORDER1_ID_FK REFERENCES MEMBER(USERID),
   PCODE NUMBER(4) CONSTRAINT ORDER1_PCODE_FK REFERENCES PRODUCT(PCODE),
   ADDRESS VARCHAR(20) NOT NULL,
   ORDERDATE DATE DEFAULT SYSDATE,
   ORDERAMOUNT NUMBER CHECK (ORDERAMOUNT > 0)
   );

CREATE SEQUENCE ORDER_seq;
INSERT INTO ORDER1 (ORDERCODE, USERID, PCODE, ADDRESS, ORDERAMOUNT)
VALUES (ORDER_seq.NEXTVAL,'KIM123',2,'서울',1);

 SELECT * FROM ORDER1;

CREATE TABLE POST (
   POSTNUMBER NUMBER PRIMARY KEY,
   USERID VARCHAR2(20) CONSTRAINT POST_ID_FK REFERENCES MEMBER(USERID),
   POSTNAME VARCHAR2(20) NOT NULL,
   POSTCON VARCHAR2(20) NOT NULL,
   POSTDATE DATE DEFAULT SYSDATE
   );
  
CREATE SEQUENCE POST_SEQ; 
INSERT INTO POST(POSTNUMBER, USERID, POSTNAME, POSTCON)
VALUES (POST_SEQ.NEXTVAL,'KIM123','ㅇㅇ','ㅇㅇ');
 SELECT * FROM POST;


--제약조건
CREATE TABLE DEPT_FK2(
    EMPNO NUMBER(4) CONSTRAINT EMPKF_EMPNO_PK PRIMARY KEY,
    ENMAE VARCHAR2(10),
    JOB VARCHAR2(9),
    MGR NUMBER(4),
    HIREDATE DATE,
    SAL NUMBER(7,2),
    COMM NUMBER(7,2),
    DEPTNO NUMBER(2) CONSTRAINT EMPFK_DEPTNO_FK REFERENCES DEPT_FK(DEPTNO)
    ); 


   



