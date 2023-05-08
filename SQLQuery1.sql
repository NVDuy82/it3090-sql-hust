CREATE DATABASE QLBongDa
GO

USE QLBongDa
GO

/*
	TẠO BẢNG
*/ 
CREATE TABLE dbo.BANGXH(
	MACLB varchar(5) NOT NULL,
	NAM int NOT NULL,
	VONG int NOT NULL,
	SOTRAN int NOT NULL,
	THANG int NOT NULL,
	HOA int NOT NULL,
	THUA int NOT NULL,
	HIEUSO varchar(5) NOT NULL,
	DIEM int NOT NULL,
	HANG int NOT NULL,
 CONSTRAINT PK_BANGXH PRIMARY KEY 
    (
        MACLB ASC,
        NAM ASC,
        VONG ASC
    )
)
GO

CREATE TABLE dbo.CAUTHU(
	MACT NUMERIC IDENTITY(1,1) NOT NULL,
	HOTEN NVARCHAR(100) NOT NULL,
	VITRI NVARCHAR(20) NOT NULL,
	NGAYSINH DATETIME,
	DIACHI NVARCHAR(200),
	MACLB VARCHAR(5) NOT NULL,
	MAQG VARCHAR(5) NOT NULL,
	SO INT NOT NULL,
 CONSTRAINT PK_CAUTHU PRIMARY KEY 
    (
        MACT ASC
    )
)
GO

CREATE TABLE dbo.QUOCGIA(
	MAQG VARCHAR(5) NOT NULL,
	TENQG NVARCHAR(60) NOT NULL,
 CONSTRAINT PK_QUOCGIA PRIMARY KEY 
    (
        MAQG ASC
    )
)
GO

CREATE TABLE dbo.CAULACBO(
	MACLB VARCHAR(5) NOT NULL,
	TENCLB NVARCHAR(100) NOT NULL,
	MASAN VARCHAR(5) NOT NULL,
	MATINH VARCHAR(5) NOT NULL,
 CONSTRAINT PK_CAULACBO PRIMARY KEY 
    (
        MACLB ASC
    )
)
GO

CREATE TABLE dbo.TINH(
	MATINH VARCHAR(5) NOT NULL,
	TENTINH NVARCHAR(100) NOT NULL,
 CONSTRAINT PK_TINH PRIMARY KEY 
    (
        MATINH ASC
    )
)
GO

CREATE TABLE dbo.SANVD(
	MASAN VARCHAR(5) NOT NULL,
	TENSAN NVARCHAR(100) NOT NULL,
	DIACHI NVARCHAR(200),
 CONSTRAINT PK_SANVD PRIMARY KEY 
    (
        MASAN ASC
    )
)
GO

CREATE TABLE dbo.HUANLUYENVIEN(
	MAHLV VARCHAR(5) NOT NULL,
	TENHLV NVARCHAR(100) NOT NULL,
	NGAYSINH DATETIME,
	DIACHI NVARCHAR(200),
	DIENTHOAI NVARCHAR(20),
	MAQG VARCHAR(5) NOT NULL,
	CONSTRAINT PK_HUANLUYENVIEN PRIMARY KEY
	(
		MAHLV ASC
	)
)
GO

CREATE TABLE dbo.HLV_CLB(
	MAHLV VARCHAR(5) NOT NULL,
	MACLB VARCHAR(5) NOT NULL,
	VAITRO NVARCHAR(100) NOT NULL,
	CONSTRAINT PK_HLV_CLB PRIMARY KEY
	(
		MAHLV ASC,
		MACLB ASC
	)
)
GO

CREATE TABLE dbo.TRANDAU(
	MATRAN NUMERIC IDENTITY(1,1) NOT NULL,
	NAM INT NOT NULL,
	VONG INT NOT NULL,
	NGAYTD DATETIME NOT NULL,
	MACLB1 VARCHAR(5) NOT NULL,
	MACLB2 VARCHAR(5) NOT NULL,
	MASAN VARCHAR(5) NOT NULL,
	KETQUA VARCHAR(5) NOT NULL,
	CONSTRAINT PK_TRANDAU PRIMARY KEY
	(
		MATRAN
	)
)
GO


