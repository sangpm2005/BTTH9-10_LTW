using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BaiTH10.Models
{
    public class GioHang
    {
        public List<CartItem> lst;
        public GioHang()
        {
            lst = new List<CartItem>();
        }
        public GioHang(List<CartItem> lstGH)
        {
            lst = lstGH;
        }
        //Tinh so mat hang
        public int SoMatHang()
        {
            return lst.Count;
        }
        //Tinh tong so luong mat hang
        public int TongSLHang()
        {
            return lst.Sum(n => n.iSoLuong);
        }
        public double TongThanhTien()
        {
            return lst.Sum(n => n.ThanhTien);
        }
        //Them san pham
        public int Them(int iMaSach)
        {
            //Kiem tra san pham co trong ds chua?
            CartItem sp = lst.Find(n => n.iMaSach == iMaSach);
            if(sp == null)
            {
                CartItem sach = new CartItem(iMaSach);
                if (sach == null)
                    return -1;
                lst.Add(sach);
            }
            else
            {
                sp.iSoLuong++;
            }
            return 1;
        }
    }
}