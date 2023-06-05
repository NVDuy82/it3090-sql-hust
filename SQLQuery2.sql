USE QLBongDa

/*
*****************************************************************************
*                        a. Truy vấn cơ bản                                 *
*****************************************************************************
*/

/*
1. Cho biết thông tin (mã cầu thủ, họ tên, số áo, vị trí, ngày sinh, địa chỉ) của tất cả các
cầu thủ’.
*/
	SELECT MACT, HOTEN, SO, VITRI, NGAYSINH, DIACHI
	FROM dbo.CAUTHU
/*
 
 
 
2. Hiển thị thông tin tất cả các cầu thủ có số áo là 7 chơi ở vị trí Tiền vệ
*/
SELECT MACT, HOTEN, VITRI, NGAYSINH, DIACHI, SO
FROM dbo.CAUTHU
WHERE (SO = 7) and (VITRI = N'Tiền vệ')
 
 
 
/*
3. Cho biết tên, ngày sinh, địa chỉ, điện thoại của tất cả các huấn luyện viên
*/
SELECT TENHLV, NGAYSINH, DIACHI, DIENTHOAI
FROM dbo.HUANLUYENVIEN
 
 
 
 
/*
4. Hiển thi thông tin tất cả các cầu thủ có quốc tịch Việt Nam thuộc câu lạc bộ
Becamex Bình Dương.
*/
SELECT *
FROM dbo.CAUTHU
WHERE MAQG in 
(SELECT MAQG 
FROM dbo.QUOCGIA
WHERE dbo.QUOCGIA.TENQG = N'Việt Nam')
AND MACLB in
(SELECT MACLB
FROM dbo.CAULACBO
WHERE dbo.CAULACBO.TENCLB = N'Becamex Bình Dương')
 
 
 
/*
5. Cho biết mã số, họ tên, ngày sinh, địa chỉ và vị trí của các cầu thủ thuộc đội bóng
‘SHB Đà Nẵng’ có quốc tịch Brazil
*/
SELECT MACT, HOTEN, NGAYSINH, DIACHI, VITRI
FROM dbo.CAUTHU
WHERE MACLB in 
(SELECT MACLB
FROM dbo.CAULACBO
WHERE dbo.CAULACBO.TENCLB = N'SHB Đà Nẵng')
AND MAQG in 
(SELECT MAQG
FROM dbo.QUOCGIA
WHERE dbo.QUOCGIA.TENQG = N'Brazil')
 
 
/*
6. Hiển thị thông tin tất cả các cầu thủ đang thi đấu trong câu lạc bộ có sân nhà là
“Long An”.
*/
SELECT *
FROM dbo.CAUTHU
WHERE MACLB in 
(SELECT MACLB
FROM dbo.CAULACBO
WHERE dbo.CAULACBO.MASAN in
(SELECT MASAN
FROM dbo.SANVD
WHERE dbo.SANVD.TENSAN = N'Long An'))
 
 
 
/*
7. Cho biết kết quả (MATRAN, NGAYTD, TENSAN, TENCLB1, TENCLB2, KETQUA) các
trận đấu vòng 2 của mùa bóng năm 2009.
*/
SELECT MATRAN, NGAYTD, TENSAN, CLB1.TENCLB as TENCLB1, CLB2.TENCLB as TENCLB2, KETQUA
FROM dbo.TRANDAU TD, dbo.SANVD, dbo.CAULACBO as CLB1, dbo.CAULACBO as CLB2
WHERE (TD.VONG = 2) AND (TD.NAM = 2009)
AND (TD.MASAN = dbo.SANVD.MASAN) AND (TD.MACLB1 = clb1.MACLB) AND (TD.MACLB2 = clb2.MACLB)
 
 
 
 
/*
8. Cho biết mã huấn luyện viên, họ tên, ngày sinh, địa chỉ, vai trò và tên CLB
đang làm việc của các huấn luyện viên có quốc tịch “ViệtNam”.
*/
SELECT HLV.MAHLV, HLV.TENHLV, HLV.NGAYSINH, HLV.DIACHI, HLV_CLB.VAITRO, CLB.TENCLB
FROM dbo.HUANLUYENVIEN as HLV, dbo.HLV_CLB, dbo.CAULACBO as CLB
WHERE (HLV.MAHLV = HLV_CLB.MAHLV)
AND (HLV_CLB.MACLB = CLB.MACLB)
AND HLV.MAQG in 
(SELECT MAQG
FROM dbo.QUOCGIA
WHERE dbo.QUOCGIA.TENQG = N'Việt Nam')
 
 
 
