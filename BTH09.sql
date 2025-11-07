-- Tạo cơ sở dữ liệu
CREATE DATABASE QL_BANSACH;
GO

USE QL_BANSACH;
GO

-- Bảng ChuDe
CREATE TABLE ChuDe (
    MaChuDe INT IDENTITY(1,1) PRIMARY KEY,
    TenChuDe NVARCHAR(100) NOT NULL
);

-- Bảng TacGia
CREATE TABLE TacGia (
    MaTacGia INT IDENTITY(1,1) PRIMARY KEY,
    TenTacGia NVARCHAR(100) NOT NULL,
    DiaChi NVARCHAR(200),
    TieuSu NVARCHAR(MAX),
    DienThoai NVARCHAR(20)
);

-- Bảng NhaXuatBan
CREATE TABLE NhaXuatBan (
    MaNXB INT IDENTITY(1,1) PRIMARY KEY,
    TenNXB NVARCHAR(100) NOT NULL,
    DiaChi NVARCHAR(200),
    DienThoai NVARCHAR(20)
);

-- Bảng KhachHang
CREATE TABLE KhachHang (
    MaKH INT IDENTITY(1,1) PRIMARY KEY,
    HoTen NVARCHAR(100) NOT NULL,
    NgaySinh DATE,
    GioiTinh NVARCHAR(10),
    DienThoai NVARCHAR(20),
    TaiKhoan NVARCHAR(50) UNIQUE,
    MatKhau NVARCHAR(100),
    Email NVARCHAR(100),
    DiaChi NVARCHAR(200)
);

-- Bảng Sach
CREATE TABLE Sach (
    MaSach INT IDENTITY(1,1) PRIMARY KEY,
    TenSach NVARCHAR(200) NOT NULL,
    GiaBan DECIMAL(18,2),
    MoTa NVARCHAR(MAX),
    NgayCapNhat DATE,
    AnhBia NVARCHAR(200),
    SoLuongTon INT,
    MaChuDe INT,
    MaNXB INT,
    Moi BIT,
    FOREIGN KEY (MaChuDe) REFERENCES ChuDe(MaChuDe),
    FOREIGN KEY (MaNXB) REFERENCES NhaXuatBan(MaNXB)
);

-- Bảng ThamGia (liên kết Sách - Tác Giả)
CREATE TABLE ThamGia (
    MaSach INT,
    MaTacGia INT,
    VaiTro NVARCHAR(50),
    ViTri NVARCHAR(50),
    PRIMARY KEY (MaSach, MaTacGia),
    FOREIGN KEY (MaSach) REFERENCES Sach(MaSach),
    FOREIGN KEY (MaTacGia) REFERENCES TacGia(MaTacGia)
);

-- Bảng DonHang
CREATE TABLE DonHang (
    MaDonHang INT IDENTITY(1,1) PRIMARY KEY,
    NgayGiao DATE,
    NgayDat DATE,
    DaThanhToan BIT,
    TinhTrangGiaoHang NVARCHAR(100),
    MaKH INT,
    FOREIGN KEY (MaKH) REFERENCES KhachHang(MaKH)
);

-- Bảng ChiTietDonHang
CREATE TABLE ChiTietDonHang (
    MaDonHang INT,
    MaSach INT,
    SoLuong INT,
    DonGia DECIMAL(18,2),
    PRIMARY KEY (MaDonHang, MaSach),
    FOREIGN KEY (MaDonHang) REFERENCES DonHang(MaDonHang),
    FOREIGN KEY (MaSach) REFERENCES Sach(MaSach)
);

-- Bảng ChuDe
INSERT INTO ChuDe (TenChuDe)
VALUES 
(N'Khoa học'), 
(N'Văn học'), 
(N'Thiếu nhi'), 
(N'Công nghệ thông tin');

-- Bảng TacGia
INSERT INTO TacGia (TenTacGia, DiaChi, TieuSu, DienThoai)
VALUES
(N'Nguyễn Nhật Ánh', N'TP. Hồ Chí Minh', N'Chuyên viết truyện thiếu nhi', N'0909123456'),
(N'Trần Đăng Khoa', N'Hà Nội', N'Nhà thơ nổi tiếng', N'0912233445'),
(N'Võ Tòng Sơn', N'Đà Nẵng', N'Giảng viên đại học chuyên ngành CNTT', N'0988776655');

-- Bảng NhaXuatBan
INSERT INTO NhaXuatBan (TenNXB, DiaChi, DienThoai)
VALUES
(N'NXB Trẻ', N'161B Lý Chính Thắng, Q.3, TP.HCM', N'02838431234'),
(N'NXB Giáo Dục', N'81 Trần Hưng Đạo, Hà Nội', N'02438223344'),
(N'NXB Khoa Học & Kỹ Thuật', N'25 Nguyễn Du, Hà Nội', N'02439443322');

-- Bảng KhachHang
INSERT INTO KhachHang (HoTen, NgaySinh, GioiTinh, DienThoai, TaiKhoan, MatKhau, Email, DiaChi)
VALUES
(N'Lê Minh Sang', '2003-05-15', N'Nam', N'0909888777', N'sanglm', N'123456', N'sang@gmail.com', N'Quảng Ngãi'),
(N'Trần Thị Lan', '1999-08-22', N'Nữ', N'0911222333', N'lantran', N'abc123', N'lantran@yahoo.com', N'Hà Nội'),
(N'Phạm Quốc Anh', '2001-02-11', N'Nam', N'0933444555', N'quocanh', N'qwe123', N'anhp@gmail.com', N'TP.HCM');

-- Bảng Sach
INSERT INTO Sach (TenSach, GiaBan, MoTa, NgayCapNhat, AnhBia, SoLuongTon, MaChuDe, MaNXB, Moi)
VALUES
(N'Mắt Biếc', 85000, N'Truyện nổi tiếng của Nguyễn Nhật Ánh', '2023-06-01', N'matbiec.jpg', 50, 2, 1, 1),
(N'Thơ Trần Đăng Khoa', 60000, N'Tuyển tập thơ chọn lọc', '2023-05-12', N'thokhoa.jpg', 30, 2, 2, 0),
(N'Lập Trình Python Cơ Bản', 120000, N'Sách học Python cho người mới bắt đầu', '2024-02-10', N'python.jpg', 20, 4, 3, 1),
(N'Truyện Thiếu Nhi Hay Nhất', 70000, N'Tuyển chọn các truyện cho trẻ em', '2023-07-18', N'thieunhi.jpg', 40, 3, 1, 0);

-- Bảng ThamGia (liên kết Sách - Tác Giả)
INSERT INTO ThamGia (MaSach, MaTacGia, VaiTro, ViTri)
VALUES
(1, 1, N'Tác giả chính', N'1'),
(2, 2, N'Tác giả chính', N'1'),
(3, 3, N'Biên soạn', N'1'),
(4, 1, N'Đồng tác giả', N'2');

-- Bảng DonHang
INSERT INTO DonHang (NgayGiao, NgayDat, DaThanhToan, TinhTrangGiaoHang, MaKH)
VALUES
('2024-05-05', '2024-05-01', 1, N'Đã giao', 1),
('2024-06-02', '2024-05-30', 0, N'Đang xử lý', 2),
('2024-07-10', '2024-07-08', 1, N'Đang giao', 3);

-- Bảng ChiTietDonHang
INSERT INTO ChiTietDonHang (MaDonHang, MaSach, SoLuong, DonGia)
VALUES
(1, 1, 1, 85000),
(1, 3, 1, 120000),
(2, 4, 2, 70000),
(3, 2, 1, 60000),
(3, 1, 1, 85000);
