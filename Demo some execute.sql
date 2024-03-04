--1. list các hóa đơn mà nhân viên đó phải chịu trách nhiệm
SELECT H.MAHOADON, H.NGAYTHANHTOAN, H.TINHTRANG, H.TONGTIEN
FROM HOADON H
INNER JOIN NHANVIEN N ON H.MANHANVIEN = N.MANHANVIEN
WHERE N.MANHANVIEN = 'NV002';
--2. Select khách hàng và hóa, phòng và dịch vụ của họ
SELECT k.MAKHACHHANG, h.MAHOADON, dp.NGAYDAT, dp.NGAYTRA, d.MAPHONG, dv.TENDV, dv.GIADV
    FROM DATPHONG dp
    INNER JOIN DAT d ON d.MADATPHONG = dp.MADATPHONG
    INNER JOIN PHONG p ON p.MAPHONG = d.MAPHONG
    LEFT JOIN SUDUNG sd ON sd.MADATPHONG = dp.MADATPHONG
    LEFT JOIN DICHVU dv ON dv.MADV = sd.MADV
    INNER JOIN HOADON h ON h.MAHOADON = dp.MAHOADON
    INNER JOIN KHACHHANG k ON k.MAKHACHHANG = h.MAKHACHHANG

---3. procedure thêm một hóa đơn mới---
CREATE OR ALTER PROCEDURE themHOADON
    @MAHOADON varchar(10), @MANHANVIEN varchar(10) , @MAKHACHHANG varchar(10) 
AS
BEGIN
	INSERT INTO HOADON(MAHOADON, MANHANVIEN, MAKHACHHANG)
	VALUES (@MAHOADON, @MANHANVIEN, @MAKHACHHANG)
END

select * from HOADON

begin transaction
exec themHOADON 'HD031', 'NV001', 'KH001'
select * from HOADON
rollback transaction

---4. tinh trang dat
CREATE OR ALTER PROCEDURE tinhtrangDat
    @MADATPHONG varchar(10)
AS BEGIN
    -- Kiểm tra trạng thái của MAPHONG
    DECLARE @TINHTRANG nvarchar(20)
    SELECT @TINHTRANG = TINHTRANG
    FROM DAT
    WHERE MADATPHONG = @MADATPHONG

    IF @TINHTRANG = N'Đã đặt'
    BEGIN
        PRINT N'Không thể thêm dữ liệu vào bảng DAT. MAPHONG đã có trạng thái "Đã đặt".'
    END
    ELSE
    BEGIN
    -- Cập nhật trạng thái TINHTRANG thành 'Đã đặt'
        UPDATE DAT
        SET TINHTRANG = N'Đã đặt'
        WHERE MADATPHONG = @MADATPHONG;

       
    END
END

select * from DAT

begin transaction
exec  tinhtrangDat 'DP001'
--exec  tinhtrangDat'DP002'
rollback transaction


--5.dem tong so luong bill cua 1 khach hang
CREATE OR ALTER FUNCTION CountTotalBills
(
    @MAKHACHHANG varchar(10)
)
RETURNS INT
AS
BEGIN
    DECLARE @TotalBills INT
    SELECT @TotalBills = COUNT(*) 
    FROM HOADON
    WHERE MAKHACHHANG = @MAKHACHHANG

    RETURN @TotalBills
END


begin transaction
select dbo.CountTotalBills('KH001') [SOLUONGHOADON]
rollback transaction

select MAHOADON from HOADON
where MAKHACHHANG like 'KH001'
   

--6. check xem ngày trả có sau ngày đặt không
CREATE or alter TRIGGER ValidateDateRange
ON DATPHONG
FOR INSERT
AS
BEGIN
    IF EXISTS (
        SELECT *
        FROM inserted i
        WHERE i.NGAYTRA < i.NGAYDAT
    )
    BEGIN
		PRINT N'Ngày trả phải sau ngày đặt.'
		DELETE FROM DATPHONG WHERE NGAYTRA < NGAYDAT
    END
END

begin transaction
INSERT INTO DATPHONG (MADATPHONG, MANHANVIEN, MAHOADON, NGAYDAT, NGAYTRA)
VALUES ('DP050', 'NV001', 'HD001', '2023-06-29', '2023-06-30');
rollback transaction
select * from DATPHONG



--7. Procedure để tính tổng tiền dựa trên, mã hóa đơn, mã khách hàng và ngày đặt phòng
CREATE OR ALTER PROCEDURE CaluTotalBill
    @MHD VARCHAR(10),
    @MKH VARCHAR(10),
    @NgayDatPhong DATETIME
AS
BEGIN
    DECLARE @totalBill INT;
    SELECT @totalBill = p.GIAPHONG * (DATEDIFF(DAY, dp.NGAYDAT, dp.NGAYTRA)  + 1)+ dv.GIADV
    FROM DATPHONG dp
    INNER JOIN DAT d ON d.MADATPHONG = dp.MADATPHONG
    INNER JOIN PHONG p ON p.MAPHONG = d.MAPHONG
    LEFT JOIN SUDUNG sd ON sd.MADATPHONG = dp.MADATPHONG
    LEFT JOIN DICHVU dv ON dv.MADV = sd.MADV
    INNER JOIN HOADON h ON h.MAHOADON = dp.MAHOADON
    INNER JOIN KHACHHANG k ON k.MAKHACHHANG = h.MAKHACHHANG
    WHERE k.MAKHACHHANG = @MHD
        AND h.MAHOADON = @MKH
        AND dp.NGAYDAT = @NgayDatPhong;

    UPDATE HOADON
    SET TONGTIEN = @totalBill,
        TINHTRANG = N'Đã thanh toán'
    WHERE MAHOADON = @MKH
        AND MAKHACHHANG = @MHD;
END;

--Câu lệnh test procedure CaluTotalBill
begin transaction
EXEC CaluTotalBill 'KH001', 'HD001', '2023-05-30 00:00:00.000';
Select * from HOADON
rollback transaction