/*
9. Lấy tên 3 câu lạc bộ có điểm cao nhất sau vòng 3 năm 2009.
*/
SELECT TOP(3) CLB.TENCLB 
FROM dbo.CAULACBO as CLB, dbo.BANGXH as BXH
WHERE (CLB.MACLB = BXH.MACLB)
AND (BXH.VONG = 3)
AND (BXH.NAM = 2009)
ORDER BY BXH.DIEM DESC
 
 
 
/*
10. Cho biết mã huấn luyện viên, họ tên, ngày sinh, địa chỉ, vai trò và tên CLB đang làm việc
mà câu lạc bộ đó đóng ở tỉnh Binh Dương.
*/
	SELECT HLV.MAHLV, TENHLV, NGAYSINH, DIACHI, VAITRO, TENCLB
	FROM dbo.HUANLUYENVIEN as HLV, dbo.HLV_CLB, dbo.CAULACBO as CLB
	WHERE (HLV.MAHLV = HLV_CLB.MAHLV)
	AND (HLV_CLB.MACLB = CLB.MACLB)
	AND CLB.MATINH IN
	(SELECT MATINH
	FROM dbo.TINH
	WHERE dbo.TINH.TENTINH = N'Bình Dương')
 

/*
*****************************************************************************
*                      b. Các phép toán trên nhóm                           *
*****************************************************************************
*/
 
/*
1. Thống kê số lượng cầu thủ của mỗi câu lạc bộ.
*/
SELECT TENCLB, COUNT(CT.MACT) as 'Số lượng'
FROM dbo.CAUTHU as CT, dbo.CAULACBO as CLB
WHERE CT.MACLB = CLB.MACLB
GROUP BY TENCLB
 
 
 
/*
2. Thống kê số lượng cầu thủ nước ngoài (có quốc tịch khác Việt Nam) của mỗi câu lạc bộ
*/
SELECT TENCLB, COUNT(CT.MACT) as 'Số lượng cầu thủ nước ngoài'
FROM dbo.CAUTHU as CT, dbo.CAULACBO as CLB, dbo.QUOCGIA as QG
WHERE CT.MACLB = CLB.MACLB
AND CT.MAQG = QG.MAQG
AND QG.TENQG != N'Việt Nam'
GROUP BY TENCLB
 
 
 
/*
3. Cho biết mã câu lạc bộ, tên câu lạc bộ, tên sân vận động, địa chỉ và số lượng cầu
thủ nước ngoài (có quốc tịch khác Việt Nam) tương ứng của các câu lạc bộ có nhiều
hơn 2 cầu thủ nước ngoài.
*/
SELECT CLB.MACLB, TENCLB, SVD.TENSAN, SVD.DIACHI, COUNT(CT.MACT) as N'Số lượng cầu thủ nước ngoài'
FROM dbo.CAUTHU as CT, dbo.CAULACBO as CLB, dbo.QUOCGIA as QG, dbo.SANVD as SVD
WHERE CT.MACLB = CLB.MACLB
AND CT.MAQG = QG.MAQG
AND CLB.MASAN = SVD.MASAN
AND QG.TENQG != N'Việt Nam'
GROUP BY CLB.MACLB, TENCLB, SVD.TENSAN, SVD.DIACHI
HAVING COUNT(CT.MACT) > 2
 
 
 
