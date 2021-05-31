show tables;

create table user (
  idx  int  not null auto_increment primary key,
  name varchar(20) not null,
  age  int default 20
);

insert into user values (default, '홍길동', default);
insert into user values (default, '김말숙', 25);

select * from user order by idx desc;
