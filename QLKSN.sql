--drop table SUDUNG, DICHVU, DAT ,PHONG, DATPHONG, HOADON, KHACHHANG, NHANVIEN,CHUCVU

create table CHUCVU
(
   MACHUCVU varchar(10)not null primary key,
   TENCHUCVU nvarchar(30)
)

create table NHANVIEN(
   MANHANVIEN varchar(10) not null primary key,
   MACHUCVU varchar(10) foreign key references CHUCVU,
   TENNHANVIEN nvarchar(30),
   GIOITINH nvarchar(3) CHECK (GIOITINH IN ('NAM', N'NỮ')),
   NGAYSINH datetime,
   DIACHI nvarchar(50),
   SDT char(10) check (len(SDT) = 10)
   
)

create table KHACHHANG(
    MAKHACHHANG varchar(10) not null primary key,
	TENKHACHHANG nvarchar(30),
	GIOITINH nvarchar(3) CHECK (GIOITINH IN ('NAM', N'NỮ')),
	CCCD varchar(12) check (len(CCCD) = 12),
	SDT char(10) check (len(SDT) = 10),
	QUOCTICH nvarchar(20)
)
create table HOADON(
   MAHOADON varchar(10) not null primary key,
   MANHANVIEN varchar(10) foreign key references NHANVIEN,
   MAKHACHHANG varchar(10)  foreign key references KHACHHANG,
   NGAYTHANHTOAN datetime,
   TINHTRANG varchar(30),
   TONGTIEN int not null default 0,
)

create table DATPHONG(
    MADATPHONG varchar(10) not null primary key,
	MANHANVIEN varchar(10) foreign key references NHANVIEN,
	MAHOADON varchar(10) foreign key references HOADON,
	NGAYDAT datetime,
	NGAYTRA datetime
	
)

create table PHONG(
  MAPHONG varchar(10) not null primary key,
  LOAIPHONG nvarchar(30),
  TINGTRANG nvarchar(30),
  GIAPHONG int check (GIAPHONG > 0)
)
create table DAT(
  MADATPHONG varchar(10) foreign key references DATPHONG,
  MAPHONG varchar(10) foreign key references PHONG,
  TINHTRANG nvarchar(30),

)

create table DICHVU(
   MADV varchar(10) not null primary key,
   TENDV nvarchar(50),
   GIADV int check(GIADV > 0)
)
create table SUDUNG(
   MADATPHONG varchar(10) foreign key references DATPHONG,
   MADV varchar(10) foreign key references DICHVU,
   TINHTRANG nvarchar(30)
)
	
INSERT INTO CHUCVU (MACHUCVU, TENCHUCVU)
VALUES ('CV01', N'Quản lý'),
		('CV02', N'Nhân viên tiếp tân'),
		('CV03', N'Nhân viên phục vụ'),
		('CV04', N'Nhân viên bảo vệ');
	
