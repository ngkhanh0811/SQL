create database Test01
create table Student (
SinhVien varchar(40),
NgaySinh date,
Lop varchar(40)
)
GO

insert into Student(SinhVien, NgaySinh, Lop) values ('Nguyễn Bá Khánh','2003-11-08', 'T2109M')
delete from Student where SinhVien = 'Vũ Viết Quý'
update Student set SinhVien = 'Vũ Viết Quý' where SinhVien = 'Nguyễn Bá Khánh'

select * from Student