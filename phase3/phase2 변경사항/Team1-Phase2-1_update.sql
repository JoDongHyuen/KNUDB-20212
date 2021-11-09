drop table customer cascade constraint;
drop table store cascade constraint;
drop table cust_books_str cascade constraint;
drop table rating cascade constraint;
drop table food cascade constraint;
drop table origin cascade constraint;
drop table beverage cascade constraint;
drop table owner cascade constraint;
drop table information cascade constraint;


create table customer(
    Fname varchar2(2),
    Lname varchar2(4),
    Phone_number varchar2(15),
    Customer_email varchar2(50) not null primary key, 
    Sex varchar2(10) not null,
    Age number not null
);

create table store(
    Breg_number number not null primary key,
    Store_name varchar2(40) not null,
    Store_type varchar2(20),
    Seat_number number not null,
    Location varchar2(70) not null
);

create table cust_books_str(
    Cemail varchar2(50) not null references customer(Customer_email),
    Bnum number not null references store(Breg_number),
    Time date not null,
    constraint pk_cust_books_str primary key(Cemail, Bnum)
);

create table rating(
    Bnum number not null references store(Breg_number),
    Cemail varchar2(50) not null references customer(Customer_email),
    Score number(2,1),
    Id number not null,
    constraint pk_rating primary key(Bnum, Cemail, Id)
);

create table food(
    Bnum number not null references store(Breg_number),
    Id number primary key,
    Price number not null,
    Food_name varchar2(50) not null
);

create table origin(
    Id number not null references food(Id),
    Country_name varchar2(20),
    constraint pk_origin_country primary key(Id, Country_name)
);

create table beverage(
    Bnum number not null references store(Breg_number),
    Id number not null,
    Alcohol varchar2(2),
    Drink_name varchar2(30) not null,
    Price number not null,
    constraint pk_beverage primary key(Bnum, Id)
);

create table owner(
    Bnum number not null references store(breg_number),
    Fname varchar2(2),
    Lname varchar2(4),
    Phone_number varchar2(15),
    Owner_email varchar2(50) not null unique,
    Sex varchar2(10) not null,
    Age number not null, 
    constraint pk_owner primary key(Bnum, Owner_email)
);

create table information(
	Email	varchar2(20) not null primary key,
	Pass_word	varchar2(15) not null,
	Type_of_P	varchar2(10)
);

alter table Customer add foreign key (Customer_email) references information(Email);
alter table Owner add foreign key (Owner_email) references information(Email);

