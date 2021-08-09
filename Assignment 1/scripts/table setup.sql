create table book (
	isbn varchar(17),
    book_title varchar(45),
    book_author varchar(45),
    book_genre varchar(45),
    year_published integer(4),
	primary key (isbn)
);

create table member (
	member_id integer(4),
    mem_lname varchar(45),
    mem_fname varchar(45),
    mem_initial varchar(4),
    mem_phone varchar(10),
    primary key (member_id)
);

create table borrowed (
	borrowed_id integer(4),
    isbn varchar(17),
    member_id integer(4),
    taken_date date,
    primary key (borrowed_id),
    foreign key (isbn) references book(isbn),
    foreign key (member_id) references member(member_id)
);

select * from book;
select * from `member`;
select * from borrowed;

