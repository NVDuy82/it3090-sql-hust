-- a) Bài tập về Store Procedure:
-- 1. In ra dòng ‘Xin chào’.
CREATE PROC hello
AS BEGIN
	print N'Xin chào'
END
GO

-- 2. In ra dòng ‘Xin chào’ + @ten với @ten là tham số đầu vào là tên của bạn.
-- Cho thực thi và in giá trị của các tham số này để kiểm tra.
CREATE PROC helloName
@name NVARCHAR(20)
AS BEGIN
	print(N'Xin chào' + @name)
END
GO

-- 3. Nhập vào 2 số @s1, @s2. In ra câu ‘tổng là : @tg ‘ với @tg =@s1+@s2.
CREATE PROC printTwoSum
@s1 int, @s2 int
AS BEGIN
	print(N'Tổng là : ' + @s1 + @s2)
END
GO

-- 4. Nhập vào 2 số @s1,@s2. Xuất tổng @s1+@s2 ra tham số @tong.
CREATE PROC twoSum
@s1 int, @s2 int, @tong int out
AS BEGIN
	set @tong = @s1 + @s2
END
GO

-- Nhập vào 2 số @s1,@s2. In ra câu ‘Số lớn nhất của @s1 và @s2 là max’
-- với @s1,@s2,max là các giá trị tương ứng.
CREATE PROC printMaxTwo
@s1 int, @s2 int
AS BEGIN
	if @s1 > @s2
		print(N'Số lớn nhất của ' + @s1 + N' và ' + @s2 + N' là ' + @s1)
	else
		print(N'Số lớn nhất của ' + @s1 + N' và ' + @s2 + N' là ' + @s2)
END
GO

-- 5. Nhập vào 2 số @s1,@s2. Xuất min và max của chúng ra tham số @max.
-- Cho thực thi và in giá trị của các tham số này để kiểm tra.
CREATE PROC getMax
@s1 int, @s2 int, @res int out
AS BEGIN
	if @s1 > @s2
		set @res = @s1
	else
		set @res = @s2
END
GO

CREATE PROC getMin
@s1 int, @s2 int, @res int out
AS BEGIN
	if @s1 < @s2
		set @res = @s1
	else
		set @res = @s2
END
GO

Declare @max int
Exec getMax 3, 4, @max out
print @max
Declare @min int
Exec getMin 8, 9, @min out
print @min
GO

-- 6. Nhập vào số nguyên @n. In ra các số từ 1 đến @n.
CREATE PROC printOneToN
@n int
AS BEGIN
	declare @step int = 1
	while @step <= @n
	BEGIN
		print(@step)
		set @step = @step + 1
	END
END
GO

-- 7. Nhập vào số nguyên @n. In ra tổng các số chẵn từ 1 đến @n
CREATE PROC sumEven
@n int
AS BEGIN
	declare @sum int = 0, @step int = 2

	while @step <= @n
	BEGIN
		set @sum = @sum + @step
		set @step = @step + 2
	END
	print(@sum)
END
GO

-- 8. Nhập vào số nguyên @n. In ra tổng và số lượng các số chẵn từ 1 đến @n
-- Cho thực thi và in giá trị của các tham số này để kiểm tra.
CREATE PROC sumAndCountEven
@n int
AS BEGIN
	declare @sum int = 0, @count int = 0, @step int = 2

	while @step <= @n
	BEGIN
		set @sum = @sum + @step
		set @count = @count + 1
		set @step = @step + 2
	END
	print(@sum)
	print(@count)
END
GO

-- 9. Viết store procedure tương ứng với các câu ở phần View. Sau đó cho thực
-- hiện để
-- kiểm tra kết quả.
CREATE PROC showView_1
AS BEGIN
	SELECT * FROM VIEW_1
END
GO
CREATE PROC showView_2
AS BEGIN
	SELECT * FROM VIEW_2
END
GO
CREATE PROC showView_3
AS BEGIN
	SELECT * FROM VIEW_3
