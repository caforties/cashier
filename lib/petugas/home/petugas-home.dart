import 'package:flutter/material.dart';
import 'package:kasir/admin/laporan-transaksi/laporan-transaksi.dart';
import 'package:kasir/admin/login/login.dart';
import 'package:kasir/petugas/data-barang/lihat-barang.dart';
import 'package:kasir/petugas/kelola-member/kelola-member.dart';
import 'package:kasir/petugas/transaksi/transaksi..dart';

class HomePetugas extends StatelessWidget {
  const HomePetugas({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Hapus tombol kembali
        title: Row(
          mainAxisAlignment:
              MainAxisAlignment.center, // Posisikan gambar di tengah
          children: [
            Expanded(
              child: Container(
                height: 100,
                width: 300,
                child: Image.asset(
                  'images/mycashier.jpg', // Ubah dengan path gambar logo Anda
                  fit: BoxFit
                      .contain, // Sesuaikan ukuran gambar agar sesuai dengan container
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                _showLogoutConfirmationDialog(context);
              },
              icon: Icon(
                Icons.logout,
                color: Color.fromARGB(255, 234, 90, 5),
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
              title: Text('Data Barang'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LihatBarang()));
              },
            ),
            ListTile(
              title: Text('Transaksi'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Transaksi()));
              },
            ),
            ListTile(
              title: Text('Laporan Transaksi'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LaporanTransaksi()));
              },
            ),
            ListTile(
              title: Text('Member'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => KelolaMember()));
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
          title: Text("Logout"),
          content: Text("Anda yakin ingin logout?"),
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
                style: TextStyle(
                  color: Color.fromARGB(255, 234, 90, 5),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePetugas()),
                );
              },
              child: Text(
                "Tidak",
                style: TextStyle(
                  color: Color.fromARGB(255, 234, 90, 5),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
