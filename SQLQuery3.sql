--Xử lí chuỗi, ngày, giờ

--1.Cho biết NGAYTD, TENCLB1, TENCLB2, KETQUA các trận đấu diễn ra vào tháng 3 trên sân nhà mà không bị thủng lưới.
SELECT NGAYTD, CLB1.TENCLB, CLB2.TENCLB, KETQUA
FROM TRANDAU, CAULACBO CLB1, CAULACBO CLB2
WHERE TRANDAU.MACLB1 = CLB1.MACLB AND TRANDAU.MACLB2 = CLB2.MACLB AND MONTH(NGAYTD)=3 AND RIGHT(KETQUA,1) = 0

--2.Cho biết mã số, họ tên, ngày sinh của những cầu thủ có họ lót là “Công”.
SELECT MACT, HOTEN, NGAYSINH
FROM CAUTHU
WHERE HOTEN LIKE '%_Công_%'

--3.Cho biết mã số, họ tên, ngày sinh của những cầu thủ có họ không phải là họ “Nguyễn “.
SELECT MACT, HOTEN, NGAYSINH
FROM CAUTHU
WHERE SUBSTRING(HOTEN,1,6) <> N'Nguyễn'

--4.Cho biết mã huấn luyện viên, họ tên, ngày sinh, đ ịa chỉ của những huấn luyện viên Việt Nam có tuổi nằm trong khoảng 35-40.
SELECT MAHLV, TENHLV, NGAYSINH, DIACHI
FROM HUANLUYENVIEN
WHERE MAQG = 'VN' AND YEAR(GETDATE())-YEAR(NGAYSINH) BETWEEN 35 AND 80

--5.Cho biết tên câu lạc bộ có huấn luyện viên trưởng sinh vào ngày 20 tháng 8 năm 2019.
SELECT TENCLB
FROM (HUANLUYENVIEN INNER JOIN HLV_CLB ON HUANLUYENVIEN.MAHLV=HLV_CLB.MAHLV) INNER JOIN CAULACBO ON CAULACBO.MACLB=HLV_CLB.MACLB
WHERE NGAYSINH = '2019-8-20' and VAITRO = N'HLV Chính'

--6.Cho biết tên câu lạc bộ, tên tỉnh mà CLB đang đóng có số bàn thắng nhiều nhất tính đến hết vòng 3 năm 2009.
SELECT TOP 1 TENCLB, TENTINH, CAST (SUBSTRING (HIEUSO,1,1) AS INT) AS [SO BAN THANG]
FROM (CAULACBO INNER JOIN TINH ON CAULACBO.MATINH=TINH.MATINH) INNER JOIN BANGXH ON BANGXH.MACLB=CAULACBO.MACLB
WHERE VONG = 3
ORDER BY [SO BAN THANG] desc

--Truy vấn con

--1.Cho biết mã câu lạc bộ, tên câu lạc bộ, tên sân vận động, địa chỉ và số lượng cầu thủ nước ngoài (Có quốc tịch khác “Việt Nam”) tương ứng của các câu lạc bộ có nhiều hơn 2 cầu thủ nước ngoài.
SELECT CAULACBO.MACLB,TENCLB,TENSAN,CAUTHU.DIACHI,COUNT(MACT) AS [SOLUONG]
FROM CAULACBO,SANVD,CAUTHU,QUOCGIA
WHERE CAULACBO.MACLB = CAUTHU.MACLB AND CAULACBO.MASAN = SANVD.MASAN AND CAUTHU.MAQG = QUOCGIA.MAQG
AND CAUTHU.MAQG <> 'VN'
GROUP BY CAULACBO.MACLB,CAULACBO.TENCLB,SANVD.TENSAN,CAUTHU.DIACHI
HAVING COUNT(MACT) > 2

--2.Cho biết tên câu lạc bộ, tên tỉnh mà CLB đang đóng có hiệu số bàn thắng bại cao nhất năm 2009.
SELECT DISTINCT TENCLB, TENTINH
FROM (CAULACBO INNER JOIN TINH ON CAULACBO.MATINH=TINH.MATINH)
WHERE CAULACBO.MACLB = (
	SELECT TOP 1 MACLB
	FROM BANGXH
	WHERE NAM = 2009
	ORDER BY (CAST (SUBSTRING (HIEUSO,1,1) AS INT) - CAST (SUBSTRING (HIEUSO,3,1) AS INT)) desc
	)

