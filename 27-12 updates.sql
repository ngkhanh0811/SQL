create database CoffeeUp
go

use CoffeeUp
create table Country(
Countries int primary key,
CountryName nvarchar(100)
)

insert into Country values
(1, N'VietNam'),
(2, N'Japan'),
(3, N'Korea')

create table City (
Countries int foreign key (Countries) references Country(Countries),
CityName nvarchar(100),
CityID int primary key
)

insert into City values
(1, N'Hà Nội', 10),
(1, N'Hồ Chí Minh', 20),
(1, N'Thái Nguyên', 30)

create table District (
CityID int foreign key (CityID) references City(CityID),
Districts nvarchar(100),
DistrictID nvarchar(100) primary key
)

insert into District values
(10, N'Thanh Trì', '10X1'),
(10, N'Văn Phú', '10X2'),
(10, N'Đông Anh', '10X3'),
(20, N'Quận 1', '20X1'),
(20, N'Quận 7', '20X7'),
(20, N'Quận 8', '20X8')

create table Detail (
DistrictID nvarchar(100) foreign key (DistrictID) references District(DistrictID),
DetailsName nvarchar(100),
DetailsID nvarchar(40) primary key,
)

insert into Detail values 
(N'10X1', N'Số 12 - Thanh Trì', N'10X1-12'),
(N'20X1', N'Số 36 - Quận 1', N'20X1-36'),
(N'20X7', N'Số 72 - Quận 7', N'20X7-72')

create table Extension (
DetailsID nvarchar(40) foreign key (DetailsID) references Detail(DetailsID),
Extensions nvarchar(100)
)

insert into Extension values 
(N'10X1-12', N'Wifi'),
(N'20X1-36', N'Banking, VNPay'),
(N'20X7-72', N'Wifi, Banking, VNPay')

select * from Country
select * from City
select * from District
select * from Detail
select * from Extension