/* guest.sql(방명록) */
create table guest (
	idx		int not null auto_increment primary key,	/* 방명록 고유번호 */
	name 	varchar(20) not null,				/* 방문자 성명 */
	email varchar(60),								/* 이메일 주소 */
	homepage varchar(60),							/* 홈페이지 주소 */
	vdate datetime default now(),			/* 방문일자 */
	hostip varchar(50) not null,			/* 방문자 IP */
	content  text not null						/* 방문소감 */
);

desc guest;

insert into guest values (default,'관리자','cjsk1126@naver.com','http://blog.daum.net/cjsk1126',default,'218.236.203.146','방명록 서비스를 시작합니다.');
insert into guest values (default,'나그네','','',default,'192.168.0.10','잠시 들러갑니다.');

delete from guest;

select * from guest order by idx desc;
