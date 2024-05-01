import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kasir/admin/laporan-transaksi/laporan-transaksi.dart';
import 'package:kasir/admin/login/login.dart';
import 'package:kasir/petugas/data-barang/lihat-barang.dart';
import 'package:kasir/petugas/kelola-member/kelola-member.dart';
import 'package:kasir/petugas/transaksi/transaksi..dart';

class HomePetugas extends StatelessWidget {
  const HomePetugas({Key? key});

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: GoogleFonts.poppins(), // Menggunakan font Poppins secara default
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  height: 100,
                  width: 350,
                  child: Image.asset(
                    'images/mycashier.jpg',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  _showLogoutConfirmationDialog(context);
                },
                icon: Icon(
                  Icons.logout,
                  color: Color(0xFFEA5A05),
                ), // Icon logout
              ),
            ],
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: ListView(
            children: [
              ListTile(
                leading: Icon(
                  Icons.inventory_outlined,
                  color: Color(0xFFEA5A05),
                ), // Icon untuk Data Barang
                title: Text(
                  'Data Barang',
                  style: GoogleFonts.poppins(), // Menggunakan font Poppins
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LihatBarang()));
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.shopping_cart_outlined,
                  color: Color(0xFFEA5A05),
                ), // Icon untuk Transaksi
                title: Text(
                  'Transaksi',
                  style: GoogleFonts.poppins(), // Menggunakan font Poppins
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Transaksi()));
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.history_outlined,
                  color: Color(0xFFEA5A05),
                ), // Icon untuk Riwayat Transaksi
                title: Text(
                  'Riwayat Transaksi',
                  style: GoogleFonts.poppins(), // Menggunakan font Poppins
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RiwayatTransaksiPage()));
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.group_outlined,
                  color: Color(0xFFEA5A05),
                ), // Icon untuk Member
                title: Text(
                  'Member',
                  style: GoogleFonts.poppins(), // Menggunakan font Poppins
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => KelolaMember()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Logout", style: GoogleFonts.poppins()),
          content:
              Text("Anda yakin ingin logout?", style: GoogleFonts.poppins()),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Navigasi langsung ke halaman login
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                  (route) => false, // Hindari kembali ke halaman sebelumnya
                );
              },
              child: Text(
                "Ya",
                style: GoogleFonts.poppins(
                  color: Color(0xFFEA5A05),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Tutup dialog jika tidak logout
              },
              child: Text(
                "Tidak",
                style: GoogleFonts.poppins(
                  color: Color(0xFFEA5A05),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
