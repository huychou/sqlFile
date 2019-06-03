CREATE DATABASE DB_FOOD
GO

USE DB_FOOD
GO

---- table FoodCategory
CREATE TABLE FoodCategory (
	id_FC int identity primary key,
	name_FC nvarchar(100) not null
)
 GO

 ----- table Food
 CREATE TABLE Food (
	id_F int identity primary key,
	name_F nvarchar(100) not null,
	price float not null,
	id_FC int not null,
	foreign key (id_FC) references FoodCategory(id_FC)
	)
 GO


 -----table FoodTable
  CREATE TABLE FoodTable (
	id_Table int identity primary key,
	name_Table nvarchar(100) not null,
)
 GO

 ---- table TypeUser
CREATE TABLE TypeUser (
	id_Type int identity primary key,
	name_Type nvarchar(100) not null
)
 GO

 ---- table user
CREATE TABLE [User] (
	id_User int identity primary key,
	name_User nvarchar(100) not null,
	id_Type int not null,
	foreign key (id_Type) references TypeUser(id_Type)

)
 GO

 ---- table Bill
CREATE TABLE Bill (
	id_Bill int identity primary key,
	totalPrice float not null,
	id_Table int not null,
	id_User int not null,
	foreign key (id_Table) references FoodTable(id_Table),
	foreign key (id_User) references [User](id_User)

)
 GO

 ---- table DetailBill 
 CREATE TABLE DetailBill (
	number int not null,
	id_Bill int not null,
	id_F int not null,	
	foreign key (id_Bill) references Bill(id_Bill),
	foreign key (id_F) references Food(id_F)

)
 GO