END
GO
CREATE PROC showView_4
AS BEGIN
	SELECT * FROM VIEW_4
END
GO
CREATE PROC showView_5
AS BEGIN
	SELECT * FROM VIEW_5
END
GO
CREATE PROC showView_6
AS BEGIN
	SELECT * FROM VIEW_6
END
GO
CREATE PROC showView_7
AS BEGIN
	SELECT * FROM VIEW_7
END
GO
CREATE PROC showView_8
AS BEGIN
	SELECT * FROM VIEW_8
END
GO
CREATE PROC showView_9
AS BEGIN
	SELECT * FROM VIEW_9
END
GO
CREATE PROC showView_10
AS BEGIN
	SELECT * FROM VIEW_10
END
GO
CREATE PROC showView_11
AS BEGIN
	SELECT * FROM VIEW_11
END
GO
CREATE PROC showView_12
AS BEGIN
	SELECT * FROM VIEW_12
END
GO
CREATE PROC showView_13
AS BEGIN
	SELECT * FROM VIEW_13
END
GO


-- 10. Ứng với mỗi bảng trong CSDL Quản lý bóng đá, bạn hãy viết 4 Stored
-- Procedure ứng với 4 công việc Insert/Update/Delete/Select. Trong đó
-- Stored Procedure Update và Delete lấy khóa chính làm tham số.

-- Insert/Update/Delete/Select  của  BANGXH
CREATE PROC insertBangXH
@maCLB varchar(5), @nam int, @vong int, @soTran int, @thang int, @hoa int, @thua int, @hieuSo varchar(50), @diem int, @hang int
AS BEGIN
	INSERT INTO dbo.BANGXH
	( 
		MACLB,
		NAM,
		VONG,
		SOTRAN,
		THANG,
		HOA,
		THUA,
		HIEUSO,
		DIEM,
		HANG
		)
	VALUES
	(   @maCLB, -- MACLB - varchar(5)
		@nam,  -- NAM - int
		@vong,  -- VONG - int
		@soTran,  -- SOTRAN - int
		@thang,  -- THANG - int
		@hoa,  -- HOA - int
		@thua,  -- THUA - int
		@hieuSo, -- HIEUSO - varchar(5)
		@diem,  -- DIEM - int
		@hang   -- HANG - int
		)
END
GO

CREATE PROC updateBangXH
@maCLB varchar(5), @nam int, @vong int, @soTran int, @thang int, @hoa int, @thua int, @hieuSo varchar(50), @diem int, @hang int
AS BEGIN
	UPDATE dbo.BANGXH
	SET
		SOTRAN = @soTran,  -- SOTRAN - int
		THANG = @thang,  -- THANG - int
		HOA = @hoa,  -- HOA - int
		THUA = @thua,  -- THUA - int
		HIEUSO = @hieuSo, -- HIEUSO - varchar(5)
		DIEM = @diem,  -- DIEM - int
		HANG = @hang   -- HANG - int
	WHERE
		MACLB = @maCLB AND NAM = @nam AND VONG = @vong
END
GO

CREATE PROC deleteBangXH
@maCLB varchar(5), @nam int, @vong int
AS BEGIN
	DELETE FROM dbo.BANGXH
	WHERE
		MACLB = @maCLB AND NAM = @nam AND VONG = @vong
END
GO

CREATE PROC selectBangXH
AS BEGIN
	SELECT * FROM dbo.BANGXH
END
GO

-- Insert/Update/Delete/Select  của  CAULACBO
CREATE PROC insertCAULACBO
@maCLB varchar(5), @tenCLB nvarchar(100), @maSan varchar(5), @maTinh varchar(5)
AS BEGIN
	INSERT INTO dbo.CAULACBO
	(
		MACLB,
		TENCLB,
		MASAN,
		MATINH
		)
	VALUES
	(   @maCLB,  -- MACLB - varchar(5)
		@tenCLB, -- TENCLB - nvarchar(100)
		@maSan,  -- MASAN - varchar(5)
		@maTinh   -- MATINH - varchar(5)
		)
