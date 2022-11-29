-- drop table
DROP TABLE STUDENT CASCADE CONSTRAINT;
DROP TABLE CLUB CASCADE CONSTRAINT;
DROP TABLE MEMBER CASCADE CONSTRAINT;
DROP TABLE APPLY CASCADE CONSTRAINT;
DROP table Reply;
DROP table Review CASCADE CONSTRAINT;
drop table commentt;

-- create table
CREATE TABLE STUDENT 
( -- 학번(PK) / 단대 / 이메일 / 비밀번호 / 전화번호 / 이름 / 성별 / 학부 / ID
    Snumber varchar(10) not null,
    Scollege varchar(20) not null,
    Semail varchar(30) not null,
    Spassword varchar(20) not null,
    Sphone varchar(11) not null,
    Sname varchar (20) not null,
    Ssex char,
    Sdepartment varchar(20) not null,
    Sidentifier varchar(20) not null,
    primary key(Snumber),
    unique(Semail),
    unique(Sphone),
    unique(Sidentifier)
);


CREATE TABLE CLUB
( -- 동아리 ID(PK) / 개설 날짜 / 이름 / 종류 / 타입 / 지원양식
    Cnumber	NUMBER		NOT NULL,
    Cstart_date	DATE,
    Cname	VARCHAR(15)	NOT NULL,
    Ccollege	VARCHAR(10)	NOT NULL,
    Ctype		VARCHAR(15)	NOT NULL,
    Cform		VARCHAR(100),	
    PRIMARY KEY(Cnumber)
);


CREATE TABLE MEMBER
( -- 동아리 멤버 ID(PK) / 동아리 ID(FK) / 학번(FK) / 직위 / 가입일 / 탈퇴일
    Mnumber		NUMBER		NOT NULL,
    Cno		NUMBER		NOT NULL,
    Sno     VARCHAR(10) NOT NULL,
    Mposition		VARCHAR(10),
    Mstart_date		DATE		NOT NULL,
    PRIMARY KEY(Mnumber),
    FOREIGN KEY(CNO) REFERENCES CLUB(Cnumber) ON DELETE CASCADE,
    FOREIGN KEY(SNO) REFERENCES STUDENT(Snumber) ON DELETE CASCADE
);


CREATE TABLE APPLY
( -- 지원 ID(PK) / 학번(PK,FK) / 동아리 ID(PK,FK) / 내용 / 합불
    Anumber		NUMBER		NOT NULL,
    Sno		VARCHAR(10)	NOT NULL,
    Cno		NUMBER		NOT NULL,
    Acontent		VARCHAR(150),
    Apass			CHAR(1),
    PRIMARY KEY(Anumber, Sno, Cno),
    FOREIGN KEY(SNO) REFERENCES STUDENT(Snumber) ON DELETE CASCADE,
    FOREIGN KEY(CNO) REFERENCES CLUB(Cnumber) ON DELETE CASCADE
);

CREATE TABLE Review
( -- 리뷰 ID(PK) / 별점 / 내용 / 제목 / 게시날짜 / 클럽 ID(FK) / 학번(FK)
    Rnumber NUMBER NOT NULL,
    Rrating NUMBER(2,1) NOT NULL,
    Rcontent VARCHAR(100) NOT NULL,
    Rtitle VARCHAR(60) NOT NULL,
    Rdate DATE,
    Cno NUMBER NOT NULL,
    Sno VARCHAR(10) NOT NULL,
    PRIMARY KEY(Rnumber),
    FOREIGN KEY (CNO) REFERENCES CLUB(Cnumber)on Delete Set Null,
    FOREIGN KEY (SNO) REFERENCES student(Snumber)on Delete Set Null
);

CREATE TABLE Commentt
( -- 댓글 ID(PK) / 리뷰 ID(FK) / 학번(FK) / 내용 / 게시날짜
    Tnumber NUMBER NOT NULL,
    Rno NUMBER NOT NULL,
    Sno VARCHAR(10) NOT NULL,
    Tcontent VARCHAR(100) NOT NULL,
    Tdate DATE,
    PRIMARY KEY(Tnumber),
    FOREIGN KEY (RNO) REFERENCES REVIEW(Rnumber)on Delete Set Null,
    FOREIGN KEY (SNO) REFERENCES student(Snumber)on Delete Set Null
);

CREATE TABLE REPLY
( -- 답글 ID(PK) / 내용 / 게시날짜 / 학번(FK) / 댓글 ID(FK)
    Dnumber NUMBER NOT NULL,
    Dcontent VARCHAR(100) NOT NULL,
    Ddate DATE,
    Sno VARCHAR(10) NOT NULL,
    Tno NUMBER NOT NULL,
    PRIMARY KEY(Dnumber),
    FOREIGN KEY (TNO) REFERENCES COMMENTT(Tnumber)on Delete Set Null,
    FOREIGN KEY (SNO) REFERENCES student(Snumber)on Delete Set Null
);