INSERT INTO NHANVIEN (MANHANVIEN, MACHUCVU, TENNHANVIEN, GIOITINH, NGAYSINH, DIACHI, SDT)
VALUES  ('NV001', 'CV01', N'Đoàn Thanh Phúc', N'NAM', '2003-01-01', N'Đồng Tháp', '0123456789'),
		('NV002', 'CV01', N'Tô Đỗ Hồng Y', N'NỮ', '2003-02-14', N'Bạc Liêu', '0123456790'),
		('NV003', 'CV01', N'Trần Gia Vỹ', N'NAM', '2003-12-20', N'An Giang', '0123456791'),
		('NV004', 'CV01', N'Dương Mỹ Tiên', N'NỮ', '2003-06-15', N'Vĩnh Long', '0123456792'),
		('NV005', 'CV01', N'Nguyễn Trường Duy', N'NAM', '2003-09-05', N'Sóc Trăng', '0123456793'),
		('NV006', 'CV02', N'Võ Thị Phương', N'NỮ', '1991-03-25', N'Nam Định', '0123456794'),
		('NV007', 'CV02', N'Nguyễn Lý Nhật Hào', N'NAM', '2003-11-12', N'Hậu Giang', '0123456795'),
		('NV008', 'CV02', N'Nguyễn Thị Hồng', N'NỮ', '1998-05-10', N'Hồ Chí Minh', '0123456796'),
		('NV009', 'CV02', N'Trần Văn Hoàng', N'NAM', '1995-08-22', N'Đà Nẵng', '0123456797'),
		('NV010', 'CV02', N'Lê Thị Kim', N'NỮ', '1990-02-18', N'Hải Phòng', '0123456798'),
		('NV011', 'CV02', N'Phạm Văn Hòa', N'NAM', '1993-03-15', N'Hưng Yên', '0123456799'),
		('NV012', 'CV02', N'Nguyễn Thị Thuận', N'NỮ', '1992-11-25', N'Nam Định', '0123456800'),
		('NV013', 'CV02', N'Vũ Văn Thanh', N'NAM', '1991-07-12', N'Thanh Hóa', '0123456801'),
		('NV014', 'CV02', N'Nguyễn Thị Trang', N'NỮ', '1994-04-28', N'Hải Dương', '0123456802'),
		('NV015', 'CV02', N'Trần Văn Thắng', N'NAM', '1997-09-30', N'Hà Nội', '0123456803'),
		('NV016', 'CV03', N'Phạm Thị Trinh', N'NỮ', '1996-11-05', N'Hồ Chí Minh', '0123456804'),
		('NV017', 'CV03', N'Lê Văn Tú', N'NAM', '1990-06-20', N'Đà Nẵng', '0123456805'),
		('NV018', 'CV03', N'Nguyễn Thị Mai', N'NỮ', '1992-03-18', N'Hải Phòng', '0123456806'),
		('NV019', 'CV03', N'Trần Văn Nam', N'NAM', '1993-04-15', N'Hưng Yên', '0123456807'),
		('NV020', 'CV03', N'Phạm Thị Quỳnh', N'NỮ', '1991-10-25', N'Nam Định', '0123456808'),
		('NV021', 'CV03', N'Vũ Văn Thắng', N'NAM', '1994-07-12', N'Thanh Hóa', '0123456809'),
		('NV022', 'CV03', N'Nguyễn Thị Hương', N'NỮ', '1998-04-28', N'Hải Dương', '0123456810'),
		('NV023', 'CV03', N'Nguyễn Văn Đạt', N'NAM', '1996-09-10', N'Bình Dương', '0123456811'),
		('NV024', 'CV03', N'Nguyễn Thị Thu Hằng', N'NỮ', '1995-11-22', N'Long An', '0123456812'),
		('NV025', 'CV04', N'Lê Văn Tâm', N'NAM', '1997-02-18', N'Tây Ninh', '0123456813'),
		('NV026', 'CV04', N'Nguyễn Thị Trúc', N'NỮ', '1993-03-15', N'Vĩnh Phúc', '0123456814'),
		('NV027', 'CV04', N'Trần Văn Hải', N'NAM', '1992-11-25', N'Bắc Ninh', '0123456815'),
		('NV028', 'CV04', N'Nguyễn Thị Thúy', N'NỮ', '1994-07-12', N'Phú Thọ', '0123456816'),
		('NV029', 'CV04', N'Lê Văn Dũng', N'NAM', '1991-04-28', N'Quảng Ninh', '0123456817'),
		('NV030', 'CV04', N'Trần Thị Bình', N'NỮ', '1998-09-30', N'Bắc Giang', '0123456818');