/*
	THÊM QUAN HỆ GIỮA CÁC BẢNG
*/ 
ALTER TABLE dbo.BANGXH ADD CONSTRAINT FK_BANGXH_CAULACBO FOREIGN KEY(MACLB)
REFERENCES dbo.CAULACBO (MACLB)
GO

ALTER TABLE dbo.TRANDAU
ADD CONSTRAINT FK_TRANDAU_CAULACBO FOREIGN KEY(MACLB1)
REFERENCES dbo.CAULACBO (MACLB)
GO

ALTER TABLE dbo.TRANDAU
ADD CONSTRAINT FK_TRANDAU_CAULACBO2 FOREIGN KEY(MACLB2)
REFERENCES dbo.CAULACBO (MACLB)
GO

ALTER TABLE dbo.TRANDAU
ADD CONSTRAINT FK_TRANDAU_SANVD FOREIGN KEY(MASAN)
REFERENCES dbo.SANVD (MASAN)
GO

ALTER TABLE dbo.CAULACBO ADD CONSTRAINT FK_CAULACBO_SANVD FOREIGN KEY(MASAN)
REFERENCES dbo.SANVD (MASAN)
GO

ALTER TABLE dbo.CAULACBO ADD CONSTRAINT FK_CAULACBO_TINH FOREIGN KEY(MATINH)
REFERENCES dbo.TINH (MATINH)
GO

ALTER TABLE dbo.CAUTHU ADD CONSTRAINT FK_CAUTHU_CAULACBO FOREIGN KEY(MACLB)
REFERENCES dbo.CAULACBO (MACLB)
GO

ALTER TABLE dbo.CAUTHU ADD CONSTRAINT FK_CAUTHU_QUOCGIA FOREIGN KEY(MAQG)
REFERENCES dbo.QUOCGIA (MAQG)
GO

ALTER TABLE dbo.HUANLUYENVIEN ADD CONSTRAINT FK_HUANLUYENVIEN_QUOCGIA FOREIGN KEY(MAQG)
REFERENCES dbo.QUOCGIA (MAQG)
GO

ALTER TABLE dbo.HLV_CLB ADD CONSTRAINT FK_HLV_CLB_HUANLUYENVIEN FOREIGN KEY(MAHLV)
REFERENCES dbo.HUANLUYENVIEN (MAHLV)
GO

ALTER TABLE dbo.HLV_CLB ADD CONSTRAINT FK_HLV_CLB_CAULACBO FOREIGN KEY(MACLB)
REFERENCES dbo.CAULACBO (MACLB)
GO

/*
	DỮ LIỆU CÁC BẢNG
*/
INSERT INTO dbo.TINH
(
    MATINH,
    TENTINH
)
VALUES
(   'BD', -- MATINH - varchar(5)
    N'Bình Dương' -- TENTINH - nvarchar(100)
    ),
(   'GL', -- MATINH - varchar(5)
    N'Gia Lai' -- TENTINH - nvarchar(100)
    ),
(   'DN', -- MATINH - varchar(5)
    N'Đà Nẵng' -- TENTINH - nvarchar(100)
    ),
(   'KH', -- MATINH - varchar(5)
    N'Khánh Hòa' -- TENTINH - nvarchar(100)
    ),
(   'PY', -- MATINH - varchar(5)
    N'Phú Yên' -- TENTINH - nvarchar(100)
    ),
(   'LA', -- MATINH - varchar(5)
    N'Long An' -- TENTINH - nvarchar(100)
    )
GO

INSERT INTO dbo.QUOCGIA
(
    MAQG,
    TENQG
)
VALUES
(   'VN', -- MAQG - varchar(5)
    N'Việt NAm' -- TENQG - nvarchar(60)
    ),
(   'ANH', -- MAQG - varchar(5)
    N'Anh Quốc' -- TENQG - nvarchar(60)
    ),
(   'TBN', -- MAQG - varchar(5)
    N'Tây ban nha' -- TENQG - nvarchar(60)
    ),
(   'BDN', -- MAQG - varchar(5)
    N'Bồ Đào Nha' -- TENQG - nvarchar(60)
    ),
(   'BRA', -- MAQG - varchar(5)
    N'Bra-xin' -- TENQG - nvarchar(60)
    ),
