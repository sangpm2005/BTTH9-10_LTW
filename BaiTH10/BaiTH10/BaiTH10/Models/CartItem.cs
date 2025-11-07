using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BaiTH10.Models
{
    public class CartItem
    {
        public int iMaSach {  get; set; }
        public string sTenSach {  get; set; }
        public string sAnhBia { get; set; }
        public double dDonGia { get; set; }
        public int iSoLuong { get; set; }
        public double ThanhTien
        {
            get { return iSoLuong * dDonGia; }
        }

        QL_BANHANGEntities data = new QL_BANHANGEntities();

        //Ham tao cho gio hang
        public CartItem(int MaSach)
        {
            SanPham sp = data.SanPhams.Single(n => n.MaSanPham == MaSach);

            if(sp!=null)
            {
                iMaSach = MaSach;
                sTenSach = sp.TenSP;
                sAnhBia = sp.HinhAnh;
                dDonGia = double.Parse(sp.DonGia.ToString());
                iSoLuong = 1;
            }    
        }
    }
}