INSERT INTO KHACHHANG (MAKHACHHANG, TENKHACHHANG, GIOITINH, CCCD, SDT, QUOCTICH)
VALUES 
('KH001', N'Trần Văn Khánh', N'NAM', '123456789012', '0123456789', N'Việt Nam'),
('KH002', N'Nguyễn Thị Linh', N'NỮ', '234567890123', '0123456790', N'Việt Nam'),
('KH003', N'Phạm Văn Hùng', N'NAM', '345678901234', '0123456791', N'Việt Nam'),
('KH004', N'Lê Thị Mai', N'NỮ', '456789012345', '0123456792', N'Việt Nam'),
('KH005', N'Vũ Văn Tú', N'NAM', '567890123456', '0123456793', N'Việt Nam'),
('KH006', N'Nguyễn Thị Hồng', N'NỮ', '678901234567', '0123456794', N'Việt Nam'),
('KH007', N'Lê Văn Đức', N'NAM', '789012345678', '0123456795', N'Việt Nam'),
('KH008', N'Trần Thị Hằng', N'NỮ', '890123456789', '0123456796', N'Việt Nam'),
('KH009', N'Nguyễn Văn Tâm', N'NAM', '901234567890', '0123456797', N'Việt Nam'),
('KH010', N'Phạm Thị Trang', N'NỮ', '012345678901', '0123456798', N'Việt Nam'),
('KH011', N'Trần Văn Lâm', N'NAM', '123456789012', '0123456799', N'Việt Nam'),
('KH012', N'Nguyễn Thị Nga', N'NỮ', '234567890123', '0123456800', N'Việt Nam'),
('KH013', N'Lê Văn Hải', N'NAM', '345678901234', '0123456801', N'Việt Nam'),
('KH014', N'Phạm Thị Mai', N'NỮ', '456789012345', '0123456802', N'Việt Nam'),
('KH015', N'Vũ Văn Tùng', N'NAM', '567890123456', '0123456803', N'Việt Nam'),
('KH016', N'Nguyễn Thị Thảo', N'NỮ', '678901234567', '0123456804', N'Việt Nam'),
('KH017', N'Lê Văn Đức', N'NAM', '789012345678', '0123456805', N'Việt Nam'),
('KH018', N'Trần Thị Hằng', N'NỮ', '890123456789', '0123456806', N'Việt Nam'),
('KH019', N'Nguyễn Văn Tâm', N'NAM', '901234567890', '0123456807', N'Việt Nam'),
('KH020', N'Phạm Thị Trang', N'NỮ', '012345678901', '0123456808', N'Việt Nam'),
('KH021', N'Trần Văn Lâm', N'NAM', '123456789012', '0123456809', N'Việt Nam'),
('KH022', N'Nguyễn Thị Nga', N'NỮ', '234567890123', '0123456810', N'Việt Nam');

INSERT INTO HOADON (MAHOADON, MANHANVIEN, MAKHACHHANG, NGAYTHANHTOAN, TINHTRANG)
VALUES ('HD001', 'NV001', 'KH001', '2023-06-01', 'Chưa thanh toán'),
    ('HD002', 'NV002', 'KH002', '2023-06-02', 'Chưa thanh toán'),
    ('HD003', 'NV003', 'KH003', '2023-06-03', 'Chưa thanh toán'),
    ('HD004', 'NV004', 'KH004', '2023-06-04', 'Chưa thanh toán'),
    ('HD005', 'NV005', 'KH005', '2023-06-05', 'Chưa thanh toán'),
    ('HD006', 'NV006', 'KH006', '2023-06-06', 'Chưa thanh toán'),
	('HD007', 'NV007', 'KH007', '2023-06-07', 'Chưa thanh toán'),
    ('HD008', 'NV008', 'KH008', '2023-06-08', 'Chưa thanh toán'),
    ('HD009', 'NV009', 'KH009', '2023-06-09', 'Chưa thanh toán'),
    ('HD010', 'NV010', 'KH010', '2023-06-10', 'Chưa thanh toán'),
	('HD011', 'NV011', 'KH011', '2023-06-11', 'Chưa thanh toán'),
	('HD012', 'NV012', 'KH012', '2023-06-12', 'Chưa thanh toán'),
	('HD013', 'NV013', 'KH013', '2023-06-13', 'Chưa thanh toán'),
	('HD014', 'NV014', 'KH014', '2023-06-14', 'Chưa thanh toán'),
	('HD015', 'NV015', 'KH015', '2023-06-15', 'Chưa thanh toán'),
	('HD016', 'NV015', 'KH016', '2023-06-16', 'Chưa thanh toán'),
	('HD017', 'NV014', 'KH017', '2023-06-17', 'Chưa thanh toán'),
	('HD018', 'NV013', 'KH018', '2023-06-18', 'Chưa thanh toán'),
	('HD019', 'NV012', 'KH019', '2023-06-19', 'Chưa thanh toán'),
	('HD020', 'NV013', 'KH020', '2023-06-20', 'Chưa thanh toán'),
	('HD021', 'NV014', 'KH021', '2023-06-21', 'Chưa thanh toán'),
	('HD022', 'NV015', 'KH022', '2023-06-22', 'Chưa thanh toán'),
	('HD023', 'NV013', 'KH014', '2023-06-23', 'Chưa thanh toán'),
	('HD024', 'NV002', 'KH001', '2023-06-24', 'Chưa thanh toán'),
	('HD025', 'NV005', 'KH010', '2023-06-25', 'Chưa thanh toán'),
	('HD026', 'NV006', 'KH012', '2023-06-26', 'Chưa thanh toán'),
	('HD027', 'NV007', 'KH016', '2023-06-27', 'Chưa thanh toán'),
	('HD028', 'NV008', 'KH009', '2023-06-28', 'Chưa thanh toán'),
	('HD029', 'NV009', 'KH005', '2023-06-29', 'Chưa thanh toán'),
	('HD030', 'NV010', 'KH002', '2023-06-30', 'Chưa thanh toán');
	