/*
4. Cho biết tên tỉnh, số lượng cầu thủ đang thi đấu ở vị trí tiền đạo trong các câu lạc
bộ thuộc địa bàn tỉnh đó quản lý.
*/
SELECT TENTINH, COUNT(CT.MACT) as 'Số lượng cầu thủ đang thi đấu ở vị trí tiền đạo'
FROM dbo.TINH, dbo.CAULACBO as CLB, dbo.CAUTHU as CT
WHERE CT.MACLB = CLB.MACLB
AND CLB.MATINH = TINH.MATINH
AND CT.VITRI = N'Tiền đạo'
GROUP BY TENTINH
 
 
 
 
/*
5. Cho biết tên câu lạc bộ, tên tỉnh mà CLB đang đóng nằm ở vị trí cao nhất của bảng
xếp hạng vòng 3, năm 2009.
*/
SELECT TOP(1) TENCLB, TENTINH
FROM dbo.TINH, dbo.CAULACBO as CLB, dbo.BANGXH as BXH
WHERE CLB.MATINH = TINH.MATINH
AND CLB.MACLB = BXH.MACLB
AND BXH.VONG = 3
AND BXH.NAM = 2009
ORDER BY BXH.HANG ASC
 
 
 
/*
*****************************************************************************
*                        c. Các toán tử nâng cao                            *
*****************************************************************************
*/

/*
1. Cho biết tên huấn luyện viên đang nắm giữ một vị trí trong một câu lạc bộ
mà chưa có số điện thoại.
*/
SELECT TENHLV
FROM dbo.HUANLUYENVIEN
WHERE DIENTHOAI IS NULL
AND MAHLV in
(SELECT MAHLV
FROM dbo.HLV_CLB)
 
 
/*
2. Liệt kê các huấn luyện viên thuộc quốc gia Việt Nam chưa làm công tác huấn luyện
tại bất kỳ một câu lạc bộ nào.
*/
SELECT TENHLV
FROM dbo.HUANLUYENVIEN
WHERE MAQG in
(SELECT MAQG
FROM dbo.QUOCGIA
WHERE TENQG = N'Việt Nam')
AND MAHLV not in
(SELECT MAHLV
FROM dbo.HLV_CLB)
 
 
 
 
/*
3. Liệt kê các cầu thủ đang thi đấu trong các câu lạc bộ có thứ hạng ở vòng 3 năm 2009
lớn hơn 6 hoặc nhỏ hơn 3.
*/
SELECT HOTEN
FROM dbo.CAUTHU
WHERE MACLB in
(SELECT MACLB
FROM dbo.BANGXH
WHERE VONG = 3
AND NAM = 2009
AND (HANG BETWEEN 3 AND 6))
 
 
 
 
 
/*
4. Cho biết danh sách các trận đấu (NGAYTD, TENSAN, TENCLB1, TENCLB2, KETQUA)
của câu lạc bộ (CLB) đang xếp hạng cao nhất tính đến hết vòng 3 năm 2009.
*/
SELECT TD.NGAYTD, SVD.TENSAN, CLB1.TENCLB as TENCLB1, CLB2.TENCLB as TENCLB2, TD.KETQUA
FROM dbo.TRANDAU as TD, dbo.SANVD as SVD, dbo.CAULACBO as CLB1, dbo.CAULACBO as CLB2
WHERE TD.MASAN = SVD.MASAN
AND TD.MACLB1 = CLB1.MACLB
AND TD.MACLB2 = CLB2.MACLB
AND (CLB1.MACLB in 
(SELECT MACLB
FROM dbo.BANGXH
WHERE VONG = 3
AND NAM = 2009
AND HANG = 1)
or CLB2.MACLB in 
(SELECT MACLB
FROM dbo.BANGXH
WHERE VONG = 3
AND NAM = 2009
AND HANG = 1))
 
 
 