END
GO

CREATE PROC updateCAULACBO
@maCLB varchar(5), @tenCLB nvarchar(100), @maSan varchar(5), @maTinh varchar(5)
AS BEGIN
	UPDATE dbo.CAULACBO
	SET
		TENCLB = @tenCLB,
		MASAN = @maSan,
		MATINH = @maTinh
	WHERE
		MACLB = @maCLB
END
GO

CREATE PROC deleteCAULACBO
@maCLB varchar(5)
AS BEGIN
	DELETE FROM dbo.CAULACBO
	WHERE
		MACLB = @maCLB
END
GO

CREATE PROC selectCAULACBO
AS BEGIN
	SELECT * FROM dbo.CAULACBO
END
GO

-- Insert/Update/Delete/Select  của  CAUTHU
CREATE PROC insertCAUTHU
@hoten nvarchar(100), @viTri nvarchar(50), @ngaySinh datetime = NULL, @diaChi nvarchar(200) = NULL, @maCLB varchar(5), @maQG varchar(5), @so int
AS BEGIN
	INSERT INTO dbo.CAUTHU
	(
		HOTEN,
		VITRI,
		NGAYSINH,
		DIACHI,
		MACLB,
		MAQG,
		SO
		)
	VALUES
	(   @hoten,       -- HOTEN - nvarchar(100)
		@viTri,       -- VITRI - nvarchar(20)
		@ngaySinh, -- NGAYSINH - datetime
		@diaChi,       -- DIACHI - nvarchar(200)
		@maCLB,        -- MACLB - varchar(5)
		@maQG,        -- MAQG - varchar(5)
		@so          -- SO - int
		)
END
GO

CREATE PROC updateCAUTHU
@maCT numeric, @hoten nvarchar(100), @viTri nvarchar(50), @ngaySinh datetime, @diaChi nvarchar(200), @maCLB varchar(5), @maQG varchar(5), @so int
AS BEGIN
	UPDATE dbo.CAUTHU
	SET
		HOTEN = @hoten,
		VITRI = @viTri,
		NGAYSINH = @ngaySinh,
		DIACHI = @diaChi,
		MACLB = @maCLB,
		MAQG = @maQG,
		SO = @so
	WHERE
		MACT = @maCT
END
GO

CREATE PROC deleteCAUTHU
@maCT numeric
AS BEGIN
	DELETE FROM dbo.CAUTHU
	WHERE
		MACT = @maCT
END
GO

CREATE PROC selectCAUTHU
AS BEGIN
	SELECT * FROM dbo.CAUTHU
END
GO

-- Insert/Update/Delete/Select  của  HLV_CLB
CREATE PROC insertHLV_CLB
@maHLV varchar(5), @maCLB varchar(5), @vaiTro nvarchar(100)
AS BEGIN
	INSERT INTO dbo.HLV_CLB
	(
		MAHLV,
		MACLB,
		VAITRO
		)
	VALUES
	(   @maHLV, -- MAHLV - varchar(5)
		@maCLB, -- MACLB - varchar(5)
		@vaiTro -- VAITRO - nvarchar(100)
		)
END
GO

CREATE PROC updateHLV_CLB
@maHLV varchar(5), @maCLB varchar(5), @vaiTro nvarchar(100)
AS BEGIN
	UPDATE dbo.HLV_CLB
	SET
		VAITRO = @vaiTro
	WHERE
		MAHLV = @maHLV AND MACLB = @maCLB
END
GO

CREATE PROC deleteHLV_CLB
@maHLV varchar(5), @maCLB varchar(5)
AS BEGIN
	DELETE FROM dbo.HLV_CLB
	WHERE
		MAHLV = @maHLV AND MACLB = @maCLB
END
GO

CREATE PROC selectHLV_CLB
AS BEGIN
	SELECT * FROM dbo.HLV_CLB
END
GO