--3.Cho biết danh sách các trận đấu ( NGAYTD, TENSAN, TENCLB1, TENCLB2, KETQUA) của câu lạc bộ CLB có thứ hạng thấp nhất trong bảng xếp hạng vòng 3 năm 2009.
SELECT NGAYTD,TENSAN,CLB1.TENCLB,CLB2.TENCLB,KETQUA
FROM TRANDAU, CAULACBO CLB1, CAULACBO CLB2,SANVD
WHERE CLB1.MACLB = TRANDAU.MACLB1 AND CLB2.MACLB = TRANDAU.MACLB2 AND SANVD.MASAN = TRANDAU.MASAN AND 
	(CLB1.MACLB = (
	SELECT TOP 1 MACLB
	FROM BANGXH
	WHERE NAM = 2009 AND VONG = 3
	ORDER BY HANG desc
	) OR CLB2.MACLB = (
	SELECT TOP 1 MACLB
	FROM BANGXH
	WHERE NAM = 2009 AND VONG = 3
	ORDER BY HANG desc
	))

--4.Cho biết mã câu lạc bộ, tên câu lạc bộ đã tham gia thi đấu với tất cả các câu lạc bộ còn lại (kể cả sân nhà và sân khách) trong mùa giải năm 2009.
select distinct CAULACBO.MACLB, TENCLB
from CAULACBO, BANGXH
where CAULACBO.MACLB = BANGXH.MACLB
and BANGXH.SOTRAN = (select (count(MACLB)-1)*2 from CAULACBO)


--5. Cho biết mã câu lạc bộ, tên câu lạc bộ đã tham gia thi đấu với tất cả các câu lạc bộ còn lại (chỉ tính sân nhà) tro ng mùa giải năm 2009.
select CAULACBO.MACLB, TENCLB
from CAULACBO, TRANDAU
where CAULACBO.MACLB = TRANDAU.MACLB1
group by CAULACBO.MACLB, TENCLB
having count(CAULACBO.MACLB) = (select (count(MACLB)-1)*2 from CAULACBO)


--Bài tập về Rule
--1. Khi thêm cầu thủ mới, kiểm tra vị trí trên sân của cầu thủ chỉ thuộc một trong các vị trí sau: Thủ môn, tiền đạo, tiền vệ, trung vệ, hậu vệ.
alter table CAUTHU add constraint CHK_Cauthu_Vitri
check (VITRI in (N'Thủ môn', N'tiền đạo', N'tiền vệ', N'trung vệ', N'hậu vệ'))


--2. Khi phân công huấn luyện viên, kiểm tra vai trò của huấn luyện vi ên chỉ thuộc một trong các vai trò sau: HLV chính, HLV phụ, HLV thể lực, HLV thủ môn.
alter table HLV_CLB add constraint CHK_HLV_CLB
check (VAITRO in (N'HLV chính', N'HLV phụ', N'HLV thể lực', N'HLV thủ môn'))

--3.Khi thêm cầu thủ mới, kiểm tra cầu thủ đó có tuổi phải đủ 18 trở lên (chỉ tính năm sinh)
alter table CAUTHU add constraint CHK_Cauthu_Namsinh
check (year(NOW()) - year(NGAYSINH) >= 18)

--4.Kiểm tra kết quả trận đấu có dạng số_bàn_thắng- số_bàn_thua.
alter table TRANDAU add constraint CHK_TranDau
check (KETQUA like '%-%')

-- d. Bài tập về View
GO
-- 1. Cho biết mã số, họ tên, ngày sinh, địa chỉ và vị trí của các cầu thủ thuộc đội bóng “SHB Đà Nẵng” có quốc tịch “Bra-xin”.
CREATE VIEW VIEW_1
AS
SELECT MACT, HOTEN, NGAYSINH, DIACHI, VITRI
FROM dbo.CAUTHU
WHERE MACLB IN (SELECT MACLB FROM dbo.CAULACBO WHERE TENCLB = N'SHB Đà Nẵng')
AND MAQG IN (SELECT MAQG FROM dbo.QUOCGIA WHERE TENQG = 'Bra-xin')
GO

SELECT * FROM VIEW_1
GO

-- 2. Cho biết kết quả (MATRAN, NGAYTD, TENSAN, TENCLB1, TENCLB2, KETQUA) các trận đấu vòng 3 của mùa bóng năm 2009.
CREATE VIEW VIEW_2
AS
SELECT MATRAN, NGAYTD, TENSAN, CLB1.TENCLB AS TENCLB1, CLB2.TENCLB AS TENCLB2, KETQUA
FROM dbo.TRANDAU, dbo.CAULACBO AS CLB1, dbo.CAULACBO AS CLB2, dbo.SANVD
WHERE VONG = 3
AND NAM = 2009
AND dbo.TRANDAU.MASAN = dbo.SANVD.MASAN
AND dbo.TRANDAU.MACLB1 = CLB1.MACLB
AND dbo.TRANDAU.MACLB2 = CLB2.MACLB
GO