(   'ITA', -- MAQG - varchar(5)
    N'Ý' -- TENQG - nvarchar(60)
    ),
(   'THA', -- MAQG - varchar(5)
    N'Thái Lan' -- TENQG - nvarchar(60)
    )
GO

INSERT INTO dbo.SANVD
(
    MASAN,
    TENSAN,
    DIACHI
)
VALUES
(   'GD',  -- MASAN - varchar(5)
    N'Gò Đậu', -- TENSAN - nvarchar(100)
    N'123 QL1, TX Thủ Dầu Một, Bình Dương'  -- DIACHI - nvarchar(200)
    ),
(   'PL',  -- MASAN - varchar(5)
    N'Pleiku', -- TENSAN - nvarchar(100)
    N'22 Hồ Tùng Mậu, Thống Nhất, Thị xã Pleiku, Gia Lai'  -- DIACHI - nvarchar(200)
    ),
(   'CL',  -- MASAN - varchar(5)
    N'Chi Lăng', -- TENSAN - nvarchar(100)
    N'127 Võ Văn Tần, Đà Nẵng'  -- DIACHI - nvarchar(200)
    ),
(   'NT',  -- MASAN - varchar(5)
    N'Nha Trang', -- TENSAN - nvarchar(100)
    N'128 Phan Chu Trinh, Nha Trang, Khánh Hòa'  -- DIACHI - nvarchar(200)
    ),
(   'TH',  -- MASAN - varchar(5)
    N'Tuy Hòa', -- TENSAN - nvarchar(100)
    N'57 Trường Chinh, Tuy Hòa, Phú Yên'  -- DIACHI - nvarchar(200)
    ),
(   'LA',  -- MASAN - varchar(5)
    N'Long An', -- TENSAN - nvarchar(100)
    N'102 Hùng Vương, Tp Tân An, Long An'  -- DIACHI - nvarchar(200)
    )
GO

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
(   'HLV01',        -- MAHLV - varchar(5)
    N'Vital',       -- TENHLV - nvarchar(100)
    '19551015', -- NGAYSINH - datetime
    N'',       -- DIACHI - nvarchar(200)
    N'0918011075',       -- DIENTHOAI - nvarchar(20)
    'BDN'         -- MAQG - varchar(5)
    ),
(   'HLV02',        -- MAHLV - varchar(5)
    N'Lê Huỳnh Đức',       -- TENHLV - nvarchar(100)
    '19720520', -- NGAYSINH - datetime
    N'',       -- DIACHI - nvarchar(200)
    N'01223456789',       -- DIENTHOAI - nvarchar(20)
    'VN'         -- MAQG - varchar(5)
    ),
(   'HLV03',        -- MAHLV - varchar(5)
    N'Kiatisuk',       -- TENHLV - nvarchar(100)
    '19701211', -- NGAYSINH - datetime
    N'',       -- DIACHI - nvarchar(200)
    N'01990123456',       -- DIENTHOAI - nvarchar(20)
    'THA'         -- MAQG - varchar(5)
    ),
(   'HLV04',        -- MAHLV - varchar(5)
    N'Hoàng Anh Tuấn',       -- TENHLV - nvarchar(100)
    '19700610', -- NGAYSINH - datetime
    N'',       -- DIACHI - nvarchar(200)
    N'0989112233',       -- DIENTHOAI - nvarchar(20)
    'VN'         -- MAQG - varchar(5)
    ),
(   'HLV05',        -- MAHLV - varchar(5)
    N'Trần Công Minh',       -- TENHLV - nvarchar(100)
    '19730707', -- NGAYSINH - datetime
    N'',       -- DIACHI - nvarchar(200)
    N'0909099990',       -- DIENTHOAI - nvarchar(20)
    'VN'         -- MAQG - varchar(5)
    ),
(   'HLV06',        -- MAHLV - varchar(5)
    N'Trần Văn Phúc',       -- TENHLV - nvarchar(100)
    '19650302', -- NGAYSINH - datetime
    N'',       -- DIACHI - nvarchar(200)
    N'01650101234',       -- DIENTHOAI - nvarchar(20)
    'VN'         -- MAQG - varchar(5)
    )
GO

