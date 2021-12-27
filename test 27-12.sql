create database Coffee
go

use Coffee
create table Country(
Countries nvarchar(100) primary key,
)

insert into Country values
(N'VietNam'),
(N'Japan'),
(N'Korea')

create table City (
Countries nvarchar(100) foreign key (Countries) references Country(Countries),
Cities nvarchar(100) primary key
)

insert into City values
(N'VietNam', N'Hà Nội'),
(N'VietNam', N'Hồ Chí Minh'),
(N'VietNam', N'Thái Nguyên')

create table Village (
Cities nvarchar(100) foreign key (Cities) references City(Cities),
Villages nvarchar(100) primary key
)

insert into Village values
(N'Hà Nội', N'Thanh Trì'),
(N'Hà Nội', N'Văn Phú'),
(N'Hà Nội', N'Đông Anh'),
(N'Hồ Chí Minh', N'Quận 1'),
(N'Hồ Chí Minh', N'Quận 7'),
(N'Hồ Chí Minh', N'Quận 8')

create table Extension (
Villages nvarchar(100) foreign key (Villages) references Village(Villages),
Extensions nvarchar(100)
)

insert into Extension values 
(N'Văn Phú', N'Wifi'),
(N'Quận 7', N'Banking, VNPay')

select * from Country
select * from City
select * from Village
select * from Extension