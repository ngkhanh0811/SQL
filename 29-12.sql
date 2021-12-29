create database qlsv
go

--Tạo bảng danh sách lớp  học
use qlsv
create table LopHoc(
TenLop nvarchar(100) primary key,
)
go

--Thêm danh sách lớp học cho bảng lớp học :
insert into LopHoc values
(N'T2109M'),
(N'T2109A'),
(N'T2108M'),
(N'T2107A'),
(N'T2107M'),
(N'T2106M')

--Tạo bảng danh sách sinh viên, mã sinh viên là khóa chính, tên lớp và mã môn là khóa phụ
create table SinhVien(
MaSV nvarchar(40) primary key,
TenSV nvarchar(100),
NgaySinh date,
DiaChi nvarchar(100),
TenLop nvarchar(100) foreign key (TenLop) references LopHoc(TenLop),
TenMon nvarchar(100),
MaMon nvarchar(50)
)
go

--Thêm thông tin cho bảng sinh viên
insert into SinhVien(MaSV, TenSV, NgaySinh, DiaChi, TenLop, TenMon) values
(N'TH2109011', N'Nguyễn Bá Khánh', '2003-11-08', N'Hà Nội', N'T2109M', N'HCJS'),
(N'TH2109012', N'Đinh Quang Anh', '1999-7-13', N'Ninh Bình', N'T2109M', N'DBS'),
(N'TH2109013', N'Vũ Viết Quý', '2003-2-10', N'Thái Bình', N'T2109M', N'DDM'),
(N'TH2109014', N'Tạ Duy Linh', '2003-12-21', N'Thái Nguyên', N'T2109M', N'LBEP')

--Bổ sung khóa phụ mã môn sau khi tạo bảng danh sách sinh viên
alter table SinhVien
add constraint MaMon foreign key (MaMon) references MonHoc(MaMon)

--Tạo bảng danh sách môn học với mã môn là khóa chính, mã sinh viên là khóa phụ
create table MonHoc(
PhongHoc nvarchar(100),
MaMon nvarchar(50) primary key,
TenMon nvarchar(100),
SoTiet int,
MaSV nvarchar(40) foreign key (MaSV) references SinhVien(MaSV)
)
go
insert into MonHoc values
(N'1B', N'LBEP1', N'LBEP', 15, N'TH2109011'),
(N'4B', N'DDM2', N'DDM', 13, N'TH2109012'),
(N'3A', N'HCJS2', N'HCJS', 16, N'TH2109013'),
(N'2A', N'DBS1', N'DBS', 8, N'TH2109014')

update SinhVien
set MaMon = 'HCJS1' where MaSV = 'TH2109011'
set MaMon = 'DBS1' where MaSV = 'TH2109012'
set MaMon = 'DDM2' where MaSV = 'TH2109013'
set MaMon = 'LBEP1' where MaSV = 'TH2109014'

--Hiển thị danh sách số tiết, sinh viên, tên các môn học
select MonHoc.SoTiet, SinhVien.TenSV, MonHoc.TenMon
from SinhVien
inner join MonHoc on SinhVien.TenMon = MonHoc.TenMon

--Hiển thi danh sách học sinh đăng kí học môn HCJS
select TenSV, NgaySinh, DiaChi, TenLop
from SinhVien
where TenMon = 'HCJS'

--Hiển thị danh sách học sinh trong lớp T2109M
select TenSV 
from SinhVien
where TenLop = 'T2109M'

select * from SinhVien
select * from LopHoc
select * from MonHoc