-- Insert/Update/Delete/Select  của  HUANLUYENVIEN
CREATE PROC insertHUANLUYENVIEN
@maHLV varchar(5), @tenHLV nvarchar(100), @ngaySinh datetime = NULL, @diaChi nvarchar(100) = NULL, @dienThoai nvarchar(20) = NULL, @maQG varchar(5)
AS BEGIN
	INSERT INTO dbo.HUANLUYENVIEN
	(
		MAHLV,
		TENHLV,
		NGAYSINH,
		DIACHI,
		DIENTHOAI,
		MAQG
	)
	VALUES
	(   @maHLV,        -- MAHLV - varchar(5)
		@tenHLV,       -- TENHLV - nvarchar(100)
		@ngaySinh, -- NGAYSINH - datetime
		@diaChi,       -- DIACHI - nvarchar(200)
		@dienThoai,       -- DIENTHOAI - nvarchar(20)
		@maQG         -- MAQG - varchar(5)
		)
END
GO

CREATE PROC updateHUANLUYENVIEN
@maHLV varchar(5), @tenHLV nvarchar(100), @ngaySinh datetime, @diaChi nvarchar(100), @dienThoai nvarchar(20), @maQG varchar(5)
AS BEGIN
	UPDATE dbo.HUANLUYENVIEN
	SET
		TENHLV = @tenHLV,
		NGAYSINH = @ngaySinh,
		DIACHI = @diaChi,
		DIENTHOAI = @dienThoai,
		MAQG = @maQG
	WHERE
		MAHLV = @maHLV
END
GO

CREATE PROC deleteHUANLUYENVIEN
@maHLV varchar(5)
AS BEGIN
	DELETE FROM dbo.HUANLUYENVIEN
	WHERE
		MAHLV = @maHLV
END
GO

CREATE PROC selectHUANLUYENVIEN
AS BEGIN
	SELECT * FROM dbo.HUANLUYENVIEN
END
GO

-- Insert/Update/Delete/Select  của  QUOCGIA
CREATE PROC insertQUOCGIA
@maQG varchar(5), @tenQG nvarchar(60)
AS BEGIN
	INSERT INTO dbo.QUOCGIA
	(
		MAQG,
		TENQG
	)
	VALUES
	(   @maQG, -- MAQG - varchar(5)
		@tenQG -- TENQG - nvarchar(60)
		)
END
GO

CREATE PROC updateQUOCGIA
@maQG varchar(5), @tenQG nvarchar(60)
AS BEGIN
	UPDATE dbo.QUOCGIA
	SET
		TENQG = @tenQG
	WHERE
		MAQG = @maQG
END
GO

CREATE PROC deleteQUOCGIA
@maQG varchar(5)
AS BEGIN
	DELETE FROM dbo.QUOCGIA
	WHERE
		MAQG = @maQG
END
GO

CREATE PROC selectQUOCGIA
AS BEGIN
	SELECT * FROM dbo.QUOCGIA
END
GO

-- Insert/Update/Delete/Select  của  SANVD
CREATE PROC insertSANVD
@maSan varchar(5), @tenSan nvarchar(100), @diaChi nvarchar(100) = NULL
AS BEGIN
	INSERT INTO dbo.SANVD
	(
		MASAN,
		TENSAN,
		DIACHI
		)
	VALUES
	(   @maSan,  -- MASAN - varchar(5)
		@tenSan, -- TENSAN - nvarchar(100)
		@diaChi  -- DIACHI - nvarchar(200)
		)
END
GO

CREATE PROC updateSANVD
@maSan varchar(5), @tenSan nvarchar(100), @diaChi nvarchar(100)
AS BEGIN
	UPDATE dbo.SANVD
	SET
		TENSAN = @tenSan,
		DIACHI = @diaChi
	WHERE
		MASAN = @maSan
END
GO

CREATE PROC deleteSANVD
@maSan varchar(5)
AS BEGIN
	DELETE FROM dbo.SANVD
	WHERE
		MASAN = @maSan
END
GO

