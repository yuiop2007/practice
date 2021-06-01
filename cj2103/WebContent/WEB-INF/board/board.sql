/* board.sql */
create table board (
  idx		int not null auto_increment,		/* 게시글의 고유번호 */
  name  varchar(20)  not null,					/* 게시글 올린사람의 닉네임 */
  title varchar(100) not null,					/* 게시글의 글 제목 */
  email varchar(50)  not null,					/* 이메일 */
  pwd 	varchar(100)	not null,					/* 비밀번호 */
  wDate datetime	 default now(),				/* 글쓴날짜 */
  readNum int		default 0,							/* 글 조회수 */	
  hostIp	varchar(50) not null,					/* 접속 IP주소 */
  good		int 	default 0,							/* 좋아요 */
  content text  not null,								/* 게시글 내용 */
  primary key(idx)											/* 기본키는 고유번호 */
);

desc board;

insert into board values (default,'관리맨','게시판 서비스를 시작합니다.','cjsk1126@hanmail.net','1234',default,default,'218.236.203.146',default,'게시판 서비스 개시.. 잘 부탁드립니다.');

select * from board;