SELECT * FROM VIEW_2
GO

-- 3. Cho biết mã huấn luyện viên, họ tên, ngày sinh, địa chỉ, vai trò và tên CLB đang làm việc của các huấn luyện viên có quốc tịch “Việt Nam”.
CREATE VIEW VIEW_3
AS
SELECT dbo.HUANLUYENVIEN.MAHLV, TENHLV, NGAYSINH, DIACHI, VAITRO, TENCLB
FROM dbo.HUANLUYENVIEN, dbo.HLV_CLB, dbo.CAULACBO
WHERE dbo.HUANLUYENVIEN.MAHLV = dbo.HLV_CLB.MAHLV
AND dbo.HLV_CLB.MACLB = dbo.CAULACBO.MACLB
AND dbo.HUANLUYENVIEN.MAQG IN (SELECT MAQG FROM dbo.QUOCGIA WHERE TENQG = N'Việt Nam')
GO

SELECT * FROM VIEW_3
GO

-- 4. Cho biết mã câu lạc bộ, tên câu lạc bộ, tên sân vận động, địa chỉ và số lượng cầu thủ nước ngoài (có quốc tịch khác “Việt Nam”) tương ứng của các câu lạc bộ nhiều hơn 2 cầu thủ nước ngoài.
CREATE VIEW VIEW_4
AS
SELECT CLB.MACLB, CLB.TENCLB, SVD.TENSAN, SVD.DIACHI, COUNT(CT.MACT) AS SOLUONCAUTHUNUOCNGOAI
FROM CAULACBO as CLB, SANVD as SVD, QUOCGIA as QG, CAUTHU as CT
WHERE 
CLB.MACLB = CT.MACLB
AND CLB.MASAN = SVD.MASAN
AND CT.MAQG = QG.MAQG
AND QG.TENQG <> N'Việt Nam'
GROUP BY 
CLB.MACLB, CLB.TENCLB, SVD.TENSAN, SVD.DIACHI
HAVING COUNT(CT.MACT) > 2;
GO

SELECT * FROM VIEW_4
GO


-- 5. Cho biết tên tỉnh, số lượng câu thủ đang thi đấu ở vị trí tiền đạo trong các câu lạc bộ thuộc địa bàn tỉnh đó quản lý.\\
CREATE VIEW VIEW_5
AS
SELECT T.TENTINH, COUNT(CT.MACT) AS SLTĐ
FROM  TINH as T, CAUTHU as CT, CAULACBO as CLB
WHERE CT.MACLB = CLB.MACLB
AND CLB.MATINH = T.MATINH
AND CT.VITRI = N'Tiền Đạo'
GROUP BY T.TENTINH;
GO

SELECT * FROM VIEW_5
GO


-- 6. Cho biết tên câu lạc bộ,tên tỉnh mà CLB đang đóng nằm ở vị trí cao nhất của bảng xếp hạng của vòng 3 năm 2009.
CREATE VIEW VIEW_6
AS
SELECT TOP 1  CLB.TENCLB, T.TENTINH, BXH.HANG
FROM CAULACBO as CLB, TINH as T,BANGXH as BXH
WHERE CLB.MATINH = T.MATINH
AND CLB.MACLB = BXH.MACLB
AND BXH.VONG = 3
AND BXH.NAM = 2009
ORDER BY BXH.HANG ASC
GO

SELECT * FROM VIEW_6
GO


-- 7. Cho biết tên huấn luyện viên đang nắm giữ một vị trí trong 1 câu lạc bộ mà chưa có số điện thoại.
CREATE VIEW VIEW_7
AS
SELECT TENHLV
FROM dbo.HUANLUYENVIEN
WHERE DIENTHOAI IS NULL;
GO

SELECT * FROM VIEW_7
GO


-- 8. Liệt kê các huấn luyện viên thuộc quốc gia Việt Nam chưa làm công tác huấn luyện tại bất kỳ một câu lạc bộ
CREATE VIEW VIEW_8
AS
SELECT TENHLV, MAHLV, HLV.MAQG
FROM HUANLUYENVIEN as HLV, QUOCGIA as QG
WHERE HLV.MAQG = QG.MAQG
AND QG.TENQG = N'Việt Nam'
AND MAHLV NOT IN (
	SELECT MAHLV
	FROM HLV_CLB)