CREATE PROC selectSANVD
AS BEGIN
	SELECT * FROM dbo.SANVD
END
GO

-- Insert/Update/Delete/Select  của  TINH
CREATE PROC insertTINH
@maTinh varchar(5), @tenTinh nvarchar(100)
AS BEGIN
	INSERT INTO dbo.TINH
	(
		MATINH,
		TENTINH
		)
	VALUES
	(   @maTinh, -- MATINH - varchar(5)
		@tenTinh -- TENTINH - nvarchar(100)
		)
END
GO

CREATE PROC updateTINH
@maTinh varchar(5), @tenTinh nvarchar(100)
AS BEGIN
	UPDATE dbo.TINH
	SET
		TENTINH = @tenTinh
	WHERE
		MATINH = @maTinh
END
GO

CREATE PROC deleteTINH
@maTinh varchar(5)
AS BEGIN
	DELETE FROM dbo.TINH
	WHERE
		MATINH = @maTinh
END
GO

CREATE PROC selectTINH
AS BEGIN
	SELECT * FROM dbo.TINH
END
GO

-- Insert/Update/Delete/Select  của  TRANDAU
CREATE PROC insertTRANDAU
@nam int, @vong int, @ngayTD datetime, @maCLB1 varchar(5), @maCLB2 varchar(5), @maSan varchar(5), @ketQua varchar(5)
AS BEGIN
	INSERT INTO dbo.TRANDAU
	(
		NAM,  
		VONG, 
		NGAYTD,
		MACLB1,
		MACLB2,
		MASAN,
		KETQUA
		)
	VALUES
	(   @nam,         -- NAM - int
		@vong,         -- VONG - int
		@ngayTD, -- NGAYTD - datetime
		@maCLB1,        -- MACLB1 - varchar(5)
		@maCLB2,        -- MACLB2 - varchar(5)
		@maSan,        -- MASAN - varchar(5)
		@ketQua         -- KETQUA - varchar(5)
		)
END
GO

CREATE PROC updateTRANDAU
@matran numeric, @nam int, @vong int, @ngayTD datetime, @maCLB1 varchar(5), @maCLB2 varchar(5), @maSan varchar(5), @ketQua varchar(5)
AS BEGIN
	UPDATE dbo.TRANDAU
	SET
		NAM = @nam,  
		VONG = @vong, 
		NGAYTD = @ngayTD,
		MACLB1 = @maCLB1,
		MACLB2 = @maCLB2,
		MASAN = @maSan,
		KETQUA = @ketQua
	WHERE
		MATRAN = @matran
END
GO

CREATE PROC deleteTRANDAU
@matran numeric
AS BEGIN
	DELETE FROM dbo.TRANDAU
	WHERE
		MATRAN = @matran
END
GO

CREATE PROC selectTRANDAU
AS BEGIN
	SELECT * FROM dbo.TRANDAU
END
GO


-- b) Bài tập về Trigger
-- Viết các trigger có nội dung như sau :

