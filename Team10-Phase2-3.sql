-- Type 1: A single-table query => Selection + Projection
    -- 동아리 지원서에서 합격한 원서의 정보
select * from apply where Apass like 'Y';

    -- IT대학의 학생들의 정보
select * from student where scollege like 'IT대학';

-- Type 2: Multi-way join with join predicates in WHERE

    -- 동아리에 가입한 사람의 학번, 이름, 가입한 동아리명을 출력하는 쿼리.
select s.snumber, s.sname, c.cname 
from student s, club c, member m 
where s.snumber = m.sno and m.cno = c.cnumber;

    -- 동아리에 지원해서 합격한 사람의 이름과 학번을 출력
select s.sname, s.snumber 
from apply a, student s 
where Apass like 'Y' and a.sno = s.snumber;

-- Type 3
    -- 동아리를 지원한 학생이면서 특정 동아리에 속해있는 학생들을 성별별로 몇명이 속해있는지 출력하시오.
SELECT SSEX, COUNT(*)
FROM student
WHERE (STUDENT.SNUMBER, SNAME, SSEX) IN (SELECT DISTINCT STUDENT.SNUMBER, SNAME, SSEX
                                        FROM (STUDENT JOIN APPLY ON STUDENT.SNUMBER = APPLY.SNO) JOIN MEMBER ON MEMBER.SNO = STUDENT.SNUMBER)
GROUP BY SSEX;
    
    -- 동아리에 지원서를 낸 동아리를 가진 동아리원에 대해 동아리 종류별로 몇명 존재하는지 출력하시오. (중복 지원서 허용)
SELECT CCOLLEGE, COUNT(*)
FROM (APPLY JOIN MEMBER ON APPLY.SNO = MEMBER.SNO) JOIN CLUB ON CLUB.CNUMBER = APPLY.CNO
GROUP BY CCOLLEGE;

-- Type 4
    -- 동아리에 속해있는 학생의 모든정보를 출력하시오.
SELECT *
FROM student
WHERE student.snumber IN ( SELECT sno FROM member);

    -- 현재 합격/불합격 대기중인 지원서의 학생정보를 출력하시오.
SELECT *
from student
WHERE student.snumber IN (SELECT apply.sno FROM apply WHERE apass IS NULL);

-- Type 5: EXISTS를 포함하는 Subquery (e.g. TPC-H Q4)
    -- 18학번 학생이 멤버로 있는 동아리의 이름과 동아리넘버
select distinct c.cname, c.cnumber 
from club c
where exists(
    select *
    from member m
    where c.cnumber = m.cno
    and m.sno like '2018%'
);

    -- 지원서를 받은적 없는 동아리의 이름과 동아리 넘버
select distinct c.cname, c.cnumber
from club c
where not exists(
    select *
    from apply a
    where c.cnumber = a.cno
);

-- Type 6
    -- 학부가 전자공학부인 학생들의 지원_ID와 학번, 동아리 이름 그리고 합불 여부를 출력하세요.
SELECT ANUMBER, APPLY.SNO, CLUB.CNAME, APPLY.APASS
FROM APPLY, CLUB
WHERE APPLY.CNO = CLUB.CNUMBER
AND APPLY.SNO IN (SELECT STUDENT.SNUMBER
                        FROM STUDENT
                        WHERE SDEPARTMENT = '전자공학부');

    -- 댓글의 답글을 단 학생들의 이름과 그들이 낸 지원서 내용과 지원서 번호를 출력하시오.
SELECT ANUMBER, SNAME, ACONTENT
FROM STUDENT, APPLY
WHERE APPLY.SNO = STUDENT.SNUMBER
AND (STUDENT.SNUMBER, SNAME) IN (SELECT DISTINCT SNUMBER, SNAME
                                FROM STUDENT, REPLY
                                WHERE STUDENT.SNUMBER = REPLY.SNO);

-- Type 7:
    -- '에이밍' 동아리에 가입한 학생의 이름, 가입날짜를 출력하시오.
    SELECT sname,m.mstart_date
    FROM student s, 
    (SELECT mstart_date,sno FROM member,club 
    WHERE club.cnumber=member.cno and club.cname='에이밍')m
    where m.sno=s.snumber;

    -- '에이밍' 동아리의 리뷰를 작성한 학생의 이름과 리뷰내용을 출력하시오.
    SELECT sname,rcontent
    FROM student s, 
    (SELECT r.rcontent,c.cname,r.sno
    FROM review r,club c
    WHERE cname='에이밍' and cnumber=cno)re
    WHERE s.snumber=re.sno;
    

-- Type 8: Multi-way join with join predicates in WHERE + ORDER BY (e.g. TPC-H Q2)

    -- '싸커'동아리에 속한 멤버의 이름과 학번을 학번의 오름차순으로 정렬
select s.sname, s.snumber
from student s, club c, member m
where c.cname like '싸커'
and  c.cnumber = m.cno
and m.sno = s.snumber
order by s.snumber asc;

    -- 각 동아리의 부장의 학번, 이름, 동아리명을 동아리명의 오름차순으로 정렬
select s.snumber, s.sname, c.cname
from student s, club c, member m
where m.mposition like '부장'
and m.sno = s.snumber
and m.cno = c.cnumber
order by c.cname;

-- Type 9
    -- 지원서를 낸 학생들이 적은 단대별 리뷰 평점의 평균을 구하고 평균을 기준으로 내림차순. (같은 사람이 적은 2개 이상의 리뷰 허용)
SELECT SCOLLEGE, ROUND(AVG(RRATING),1) AS AVG_OF_RATING
FROM (STUDENT JOIN REVIEW ON REVIEW.SNO = STUDENT.SNUMBER) JOIN APPLY ON APPLY.SNO = STUDENT.SNUMBER
GROUP BY SCOLLEGE
ORDER BY AVG_OF_RATING DESC;

    -- 리뷰에 달린 댓글에 달린 답글 개수가 2개보다 많은 리뷰의 답글 개수와 각 리뷰의 RATING 최고점을 구하여 RATING 기준 내림차순하라.
SELECT RNUMBER, COUNT(*), MAX(RRATING) AS MAX_RATE
FROM REVIEW, COMMENTT, REPLY
WHERE RNO = RNUMBER AND TNUMBER = TNO
GROUP BY RNUMBER
HAVING COUNT(*) > 2
ORDER BY MAX_RATE DESC;

--TYPE 10
    -- '에이밍' 동아리와 '싸커' 동아리 학생의 학번,이름,동아리이름을 출력하시오
SELECT s.sname, s.snumber, c.cname
FROM student s, club c, member m
WHERE m.sno=s.snumber and c.cname='에이밍' and c.cnumber=m.cno
UNION
SELECT s.sname, s.snumber, c.cname
FROM student s, club c, member m
WHERE m.sno=s.snumber and c.cname='싸커' and c.cnumber=m.cno;

    --댓글 작성이력이 있으면서 현재 어떤동아리에 속해있는 학생의 정보 출력하시오.
SELECT s.*
FROM student s, commentt t
WHERE s.snumber=t.sno
INTERSECT
SELECT s.*
FROM student s, member m
WHERE s.snumber=m.sno;
