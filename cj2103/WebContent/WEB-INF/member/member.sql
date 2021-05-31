show tables;

create table member (
  idx		  int		not null auto_increment,	/* 회원 고유번호 */
  mid		  varchar(20) not null,						/* 회원 아이디(중복불허) */
  pwd      varchar(50) not null,								/* 비밀번호(입력시 9자로 제한처리) */
  pwdKey   int   not null,						/* 해시키 */
  nickName varchar(20) not null,				/* 별명(중복불허) */
  name     varchar(20) not null,						/* 회원성명 */
  gender   varchar(10) default '남자',			/* 성별 */
  birthday datetime  default now(),			/* 생일 */
  tel		  varchar(15),										/* 연락처 */
  address  varchar(50),									/* 주소 */
  email	  varchar(50) not null,					/* 이메일(아이디/비밀번호 분실시 필요) */
  homePage varchar(50),									/* 홈페이지(블로그)주소 */
  job		  varchar(20),									/* 직업 */
  hobby	  varchar(50),									/* 취미 */
  userInfor char(6) default '공개',			/* 회원 정보 공개여부 */
  userDel   char(2) default 'NO',				/* 회원 탈퇴신청 여부(Ok:탈퇴신청한회원, NO:현재 가입중인회원) */
  level			int default 1,							/* 0:관리자, 1:준회원, 2:정회원, 3:우수회원 */
  visitCnt  int default 0,							/* 방문횟수 */
  startDate datetime default now(),			/* 최초 가입일 */
  lastDate  datetime default now(),			/* 마지막 접속일 */
  primary key(idx, mid)									/* 기본키 : 고유번호, 아이디 */
);
desc member;

insert into member values (default,'admin','1234','관리맨','관지자',default,default,'010-3423-2704','경기도 안성시','cjsk1126@naver.com','blog.daum.net/cjsk1126','회사원','등산',default,default,0,default,default,default);

select * from member;

/* 해시테이블(비밀번호 키/값)) */
create table hashTable(
  pwdKey    int not null,
  pwdValue  varchar(30) not null
);
insert into hashTable values (0,'12341234');
insert into hashTable values (1,'23452345');
insert into hashTable values (2,'34563456');
insert into hashTable values (3,'45674567');
insert into hashTable values (4,'56785678');
insert into hashTable values (5,'67896789');
insert into hashTable values (6,'78907890');
insert into hashTable values (7,'12121212');
insert into hashTable values (8,'23232323');
insert into hashTable values (9,'34343434');
insert into hashTable values (10,'45454545');
insert into hashTable values (11,'56565656');
insert into hashTable values (12,'67676767');
insert into hashTable values (13,'78787878');
insert into hashTable values (14,'89898989');
insert into hashTable values (15,'90909090');
insert into hashTable values (16,'21212121');
insert into hashTable values (17,'32323232');
insert into hashTable values (18,'43434343');
insert into hashTable values (19,'54545454');
