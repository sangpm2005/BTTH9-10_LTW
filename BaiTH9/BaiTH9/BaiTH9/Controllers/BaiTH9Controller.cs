using BaiTH9.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Data.Entity;

namespace BaiTH9.Controllers
{
    public class BaiTH9Controller : Controller
    {
        // GET: BaiTH9
        QL_BANSACHEntities data = new QL_BANSACHEntities();
        public ActionResult DSMenu_ChuDe()
        {
            List <ChuDe> ds = data.ChuDes.ToList();
            return PartialView(ds);
        }
        public ActionResult DSMenu_NXB()
        {
            List<NhaXuatBan> ds = data.NhaXuatBans.ToList();
            return PartialView(ds);
        }
        public ActionResult Index()
        {
            List<Sach> ds = data.Saches.OrderByDescending(s=>s.NgayCapNhat).Take(5).ToList();
            return View(ds);
        }
        public ActionResult Details(int id) 
        {
            var sach = data.Saches.Include(s => s.ThamGias.Select(tg => tg.TacGia)).FirstOrDefault(s => s.MaSach == id);
            return View(sach);
        }
        public ActionResult HTSachTheoChuDe(int id)
        {
            var sach = data.Saches
                           .Where(s => s.MaChuDe == id)
                           .OrderByDescending(s => s.GiaBan)
                           .ToList();
            return View(sach);
        }
        public ActionResult HTSachTheoNXB(int id)
        {
            var sach = data.Saches
                           .Where(s => s.MaNXB == id)
                           .OrderBy(s => s.GiaBan)
                           .ToList();
            return View(sach);
        }
        public ActionResult Login() 
        {
            return View();
        }
        [HttpPost]
        public ActionResult Login(string tk, string mk)
        {
            var user = data.KhachHangs.FirstOrDefault(lg => lg.TaiKhoan == tk && lg.MatKhau == mk);
            if(user == null)
            {
                ViewBag.Error = "Tài khoản hoặc mật khẩu không đúng, vui lòng nhập lại!";
                return View(ViewBag);
            }
            else 
                return RedirectToAction("Index");
        }
        public ActionResult Register()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Register(FormCollection collection)
        {
            string hoten = collection["fullname"];
            string email = collection["email"];
            string phone = collection["phone"];
            string taikhoan = collection["username"];
            string password = collection["password"];
            string confirmPassword = collection["confirmPassword"];

            // Kiểm tra dữ liệu nhập
            if (string.IsNullOrEmpty(hoten) || string.IsNullOrEmpty(email) ||
                string.IsNullOrEmpty(phone) || string.IsNullOrEmpty(taikhoan) || string.IsNullOrEmpty(password))
            {
                ViewBag.Error = "Vui lòng nhập đầy đủ thông tin!";
                return View();
            }

            if (password != confirmPassword)
            {
                ViewBag.Error = "Mật khẩu xác nhận không khớp!";
                return View();
            }

            // Kiểm tra trùng tài khoản, email hoặc số điện thoại
            var checkTK = data.KhachHangs.FirstOrDefault(k => k.TaiKhoan == taikhoan);
            var checkEmail = data.KhachHangs.FirstOrDefault(k => k.Email == email);
            var checkPhone = data.KhachHangs.FirstOrDefault(k => k.DienThoai == phone);

            if (checkTK != null)
            {
                ViewBag.Error = "Tài khoản này đã được sử dụng!";
                return View();
            }
            if (checkEmail != null)
            {
                ViewBag.Error = "Email này đã được sử dụng!";
                return View();
            }
            if (checkPhone != null)
            {
                ViewBag.Error = "Số điện thoại này đã được đăng ký!";
                return View();
            }

            // Tạo mới khách hàng
            KhachHang kh = new KhachHang();
            kh.HoTen = hoten;
            kh.Email = email;
            kh.DienThoai = phone;
            kh.TaiKhoan = taikhoan;
            kh.MatKhau = password; // Có thể mã hóa SHA256 nếu cần
            kh.NgaySinh = DateTime.Now; // tạm gán
            kh.GioiTinh = "Nam"; // mặc định, nếu chưa có chọn
            kh.DiaChi = "";

            data.KhachHangs.Add(kh);
            data.SaveChanges();

            TempData["Success"] = "Đăng ký thành công! Hãy đăng nhập để tiếp tục.";
            return RedirectToAction("Login");
        }

    }
}