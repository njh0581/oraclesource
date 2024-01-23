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

--2017-01-01 ~ 2017-12-31 사이에 고용도니 사람ㄷ르의 