INSERT INTO dbo.CAULACBO
(
    MACLB,
    TENCLB,
    MASAN,
    MATINH
)
VALUES
(   'BBD',  -- MACLB - varchar(5)
    N'BECAMEX BÌNH DƯƠNG', -- TENCLB - nvarchar(100)
    'GD',  -- MASAN - varchar(5)
    'BD'   -- MATINH - varchar(5)
    ),
(   'HAGL',  -- MACLB - varchar(5)
    N'HOÀNG ANH GIA LAI', -- TENCLB - nvarchar(100)
    'PL',  -- MASAN - varchar(5)
    'GL'   -- MATINH - varchar(5)
    ),
(   'SDN',  -- MACLB - varchar(5)
    N'SHB ĐÀ NẴNG', -- TENCLB - nvarchar(100)
    'CL',  -- MASAN - varchar(5)
    'DN'   -- MATINH - varchar(5)
    ),
(   'KKH',  -- MACLB - varchar(5)
    N'KHATOCO KHÁNH HÒA', -- TENCLB - nvarchar(100)
    'NT',  -- MASAN - varchar(5)
    'KH'   -- MATINH - varchar(5)
    ),
(   'TPY',  -- MACLB - varchar(5)
    N'THÉP PHÚ YÊN', -- TENCLB - nvarchar(100)
    'TH',  -- MASAN - varchar(5)
    'PY'   -- MATINH - varchar(5)
    ),
(   'GDT',  -- MACLB - varchar(5)
    N'GẠCH ĐỒNG TÂM LONG AN', -- TENCLB - nvarchar(100)
    'LA',  -- MASAN - varchar(5)
    'LA'   -- MATINH - varchar(5)
    )
GO

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
(   N'Nguyễn Vũ Phong',       -- HOTEN - nvarchar(100)
    N'Tiền vệ',       -- VITRI - nvarchar(20)
    '19900220', -- NGAYSINH - datetime
    N'',       -- DIACHI - nvarchar(200)
    'BBD',        -- MACLB - varchar(5)
    'VN',        -- MAQG - varchar(5)
    17          -- SO - int
    ),
(   N'Nguyễn Công Vinh',       -- HOTEN - nvarchar(100)
    N'Tiền đạo',       -- VITRI - nvarchar(20)
    '19920310', -- NGAYSINH - datetime
    N'',       -- DIACHI - nvarchar(200)
    'HAGL',        -- MACLB - varchar(5)
    'VN',        -- MAQG - varchar(5)
    9          -- SO - int
    ),
(   N'Trần Tấn Tài',       -- HOTEN - nvarchar(100)
    N'Tiền vệ',       -- VITRI - nvarchar(20)
    '19891112', -- NGAYSINH - datetime
    N'',       -- DIACHI - nvarchar(200)
    'BBD',        -- MACLB - varchar(5)
    'VN',        -- MAQG - varchar(5)
    8          -- SO - int
    ),
(   N'Phan Hồng Sơn',       -- HOTEN - nvarchar(100)
    N'Thủ môn',       -- VITRI - nvarchar(20)
    '19891112', -- NGAYSINH - datetime
    N'',       -- DIACHI - nvarchar(200)
    'HAGL',        -- MACLB - varchar(5)
    'VN',        -- MAQG - varchar(5)
    1          -- SO - int
    ),
(   N'Ronaldo',       -- HOTEN - nvarchar(100)
    N'Tiền vệ',       -- VITRI - nvarchar(20)
    '19891212', -- NGAYSINH - datetime
    N'',       -- DIACHI - nvarchar(200)
    'SDN',        -- MACLB - varchar(5)
    'BRA',        -- MAQG - varchar(5)
    7          -- SO - int
    ),
(   N'Robinho',       -- HOTEN - nvarchar(100)
    N'Tiền vệ',       -- VITRI - nvarchar(20)
    '19891012', -- NGAYSINH - datetime
    N'',       -- DIACHI - nvarchar(200)
    'SDN',        -- MACLB - varchar(5)
    'BRA',        -- MAQG - varchar(5)
    8          -- SO - int
    ),
(   N'Vidic',       -- HOTEN - nvarchar(100)
    N'Hậu vệ',       -- VITRI - nvarchar(20)
    '19871015', -- NGAYSINH - datetime
    N'',       -- DIACHI - nvarchar(200)
    'HAGL',        -- MACLB - varchar(5)
    'ANH',        -- MAQG - varchar(5)
    3          -- SO - int
    ),
