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

create table Extension (
DistrictID nvarchar(100) foreign key (DistrictID) references District(DistrictID),
Extensions nvarchar(100)
)

insert into Extension values 
('10X1', N'Wifi'),
('20X7', N'Banking, VNPay')

select * from Country
select * from City
select * from District
select * from Extension