GO

SELECT * FROM VIEW_8
GO


-- 9. Cho biết kết quả các trận đấu đã diễn ra (MACLB1, MACLB2, NAM, VONG, SOBANTHANG,SOBANTHUA).
CREATE VIEW VIEW_9
AS
SELECT MACLB1, MACLB2, NAM, VONG,
	SUBSTRING(KETQUA, 1, CHARINDEX('-', KETQUA, 1) - 1) as [Số bàn thắng của đội 1],
	SUBSTRING(KETQUA, CHARINDEX('-', KETQUA, 1) + 1, LEN(KETQUA)) as [Số bàn thua của đội 1]
FROM dbo.TRANDAU
GO

SELECT * FROM VIEW_9
GO


-- 10. Cho biết kết quả các trận đấu trên sân nhà (MACLB, NAM, VONG, SOBANTHANG, SOBANTHUA).
CREATE VIEW VIEW_10
AS
SELECT MACLB1, NAM, VONG,
	SUBSTRING(KETQUA, 1, CHARINDEX('-', KETQUA, 1) - 1) as [Số bàn thắng],
	SUBSTRING(KETQUA, CHARINDEX('-', KETQUA, 1) + 1, LEN(KETQUA)) as [Số bàn thua]
FROM dbo.TRANDAU
GO

SELECT * FROM VIEW_10
GO


-- 11. Cho biết kết quả các trận đấu trên sân khách (MACLB, NAM, VONG, SOBANTHANG,SOBANTHUA).
CREATE VIEW VIEW_11
AS
SELECT MACLB2, NAM, VONG,
	SUBSTRING(KETQUA, CHARINDEX('-', KETQUA, 1) + 1, LEN(KETQUA)) as [Số bàn thắng],
	SUBSTRING(KETQUA, 1, CHARINDEX('-', KETQUA, 1) - 1) as [Số bàn thua]
FROM dbo.TRANDAU
GO

SELECT * FROM VIEW_11
GO


-- 12. Cho biết danh sách các trận đấu (NGAYTD, TENSAN, TENCLB1, TENCLB2, KETQUA) của câu lạc bộ CLB đang xếp hạng cao nhất tính đến hết vòng 3 năm 2009.
CREATE VIEW VIEW_12
AS
SELECT NGAYTD, TENSAN, CLB1.TENCLB as TENCLB1, CLB2.TENCLB as TENCLB2, KETQUA
FROM dbo.TRANDAU, dbo.SANVD, dbo.CAULACBO as CLB1, dbo.CAULACBO as CLB2
WHERE TRANDAU.MASAN = SANVD.MASAN
AND TRANDAU.MACLB1 = CLB1.MACLB
AND TRANDAU.MACLB2 = CLB2.MACLB
AND (CLB1.MACLB IN (
		SELECT TOP 1 MACLB
		FROM dbo.BANGXH
		WHERE VONG = 3
		AND NAM = 2009
		ORDER BY HANG ASC
	)
	OR
	CLB2.MACLB IN (
		SELECT TOP 1 MACLB
		FROM dbo.BANGXH
		WHERE VONG = 3
		AND NAM = 2009
		ORDER BY HANG ASC
	)
)
GO

SELECT * FROM VIEW_12
GO


-- 13. Cho biết danh sách các trận đấu (NGAYTD, TENSAN, TENCLB1, TENCLB2, KETQUA) của câu lạc bộ CLB có thứ hạng thấp nhất trong bảng xếp hạng vòng 3 năm 2009.
CREATE VIEW VIEW_13
AS
SELECT NGAYTD, TENSAN, CLB1.TENCLB as TENCLB1, CLB2.TENCLB as TENCLB2, KETQUA
FROM dbo.TRANDAU, dbo.SANVD, dbo.CAULACBO as CLB1, dbo.CAULACBO as CLB2
WHERE TRANDAU.MASAN = SANVD.MASAN
AND TRANDAU.MACLB1 = CLB1.MACLB
AND TRANDAU.MACLB2 = CLB2.MACLB
AND (CLB1.MACLB IN (
		SELECT TOP 1 MACLB
		FROM dbo.BANGXH
		WHERE VONG = 3
		AND NAM = 2009
		ORDER BY HANG DESC
	)
	OR
	CLB2.MACLB IN (
		SELECT TOP 1 MACLB
		FROM dbo.BANGXH
		WHERE VONG = 3
		AND NAM = 2009
		ORDER BY HANG DESC
	)
)
GO

SELECT * FROM VIEW_13
GO

