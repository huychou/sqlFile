create table [User] (
	ID int primary key identity,

	Name nvarchar(50),
	Age nvarchar(50),
	id_r nvarchar(50),
	foreign key (id_r) references Role(id_r)

);
----------------\
insert into [User] (Name, Age, id_r) values('An', '20', 'ab');