(   N'Trần Văn Santos',       -- HOTEN - nvarchar(100)
    N'Thủ môn',       -- VITRI - nvarchar(20)
    '19901021', -- NGAYSINH - datetime
    N'',       -- DIACHI - nvarchar(200)
    'BBD',        -- MACLB - varchar(5)
    'BRA',        -- MAQG - varchar(5)
    1          -- SO - int
    ),
(   N'Nguyễn Trường Sơn',       -- HOTEN - nvarchar(100)
    N'Hậu vệ',       -- VITRI - nvarchar(20)
    '19930826', -- NGAYSINH - datetime
    N'',       -- DIACHI - nvarchar(200)
    'BBD',        -- MACLB - varchar(5)
    'VN',        -- MAQG - varchar(5)
    4          -- SO - int
    )
GO

INSERT INTO dbo.HLV_CLB
(
    MAHLV,
    MACLB,
    VAITRO
)
VALUES
(   'HLV01', -- MAHLV - varchar(5)
    'BBD', -- MACLB - varchar(5)
    N'HLV Chính' -- VAITRO - nvarchar(100)
    ),
(   'HLV02', -- MAHLV - varchar(5)
    'SDN', -- MACLB - varchar(5)
    N'HLV Chính' -- VAITRO - nvarchar(100)
    ),
(   'HLV03', -- MAHLV - varchar(5)
    'HAGL', -- MACLB - varchar(5)
    N'HLV Chính' -- VAITRO - nvarchar(100)
    ),
(   'HLV04', -- MAHLV - varchar(5)
    'KKH', -- MACLB - varchar(5)
    N'HLV Chính' -- VAITRO - nvarchar(100)
    ),
(   'HLV05', -- MAHLV - varchar(5)
    'GDT', -- MACLB - varchar(5)
    N'HLV Chính' -- VAITRO - nvarchar(100)
    ),
(   'HLV06', -- MAHLV - varchar(5)
    'BBD', -- MACLB - varchar(5)
    N'HLV Thủ môn' -- VAITRO - nvarchar(100)
    )
GO

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
(   2009,         -- NAM - int
    1,         -- VONG - int
    '20090207', -- NGAYTD - datetime
    'BBD',        -- MACLB1 - varchar(5)
    'SDN',        -- MACLB2 - varchar(5)
    'GD',        -- MASAN - varchar(5)
    '3-0'         -- KETQUA - varchar(5)
    ),
(   2009,         -- NAM - int
    1,         -- VONG - int
    '20090207', -- NGAYTD - datetime
    'KKH',        -- MACLB1 - varchar(5)
    'GDT',        -- MACLB2 - varchar(5)
    'NT',        -- MASAN - varchar(5)
    '1-1'         -- KETQUA - varchar(5)
    ),
(   2009,         -- NAM - int
    2,         -- VONG - int
    '20090216', -- NGAYTD - datetime
    'SDN',        -- MACLB1 - varchar(5)
    'KKH',        -- MACLB2 - varchar(5)
    'CL',        -- MASAN - varchar(5)
    '2-2'         -- KETQUA - varchar(5)
    ),
(   2009,         -- NAM - int
    2,         -- VONG - int
    '20090216', -- NGAYTD - datetime
    'TPY',        -- MACLB1 - varchar(5)
    'BBD',        -- MACLB2 - varchar(5)
    'TH',        -- MASAN - varchar(5)
    '5-0'         -- KETQUA - varchar(5)
    ),
(   2009,         -- NAM - int
    3,         -- VONG - int
    '20090301', -- NGAYTD - datetime
    'TPY',        -- MACLB1 - varchar(5)
    'GDT',        -- MACLB2 - varchar(5)
    'TH',        -- MASAN - varchar(5)
    '0-2'         -- KETQUA - varchar(5)
    ),
(   2009,         -- NAM - int
    3,         -- VONG - int
    '20090301', -- NGAYTD - datetime
    'KKH',        -- MACLB1 - varchar(5)
    'BBD',        -- MACLB2 - varchar(5)
    'NT',        -- MASAN - varchar(5)
    '0-1'         -- KETQUA - varchar(5)
    ),