INSERT INTO DATPHONG (MADATPHONG, MANHANVIEN, MAHOADON, NGAYDAT, NGAYTRA)
VALUES
('DP001', 'NV001', 'HD001', '2023-05-29', '2023-06-01'),
('DP002', 'NV002', 'HD001', '2023-05-30', '2023-06-01'),
('DP003', 'NV003', 'HD003', '2023-06-01', '2023-06-03'),
('DP004', 'NV004', 'HD004', '2023-06-02', '2023-06-04'),
('DP005', 'NV005', 'HD005', '2023-06-03', '2023-06-05'),
('DP006', 'NV006', 'HD005', '2023-06-02', '2023-06-05'),
('DP007', 'NV007', 'HD002', '2023-06-01', '2023-06-02'),
('DP008', 'NV008', 'HD006', '2023-06-05', '2023-06-06'),
('DP009', 'NV009', 'HD006', '2023-06-04', '2023-06-06'),
('DP010', 'NV010', 'HD007', '2023-06-05', '2023-06-07'),
('DP011', 'NV011', 'HD011', '2023-06-09', '2023-06-11'),
('DP012', 'NV012', 'HD012', '2023-06-10', '2023-06-12'),
('DP013', 'NV013', 'HD013', '2023-06-11', '2023-06-13'),
('DP014', 'NV014', 'HD014', '2023-06-12', '2023-06-14'),
('DP015', 'NV015', 'HD015', '2023-06-13', '2023-06-15'),
('DP016', 'NV015', 'HD016', '2023-06-14', '2023-06-16'),
('DP017', 'NV014', 'HD017', '2023-06-15', '2023-06-17'),
('DP018', 'NV013', 'HD018', '2023-06-16', '2023-06-18'),
('DP019', 'NV012', 'HD019', '2023-06-17', '2023-06-19'),
('DP020', 'NV013', 'HD020', '2023-06-18', '2023-06-20'),
('DP021', 'NV014', 'HD021', '2023-06-19', '2023-06-21'),
('DP022', 'NV015', 'HD022', '2023-06-20', '2023-06-22'),
('DP023', 'NV013', 'HD023', '2023-06-21', '2023-06-23'),
('DP024', 'NV002', 'HD024', '2023-06-22', '2023-06-24'),
('DP025', 'NV005', 'HD025', '2023-06-23', '2023-06-25'),
('DP026', 'NV006', 'HD026', '2023-06-24', '2023-06-26'),
('DP027', 'NV007', 'HD027', '2023-06-25', '2023-06-27'),
('DP028', 'NV008', 'HD028', '2023-06-26', '2023-06-28'),
('DP029', 'NV009', 'HD029', '2023-06-27', '2023-06-29'),
('DP030', 'NV010', 'HD030', '2023-06-28', '2023-06-30'),
('DP031', 'NV012', 'HD001', '2023-05-27', '2023-06-01'),
('DP032', 'NV013', 'HD001', '2023-05-28', '2023-06-01'),
('DP033', 'NV010', 'HD001', '2023-05-26', '2023-06-01'),
('DP034', 'NV009', 'HD001', '2023-05-25', '2023-06-01'),
('DP035', 'NV010', 'HD001', '2023-05-24', '2023-06-11'),
('DP036', 'NV011', 'HD002', '2023-05-30', '2023-06-02'),
('DP037', 'NV012', 'HD002', '2023-05-29', '2023-06-02'),
('DP038', 'NV013', 'HD002', '2023-05-28', '2023-06-02'),
('DP039', 'NV014', 'HD002', '2023-05-27', '2023-06-02'),
('DP040', 'NV015', 'HD002', '2023-05-26', '2023-06-02');