-- 1. Khi thêm cầu thủ mới, kiểm tra vị trí trên sân của cần thủ chỉ thuộc một
-- trong các vị trí sau: Thủ môn, Tiền đạo, Tiền vệ, Trung vệ, Hậu vệ.
-- 2. Khi thêm cầu thủ mới, kiểm tra số áo của cầu thủ thuộc cùng một câu lạc
-- bộ phải khác nhau.
-- 3. Khi thêm thông tin cầu thủ thì in ra câu thông báo bằng Tiếng Việt ‘
-- Đã thêm cầu thủ mới’.
-- 4. Khi thêm cầu thủ mới, kiểm tra số lượng cầu thủ nước ngoài ở mỗi câu lạc
-- bộ chỉ được phép đăng ký tối đa 8 cầu thủ.
CREATE TRIGGER triInsertCauThu ON dbo.CAUTHU
FOR INSERT
AS
BEGIN
	declare @viTri nvarchar(50), @so int, @maQG varchar(5), @count int, @maCLB varchar(5)
	SELECT @viTri = VITRI, @so = SO, @maQG = MAQG, @maCLB = MACLB
	FROM inserted

	
	

	declare @check int = 1

	-- Bai 1
	if @viTri not in (N'Thủ môn', N'tiền đạo', N'tiền vệ', N'trung vệ', N'hậu vệ')
	begin
		print(N'Vị trí không hợp lệ')
		set @check = 0
		rollback Transaction 
	end

	-- Bai 2
	SELECT @count = COUNT(SO) FROM dbo.CAUTHU WHERE SO = @so AND MACLB = @maCLB
	if @count > 1
	BEGIN
		print(N'Số áo đã tồn tại')
		set @check = 0
		rollback Transaction 
	end
	
	-- Bai 4
	SELECT @count = COUNT(MACT)	FROM dbo.CAUTHU	WHERE MACLB = @maCLB AND MAQG in (SELECT MAQG FROM dbo.QUOCGIA WHERE TENQG <> N'Việt Nam')
	if @count > 8
	BEGIN
		print(N'Tối đa cầu thủ nước ngoài')
		set @check = 0
		rollback Transaction 
	END
			
	-- Bai 3
	if @check = 1
		print(N'Đã thêm cầu thủ mới')
END
GO


-- 5. Khi thêm tên quốc gia, kiểm tra tên quốc gia không được trùng với tên
-- quốc gia đã có.
CREATE TRIGGER triInsertQuocGia ON dbo.QUOCGIA
FOR INSERT
AS
BEGIN
	declare @tenQG NVARCHAR(60), @maQG varchar(5)
	SELECT @tenQG = TENQG, @maQG = MAQG
	FROM inserted

	IF @tenQG IN (SELECT TENQG FROM dbo.QUOCGIA WHERE TENQG = @tenQG AND MAQG <> @maQG)
	BEGIN
		PRINT(N'Tên quốc gia đã tồn tại')
		ROLLBACK TRANSACTION
    END
	ELSE
		PRINT(N'Thêm quốc gia thành công')
END
GO


-- 6. Khi thêm tên tỉnh thành, kiểm tra tên tỉnh thành không được trùng với
-- tên tỉnh thành đã có.
CREATE TRIGGER triInsertTinh ON dbo.TINH
FOR INSERT
AS
BEGIN
	declare @tenTinh NVARCHAR(100), @maTinh varchar(5)
	SELECT @tenTinh = TENTINH, @maTinh = MATINH
	FROM Inserted

	IF @tenTinh IN (SELECT TENTINH FROM dbo.TINH WHERE TENTINH = @tenTinh AND MATINH <> @maTinh)
	BEGIN
		PRINT(N'Tên tỉnh đã tồn tại')
		ROLLBACK TRANSACTION
    END
	ELSE
		PRINT(N'Thêm tỉnh thành công')
END
GO


-- 7. Không cho sửa kết quả của các trận đã diễn ra.
CREATE TRIGGER triUpdateTranDau ON dbo.TRANDAU
FOR UPDATE
AS
BEGIN
	DECLARE	@ketqua1 VARCHAR(5)
	DECLARE	@ketqua2 VARCHAR(5)

	Select @ketqua1 = Inserted.KETQUA, @ketqua2 = Deleted.KETQUA
	FROM inserted join deleted
	ON (Inserted.MATRAN = Deleted.MATRAN)

	IF (@ketqua1 <> @ketqua2)
		BEGIN
			PRINT(N'KHÔNG ĐƯỢC CHỈNH SỬA KẾT QUẢ CỦA TRẬN ĐẤU')
			ROLLBACK TRANSACTION
		END
END
GO


