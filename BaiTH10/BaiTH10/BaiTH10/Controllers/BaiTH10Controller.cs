using BaiTH10.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace BaiTH10.Controllers
{
    public class BaiTH10Controller : Controller
    {
        // GET: BaiTH10
        QL_BANHANGEntities data = new QL_BANHANGEntities();
        public ActionResult Index()
        {
            List<SanPham> ds = data.SanPhams.ToList();
            return View(ds);
        }
        public ActionResult Login()
        {
            return View();
        }
        [HttpPost]
        public ActionResult Login(string tk, string mk)
        {
            KhachHang kh = data.KhachHangs.FirstOrDefault(s => s.TenKH == tk && s.SoDienThoai == mk);
            if (kh != null)
            {
                Session["TenKH"] = kh.TenKH;
                return RedirectToAction("Index", "BaiTH10");
            }
            else
            {
                ViewBag.Message = "Tài khoản hoặc mật khẩu không hợp lệ!";
                return View(ViewBag);
            }
        }
        public ActionResult Logout()
        {
            Session.Clear();
            return RedirectToAction("Login", "BaiTH10");
        }
        public ActionResult ThemMatHang(int msp)
        {
            GioHang gh = (GioHang)Session["gh"];
            if(gh == null) 
            {
                gh = new GioHang();
            }
            int kq = gh.Them(msp);
            Session["gh"] = gh;

            return RedirectToAction("Index", "BaiTH10");
        }
        public ActionResult XemGioHang()
        {
            GioHang gh = Session["gh"] as GioHang;
            if (gh == null)
            {
                gh = new GioHang(); 
            }
            return View(gh);
        }
    }
}