(   2009,         -- NAM - int
    4,         -- VONG - int
    '20090307', -- NGAYTD - datetime
    'KKH',        -- MACLB1 - varchar(5)
    'TPY',        -- MACLB2 - varchar(5)
    'NT',        -- MASAN - varchar(5)
    '1-0'         -- KETQUA - varchar(5)
    ),
(   2009,         -- NAM - int
    4,         -- VONG - int
    '20090307', -- NGAYTD - datetime
    'BBD',        -- MACLB1 - varchar(5)
    'GDT',        -- MACLB2 - varchar(5)
    'GD',        -- MASAN - varchar(5)
    '2-2'         -- KETQUA - varchar(5)
    )
GO

INSERT INTO dbo.BANGXH( 
    MACLB,
    NAM,
    VONG,
    SOTRAN,
    THANG,
    HOA,
    THUA,
    HIEUSO,
    DIEM,
    HANG)
VALUES
(   'BBD', -- MACLB - varchar(5)
    2009,  -- NAM - int
    1,  -- VONG - int
    1,  -- SOTRAN - int
    1,  -- THANG - int
    0,  -- HOA - int
    0,  -- THUA - int
    '3-0', -- HIEUSO - varchar(5)
    3,  -- DIEM - int
    1   -- HANG - int
    ),
(   'KKH', -- MACLB - varchar(5)
    2009,  -- NAM - int
    1,  -- VONG - int
    1,  -- SOTRAN - int
    0,  -- THANG - int
    1,  -- HOA - int
    0,  -- THUA - int
    '1-1', -- HIEUSO - varchar(5)
    1,  -- DIEM - int
    2   -- HANG - int
    ),
(   'GDT', -- MACLB - varchar(5)
    2009,  -- NAM - int
    1,  -- VONG - int
    1,  -- SOTRAN - int
    0,  -- THANG - int
    1,  -- HOA - int
    0,  -- THUA - int
    '1-1', -- HIEUSO - varchar(5)
    1,  -- DIEM - int
    3   -- HANG - int
    ),
(   'TPY', -- MACLB - varchar(5)
    2009,  -- NAM - int
    1,  -- VONG - int
    0,  -- SOTRAN - int
    0,  -- THANG - int
    0,  -- HOA - int
    0,  -- THUA - int
    '0-0', -- HIEUSO - varchar(5)
    0,  -- DIEM - int
    4   -- HANG - int
    ),
(   'SDN', -- MACLB - varchar(5)
    2009,  -- NAM - int
    1,  -- VONG - int
    1,  -- SOTRAN - int
    0,  -- THANG - int
    0,  -- HOA - int
    1,  -- THUA - int
    '0-3', -- HIEUSO - varchar(5)
    0,  -- DIEM - int
    5   -- HANG - int
    ),
(   'TPY', -- MACLB - varchar(5)
    2009,  -- NAM - int
    2,  -- VONG - int
    1,  -- SOTRAN - int
    1,  -- THANG - int
    0,  -- HOA - int
    0,  -- THUA - int
    '5-0', -- HIEUSO - varchar(5)
    3,  -- DIEM - int
    1   -- HANG - int
    ),
(   'BBD', -- MACLB - varchar(5)
    2009,  -- NAM - int
    2,  -- VONG - int
    2,  -- SOTRAN - int
    1,  -- THANG - int
    0,  -- HOA - int
    1,  -- THUA - int
    '3-5', -- HIEUSO - varchar(5)
    3,  -- DIEM - int
    2   -- HANG - int
    ),
(   'KKH', -- MACLB - varchar(5)
    2009,  -- NAM - int
    2,  -- VONG - int
    2,  -- SOTRAN - int
    0,  -- THANG - int
    2,  -- HOA - int
    0,  -- THUA - int
    '3-3', -- HIEUSO - varchar(5)
    2,  -- DIEM - int
    3   -- HANG - int
    ),
(   'GDT', -- MACLB - varchar(5)
    2009,  -- NAM - int
    2,  -- VONG - int
    1,  -- SOTRAN - int
    0,  -- THANG - int
    1,  -- HOA - int
    0,  -- THUA - int
    '1-1', -- HIEUSO - varchar(5)
    1,  -- DIEM - int
    4   -- HANG - int
    ),