-- 8. Khi phân công huấn luyện viên cho câu lạc bộ:
-- a. Kiểm tra vai trò của huấn luyện viên chỉ thuộc một trong các vai trò sau:
-- HLV chính, HLV phụ, HLV thể lực, HLV thủ môn .
-- b. Kiểm tra mỗi câu lạc bộ chỉ có tối đa 2 HLV chính.
CREATE TRIGGER triInsertHLV_CLB ON dbo.HLV_CLB
FOR INSERT
AS
BEGIN
	DECLARE @vaiTro NVARCHAR(100), @maCLB VARCHAR(5)
	SELECT @vaiTro = VAITRO, @maCLB = MACLB
	FROM Inserted

	IF @vaiTro NOT IN (N'HLV chính', N'HLV phụ', N'HLV thể lực', N'HLV thủ môn')
	BEGIN
	    PRINT(N'Vai trò của huấn luyện viên không thuộc trong các vai trò sau: HLV Chính, HLV phụ, HLV thể lực, HLV thủ môn')
		ROLLBACK TRANSACTION
	END

	DECLARE @count INT
	SELECT @count = COUNT(MAHLV) FROM dbo.HLV_CLB WHERE MACLB = @maCLB AND VAITRO = N'HLV Chính'
	IF @count > 2
	BEGIN
	    PRINT(N'Mỗi câu lạc bộ chỉ có tối đa 2 HLV chính')
		ROLLBACK TRANSACTION
	END
END
GO


-- 9. Khi thêm mới một câu lạc bộ thì kiểm tra xem đã có câu lạc bộ trùng tên
-- với câu lạc bộ vừa được thêm hay không?
-- c. chỉ thông báo vẫn cho insert.
-- d. thông báo và không cho insert.
CREATE TRIGGER triInsertCauLacBo ON dbo.CAULACBO
FOR INSERT
AS
BEGIN
    declare @tenCLB NVARCHAR(100), @maCLB varchar(5)
	SELECT @tenCLB = TENCLB, @maCLB = MACLB
	FROM Inserted

	IF EXISTS (SELECT TENCLB FROM dbo.CAULACBO WHERE TENCLB = @tenCLB AND MACLB <> @maCLB)
	BEGIN
		PRINT N'Tên CLB đã tồn tại';

		-- không cho insert
		ROLLBACK TRANSACTION
    END
	ELSE
		PRINT(N'Thêm CLB thành công')
END
GO


-- 10. Khi sửa tên cầu thủ cho một (hoặc nhiều) cầu thủ thì in ra:
-- e. danh sách mã cầu thủ của các cầu thủ vừa được sửa.
-- f. danh sách mã cầu thủ vừa được sửa và tên cầu thủ mới.
-- g. danh sách mã cầu thủ vừa được sửa và tên cầu thủ cũ.
-- h. danh sách mã cầu thủ vừa được sửa và tên cầu thủ cũ và cầu thủ mới.
-- i. câu thông báo bằng Tiếng Việt:
-- ‘Vừa sửa thông tin của cầu thủ có mã số xxx’ với xxx là mã cầu thủ
-- vừa được sửa.
CREATE TRIGGER triUpdateCauThu ON dbo.CAUTHU
FOR	UPDATE
AS
	DECLARE @c CURSOR
	DECLARE @maCauThu INT, @hoTen_OLD NVARCHAR(100), @hoTen_NEW NVARCHAR(100);
BEGIN
	SET @c = CURSOR FOR
	SELECT Inserted.MACT, Inserted.HOTEN, Deleted.HOTEN
	FROM Inserted, Deleted
	WHERE Inserted.MACT = Deleted.MACT

	OPEN @c
	FETCH NEXT FROM @c INTO @maCauThu, @hoTen_NEW, @hoTen_OLD

	WHILE @@FETCH_STATUS = 0
	BEGIN
	    PRINT N'Vừa sửa thông tin của cầu thủ có mã số ' + CAST(@maCauThu AS NVARCHAR(10))
		PRINT N'Tên cũ: ' +  @hoTen_OLD
		PRINT N'Tên mới: ' +  @hoTen_NEW
		PRINT '---------'

		FETCH NEXT FROM @c INTO	@maCauThu, @hoTen_NEW, @hoTen_OLD
	END

	CLOSE @c
	DEALLOCATE @c
END
GO
