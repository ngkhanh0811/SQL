USE AdventureWorks2019
SELECT * FROM HumanResources.Employee
WHERE JobTitle = 'Design Engineer'

USE AdventureWorks2019
SELECT SalesOrderID, CustomerID, SalesPersonID, TerritoryID, YEAR (OrderDate) AS 
CurrentYear, YEAR (OrderDate) +1 AS NextYear
FROM Sales.SalesOrderHeader

IF DATENAME(WEEKDAY, GETDATE()) IN (N'Saturday', N'Sunday')
SELECT 'It is a Weekend';
ELSE 
SELECT 'It is a Weekday';

USE AdventureWorks2019
--Gọi tên các dòng trong Employee của file HumanResources
/*Cách để chú thích nhiều 
hơn một dòng*/
SELECT * FROM HumanResources.Employee

USE AdventureWorks2019
SELECT * FROM HumanResources.Employee
GO

USE AdventureWorks2019
GO 
SELECT ProductID
FROM Production.Product
INTERSECT
SELECT ProductID
FROM Production.WorkOrder;

USE AdventureWorks2019
SELECT SalesPersonID, YEAR(OrderDate) AS OrderYear FROM
Sales.SalesOrderHeader
WHERE CustomerID=30084
GROUP BY SalesPersonID, YEAR(OrderDate)
HAVING COUNT(*) >1 
ORDER BY SalesPersonID, OrderYear;

CREATE DATABASE Customer_DB ON PRIMARY
( NAME = 'Customer_DBX', FILENAME = 'C:\\Program Files\\Microsoft SQL Sever\\MSSQL15.SQLEXPRESS\\MSSQL\\DATA\\Customer_DB.mdf')
LOG ON 
( NAME = 'Customer_DB_log', FILENAME = 'C:\\Program Files\\Microsoft SQL Sever\\MSSQL15.SQLEXPRESS\\MSSQL\\DATA\\Customer_DB_log.ldf')
COLLATE SQL_Latin1_General_CP1_CI_AS

ALTER DATABASE Customer_DB MODIFY NAME = CUST_Database

USE CUST_Database
EXEC sp_changedbowner 'sa'

USE CUST_Database
ALTER DATABASE CUST_Database SET AUTO_SHRINK ON

USE CUST_Database
ALTER DATABASE CUST_Database
ADD FILEGROUP FG_ReadyOnly

USE CUST_Database
ALTER DATABASE CUST_Database
ADD FILE (NAME = Cust_DB1, FILENAME ='C:\Program Files\Microsoft SQL Sever\MSSQL15.SQLEXPRESS\MSSQL\DATA\Cust_DB1.ndf')
TO FILEGROUP FG_ReadyOnly ALTER DATABASE CUST_Database
MODIFY FILEGROUP FG_ReadyOnly DEFAULT

USE CUST_DB
CREATE TABLE Menu (
TenDoUong varchar(40) NOT NULL,
SoLuong int NOT NULL ,
Price money NOT NULL DEFAULT (100) 
)


IF EXISTS (SELECT * FROM sys.databases WHERE Name='Example5')
DROP DATABASE Example5 
GO
CREATE DATABASE Example5 
GO 

--Tạo bảng Lớp Học
CREATE TABLE LopHoc (
MaLopHoc INT PRIMARY KEY IDENTITY,
TenLopHoc VARCHAR (10)
)

--Tạo bảng Sinh Viên với Mã Lớp Học là khóa phụ cho bảng sinh viên, trường Mã Lớp Học nằm bên trong, tham chiếu đến trường lớp học 
Create table SinhVien(
MaSV int PRIMARY KEY,
TenSV varchar(40),
MaLopHoc int,
constraint fk foreign key (MaLopHoc) references LopHoc (MaLopHoc) 
)

--Tạo bảng sản phẩm
create table SanPham (
MaSP int NOT NULL,
TenSP varchar(40) NULL
)
GO

--Tạo bảng Store với thuộc tính default cho cột Price
create table StoreProduct (
ProductID int NOT NULL,
Name varchar(40) NOT NULL,
Price money NOT NULL DEFAULT (100) 
)

--Kiểm tra giá trị default có hoạt động hay không
INSERT INTO StoreProduct (ProductID, Name) values (111, Rivets)
GO