INSERT INTO PHONG (MAPHONG, LOAIPHONG, TINGTRANG, GIAPHONG)
VALUES ('P001', N'Phòng đơn', N'Trống', 1000000),
    ('P002', N'Phòng đơn', N'Trống', 1000000),
	('P003', N'Phòng đơn', N'Trống', 1000000),
	('P004', N'Phòng đơn', N'Trống', 1000000),
	('P005', N'Phòng đơn', N'Trống', 1000000),
	('P006', N'Phòng đơn', N'Trống', 1000000),
	('P007', N'Phòng đơn', N'Trống', 1000000),
	('P008', N'Phòng đơn', N'Trống', 1000000),
	('P009', N'Phòng đơn', N'Trống', 1000000),
	('P010', N'Phòng đơn', N'Trống', 1000000),
    ('P011', N'Phòng đôi', N'Trống', 1500000),
	('P012', N'Phòng đôi', N'Trống', 1500000),
	('P013', N'Phòng đôi', N'Trống', 1500000),
	('P014', N'Phòng đôi', N'Trống', 1500000),
	('P015', N'Phòng đôi', N'Trống', 1500000),
	('P016', N'Phòng đôi', N'Trống', 1500000),
	('P017', N'Phòng đôi', N'Trống', 1500000),
	('P018', N'Phòng đôi', N'Trống', 1500000),
	('P019', N'Phòng đôi', N'Trống', 1500000),
	('P020', N'Phòng đôi', N'Trống', 1500000),
    ('P021', 'Phòng VIP', N'Trống', 5000000),
	('P022', 'Phòng VIP', N'Trống', 5000000),
	('P023', 'Phòng VIP', N'Trống', 5000000),
	('P024', 'Phòng VIP', N'Trống', 5000000),
	('P025', 'Phòng VIP', N'Trống', 5000000),
	('P026', 'Phòng VIP', N'Trống', 5000000);
	