(   'SDN', -- MACLB - varchar(5)
    2009,  -- NAM - int
    2,  -- VONG - int
    2,  -- SOTRAN - int
    1,  -- THANG - int
    1,  -- HOA - int
    0,  -- THUA - int
    '2-5', -- HIEUSO - varchar(5)
    1,  -- DIEM - int
    5   -- HANG - int
    ),
(   'BBD', -- MACLB - varchar(5)
    2009,  -- NAM - int
    3,  -- VONG - int
    3,  -- SOTRAN - int
    2,  -- THANG - int
    0,  -- HOA - int
    1,  -- THUA - int
    '4-5', -- HIEUSO - varchar(5)
    6,  -- DIEM - int
    1   -- HANG - int
    ),
(   'GDT', -- MACLB - varchar(5)
    2009,  -- NAM - int
    3,  -- VONG - int
    2,  -- SOTRAN - int
    1,  -- THANG - int
    1,  -- HOA - int
    0,  -- THUA - int
    '3-1', -- HIEUSO - varchar(5)
    4,  -- DIEM - int
    2   -- HANG - int
    ),
(   'TPY', -- MACLB - varchar(5)
    2009,  -- NAM - int
    3,  -- VONG - int
    2,  -- SOTRAN - int
    1,  -- THANG - int
    0,  -- HOA - int
    1,  -- THUA - int
    '5-2', -- HIEUSO - varchar(5)
    3,  -- DIEM - int
    3   -- HANG - int
    ),
(   'KKH', -- MACLB - varchar(5)
    2009,  -- NAM - int
    3,  -- VONG - int
    3,  -- SOTRAN - int
    0,  -- THANG - int
    2,  -- HOA - int
    1,  -- THUA - int
    '3-4', -- HIEUSO - varchar(5)
    2,  -- DIEM - int
    4   -- HANG - int
    ),
(   'SDN', -- MACLB - varchar(5)
    2009,  -- NAM - int
    3,  -- VONG - int
    2,  -- SOTRAN - int
    1,  -- THANG - int
    1,  -- HOA - int
    0,  -- THUA - int
    '2-5', -- HIEUSO - varchar(5)
    1,  -- DIEM - int
    5   -- HANG - int
    ),
(   'BBD', -- MACLB - varchar(5)
    2009,  -- NAM - int
    4,  -- VONG - int
    4,  -- SOTRAN - int
    2,  -- THANG - int
    1,  -- HOA - int
    1,  -- THUA - int 
    '6-7', -- HIEUSO - varchar(5)
    7,  -- DIEM - int
    1   -- HANG - int
    ),
(   'GDT', -- MACLB - varchar(5)
    2009,  -- NAM - int
    4,  -- VONG - int
    3,  -- SOTRAN - int
    1,  -- THANG - int
    2,  -- HOA - int
    0,  -- THUA - int
    '5-1', -- HIEUSO - varchar(5)
    5,  -- DIEM - int
    2   -- HANG - int
    ),
(   'KKH', -- MACLB - varchar(5)
    2009,  -- NAM - int
    4,  -- VONG - int
    4,  -- SOTRAN - int
    1,  -- THANG - int
    2,  -- HOA - int
    1,  -- THUA - int
    '4-4', -- HIEUSO - varchar(5)
    5,  -- DIEM - int
    3   -- HANG - int
    ),
(   'TPY', -- MACLB - varchar(5)
    2009,  -- NAM - int
    4,  -- VONG - int
    3,  -- SOTRAN - int
    1,  -- THANG - int
    0,  -- HOA - int
    2,  -- THUA - int
    '5-3', -- HIEUSO - varchar(5)
    3,  -- DIEM - int
    4   -- HANG - int
    ),
(   'SDN', -- MACLB - varchar(5)
    2009,  -- NAM - int
    4,  -- VONG - int
    2,  -- SOTRAN - int
    1,  -- THANG - int
    1,  -- HOA - int
    0,  -- THUA - int
    '2-5', -- HIEUSO - varchar(5)
    1,  -- DIEM - int
    5   -- HANG - int
    )
GO