--Tạo bảng ContactPhone với thuộc tính identity, sử dụng kiểu dữ liệu int và bigint
create table ContactPhone (
Person_ID int identity (500, 1) NOT NULL,
MobileNumber bigint NOT NULL
)
GO

--Tạo bảng CellularPhone với thuộc tính uniquidentifier -> tạo cột nhận dạng duy nhất tổng thể 
create table CellularPhone (
Person_ID uniqueidentifier DEFAULT NEWID () NOT NULL ,
PersonName varchar (60) NOT NULL 
)

--Chèn thêm dữ liệu Wiliam Smitch vào cột PersonName trong bảng CellularPhone
insert into CellularPhone(PersonName) values ('Wiliam Smitch')
GO

--Kiểm tra bảng CellularPhone
select * from CellularPhone
GO 

--Tạo bảng ContactPhone với cột MobileNumber có thuộc tính UNIQUE (các dữ liệu trong cột phải khác nhau)
create table ContactPhone (
Person_ID int PRIMARY KEY,
MobileNumber bigint UNIQUE,
ServiceProvider varchar(30),
LandlineNumber bigint UNIQUE 
)

--Chèn thêm hai giá trị 
insert into ContactPhone values	(101, 97159715, 'Hutch', NULL)
insert into ContactPhone values (102, 93463466, 'Akkey', NULL)
GO 

select * from ContactPhone
GO

--Tạo bảng PhoneExpress với khóa phụ MobileNumber tham chiếu đến trường ContactPhone trong bảng PhoneExpress
create table PhoneExpress (
Expense_ID int primary key,
MobileNumber bigint foreign key references ContactPhone (MobileNumber),
Amount bigint check (Amount > 0)
)
GO

--Chỉnh sửa cột trong bảng :
alter table ContactPhone 
alter column ServiceProvider varchar(45)
GO

--Xóa cột trong bảng :
alter table ContactPhone 
drop column ServiceProvider 
GO

-- Thêm một ràng buộc vào trong bảng 
alter table ContactPhone add constraint CHK_RC check (RentalCharges > 0)
GO

--Xóa một ràng buộc
alter table Person.ContactPhone
drop constraint CHK_RC
GO

create database BookLibrary

--Bài làm

--EX1
--a
use BookLibrary 
create table Book (
BookCode int NOT NULL,
BookTitle varchar(100) NOT NULL,
Author varchar(50) NOT NULL,
Edition int,
BookPrice money,
Copies int,
constraint pk_book primary key (BookCode)
)
GO

--b
create table Member (
MemberCode int NOT NULL,
Name_member varchar(50) NOT NULL,
Address_member varchar(100) NOT NULL,
PhoneNumber int,
constraint pk_membercode primary key (MemberCode)
)
GO

--c
create table IssueDetails (
BookCode int,
MemberCode int,
IssueDate datetime,
ReturnDate datetime,
constraint fk_book foreign key (BookCode) references Book(BookCode),
constraint fk_member foreign key (MemberCode) references Member(MemberCode),
)
GO

--EX2

use BookLibrary
--a

alter table IssueDetails
drop constraint fk_member, fk_book

--b
alter table Book
drop constraint pk_book
alter table Member
drop constraint pk_membercode

--c
alter table Member
add constraint pk_membercode primary key(MemberCode)
alter table Book
add constraint pk_book primary key(BookCode)

--d
alter table IssueDetails
add constraint fk_member foreign key (MemberCode) references Member(MemberCode)
alter table IssueDetails
add constraint fk_book foreign key (BookCode) references Book(BookCode)

--e 
alter table Book
add constraint check_price check (BookPrice>0 AND BookPrice<200)

--f
alter table Member
add constraint unique_PhoneNumber unique(PhoneNumber)

--g
alter table Book
alter column BookCode int NOT NULL

alter table Member
alter column MemberCode int NOT NULL

--h
insert into Book (BookCode, BookTitle, BookPrice, Author, Edition, Copies) values (1, 'Cách để trở thành "Đứa con của biển"', 20.000, 'Nguyễn Khánh', 1, 2)
insert into Member (MemberCode, Name_member, Address_member, PhoneNumber) values (1, 'Nguyễn Khánh', 'Thanh Cao - Thanh Oai - Hà Nội', 0987729543)
insert into IssueDetails (BookCode, MemberCode) values (1, 1)

select * from Member
select * from Book
select * from IssueDetails




