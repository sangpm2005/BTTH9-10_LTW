CREATE DATABASE QL_BANHANG;
GO

USE QL_BANHANG;
GO

CREATE TABLE SanPham (
    MaSanPham INT IDENTITY(1,1) PRIMARY KEY,
    TenSP NVARCHAR(100) NOT NULL,
    DonGia DECIMAL(18,2) CHECK (DonGia >= 0),
    HinhAnh NVARCHAR(255),
    MoTa NVARCHAR(255),
    SoLuongTon INT CHECK (SoLuongTon >= 0)
);

CREATE TABLE KhachHang (
    MaKhachHang INT IDENTITY(1,1) PRIMARY KEY,
    TenKH NVARCHAR(100) NOT NULL,
    DiaChi NVARCHAR(200),
    SoDienThoai VARCHAR(15)
);

CREATE TABLE HoaDon (
    MaHoaDon INT IDENTITY(1,1) PRIMARY KEY,
    NgayHoaDon DATE DEFAULT GETDATE(),
    MaKH INT,
    FOREIGN KEY (MaKH) REFERENCES KhachHang(MaKhachHang)
);

CREATE TABLE ChiTiet (
    MaHD INT,
    MaSP INT,
    SoLuong INT CHECK (SoLuong > 0),
    PRIMARY KEY (MaHD, MaSP),
    FOREIGN KEY (MaHD) REFERENCES HoaDon(MaHoaDon),
    FOREIGN KEY (MaSP) REFERENCES SanPham(MaSanPham)
);

INSERT INTO SanPham (TenSP, DonGia, HinhAnh, MoTa, SoLuongTon)
VALUES
(N'Chuột Logitech M331', 350000, 'chuot_m331.jpg', N'Chuột không dây Logitech M331 Silent', 50),
(N'Bàn phím cơ AKKO 3087', 1500000, 'banphim_akko3087.jpg', N'Bàn phím cơ AKKO 3087 với switch Brown', 30),
(N'Màn hình Samsung 24"', 2800000, 'manhinh_samsung24.jpg', N'Màn hình LED Full HD 24 inch', 20),
(N'Tai nghe Sony WH-CH520', 1200000, 'tainghe_sony.jpg', N'Tai nghe Bluetooth Sony WH-CH520', 40),
(N'USB Kingston 32GB', 150000, 'usb_kingston.jpg', N'USB 3.0 32GB Kingston DataTraveler', 100);

INSERT INTO KhachHang (TenKH, DiaChi, SoDienThoai)
VALUES
(N'Nguyễn Văn A', N'Quận 1, TP.HCM', '0912345678'),
(N'Lê Thị B', N'Quận 3, TP.HCM', '0987654321'),
(N'Trần Văn C', N'Quận Bình Thạnh, TP.HCM', '0909090909');

INSERT INTO HoaDon (NgayHoaDon, MaKH)
VALUES
('2025-11-01', 1),
('2025-11-02', 2),
('2025-11-03', 3);

INSERT INTO ChiTiet (MaHD, MaSP, SoLuong)
VALUES
(1, 1, 2),   
(1, 5, 1),   
(2, 2, 1),   
(3, 3, 1),   
(3, 4, 2);   

