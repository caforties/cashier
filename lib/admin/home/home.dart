import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kasir/admin/kelola-barang/kelola-barang.dart';
import 'package:kasir/admin/kelola-petugas/kelola-petugas.dart';
import 'package:kasir/admin/laporan-transaksi/laporan-transaksi.dart';
import 'package:kasir/admin/lihat-member/lihat-member.dart';
import 'package:kasir/admin/login/login.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: [
            ListTile(
              leading: Icon(Icons.inventory_outlined,  color: Color(0xFFEA5A05),),
              title: Text('Data Barang', style: GoogleFonts.poppins()),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => KelolaBarang()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.group_outlined,  color: Color(0xFFEA5A05),),
              title: Text('Petugas', style: GoogleFonts.poppins()),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => KelolaPetugas()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.history_outlined,  color: Color(0xFFEA5A05),),
              title: Text('Riwayat Transaksi', style: GoogleFonts.poppins()),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RiwayatTransaksiPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.person_2_outlined,  color: Color(0xFFEA5A05),),
              title: Text('Member', style: GoogleFonts.poppins()),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LihatMember()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Logout",
            style: GoogleFonts.poppins(),
          ),
          content:
              Text("Anda yakin ingin logout?", style: GoogleFonts.poppins()),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
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
                Navigator.pop(context);
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