INSERT INTO DAT (MADATPHONG, MAPHONG, TINHTRANG)
VALUES 
('DP001', 'P001', N'Chưa đặt'),
('DP002', 'P002', N'Đã đặt'),
('DP003', 'P003', N'Đã đặt'),
('DP004', 'P004', N'Đã đặt'),
('DP005', 'P005', N'Đã đặt'),
('DP006', 'P006', N'Đã đặt'),
('DP007', 'P007', N'Đã đặt'),
('DP008', 'P008', N'Đã đặt'),
('DP009', 'P009', N'Đã đặt'),
('DP010', 'P010', N'Đã đặt'),
('DP011', 'P011', N'Đã đặt'),
('DP012', 'P012', N'Đã đặt'),
('DP013', 'P013', N'Đã đặt'),
('DP014', 'P014', N'Đã đặt'),
('DP015', 'P015', N'Đã đặt'),
('DP016', 'P016', N'Đã đặt'),
('DP017', 'P017', N'Đã đặt'),
('DP018', 'P018', N'Đã đặt'),
('DP019', 'P019', N'Đã đặt'),
('DP020', 'P020', N'Đã đặt'),
('DP021', 'P021', N'Đã đặt'),
('DP022', 'P022', N'Đã đặt'),
('DP023', 'P023', N'Đã đặt'),
('DP024', 'P024', N'Đã đặt'),
('DP025', 'P025', N'Đã đặt'),
('DP026', 'P026', N'Đã đặt'),
('DP027', 'P007', N'Đã đặt'),
('DP028', 'P008', N'Đã đặt'),
('DP029', 'P001', N'Đã đặt'),
('DP030', 'P001', N'Đã đặt'),
('DP031', 'P001', N'Đã đặt'),
('DP032', 'P001', N'Đã đặt'),
('DP033', 'P003', N'Đã đặt'),
('DP034', 'P003', N'Đã đặt'),
('DP035', 'P003', N'Đã đặt'),
('DP036', 'P004', N'Đã đặt'),
('DP037', 'P005', N'Đã đặt');
INSERT INTO DAT (MADATPHONG, MAPHONG, TINHTRANG)
VALUES 
('DP038', 'P001', N'Đã đặt');
	
INSERT INTO DICHVU(MADV, TENDV, GIADV)
VALUES
('DV001', N'Dịch vụ spa và mát-xa', 100000),
('DV002', N'Dịch vụ nhà hàng/ăn uống', 200000),
('DV003', N'Dịch vụ dưa đón sân bay', 100000),
('DV004', N'Dịch vụ phòng gym', 200000),
('DV005', N'Dịch vụ giặt ủi', 100000),
('DV006', N'Dịch vụ tổ chức sự kiện', 200000),
('DV007', N'Dịch vụ thuê xe', 100000),
('DV008', N'Dịch vụ giữ hành lý', 200000);

INSERT INTO SUDUNG (MADATPHONG, MADV, TINHTRANG)
VALUES 
('DP001', 'DV001', N'Đã sử dụng'),
('DP002', 'DV001', N'Đã sử dụng'),
('DP003', 'DV002', N'Đã sử dụng'),
('DP004', 'DV002', N'Đã sử dụng'),
('DP005', 'DV003', N'Đã sử dụng'),
('DP006', 'DV003', N'Đã sử dụng'),
('DP007', 'DV004', N'Đã sử dụng'),
('DP008', 'DV004', N'Đã sử dụng'),
('DP009', 'DV005', N'Đã sử dụng'),
('DP010', 'DV006', N'Đã sử dụng'),
('DP011', 'DV006', N'Đã sử dụng'),
('DP012', 'DV007', N'Đã sử dụng'),
('DP013', 'DV007', N'Đã sử dụng'),
('DP014', 'DV007', N'Đã sử dụng'),
('DP015', 'DV008', N'Đã sử dụng'),
('DP016', 'DV008', N'Đã sử dụng'),
('DP017', 'DV004', N'Đã sử dụng'),
('DP018', 'DV005', N'Đã sử dụng'),
('DP019', 'DV006', N'Đã sử dụng'),
('DP020', 'DV007', N'Đã sử dụng'),
('DP021', 'DV002', N'Đã sử dụng'),
('DP022', 'DV004', N'Đã sử dụng'),
('DP023', 'DV005', N'Đã sử dụng'),
('DP024', 'DV006', N'Đã sử dụng'),
('DP025', 'DV007', N'Đã sử dụng'),
('DP026', 'DV007', N'Đã sử dụng'),
('DP027', 'DV003', N'Đã sử dụng'),
('DP028', 'DV004', N'Đã sử dụng'),
('DP029', 'DV003', N'Đã sử dụng'),
('DP030', 'DV008', N'Đã sử dụng');
	
