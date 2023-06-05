﻿-- a) Bài tập về Store Procedure:
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


-- 10. Ứng với mỗi bảng trong CSDL Quản lý bóng đá, bạn hãy viết 4 Stored
-- Procedure ứng với 4 công việc Insert/Update/Delete/Select. Trong đó
-- Stored Procedure Update và Delete lấy khóa chính làm tham số.	

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


-- 5. Khi thêm tên quốc gia, kiểm tra tên quốc gia không được trùng với tên
-- quốc gia đã có.


-- 6. Khi thêm tên tỉnh thành, kiểm tra tên tỉnh thành không được trùng với
-- tên tỉnh thành đã có.


-- 7. Không cho sửa kết quả của các trận đã diễn ra.


-- 8. Khi phân công huấn luyện viên cho câu lạc bộ:
-- a. Kiểm tra vai trò của huấn luyện viên chỉ thuộc một trong các vai trò sau:
-- HLV chính, HLV phụ, HLV thể lực, HLV thủ môn .
-- b. Kiểm tra mỗi câu lạc bộ chỉ có tối đa 2 HLV chính.


-- 9. Khi thêm mới một câu lạc bộ thì kiểm tra xem đã có câu lạc bộ trùng tên
-- với câu lạc bộ vừa được thêm hay không?
-- c. chỉ thông báo vẫn cho insert.
-- d. thông báo và không cho insert.


-- 10. Khi sửa tên cầu thủ cho một (hoặc nhiều) cầu thủ thì in ra:
-- e. danh sách mã cầu thủ của các cầu thủ vừa được sửa.
-- f. danh sách mã cầu thủ vừa được sửa và tên cầu thủ mới.
-- g. danh sách mã cầu thủ vừa được sửa và tên cầu thủ cũ.
-- h. danh sách mã cầu thủ vừa được sửa và tên cầu thủ cũ và cầu thủ mới.
-- i. câu thông báo bằng Tiếng Việt:
-- ‘Vừa sửa thông tin của cầu thủ có mã số xxx’ với xxx là mã cầu thủ
-- vừa được sửa.
