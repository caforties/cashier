import 'package:flutter/material.dart';
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
                width: 300,
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
                color: Color.fromARGB(255, 234, 90, 5),
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
              title: Text('Barang'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => KelolaBarang()),
                );
              },
            ),
            ListTile(
              title: Text('Petugas'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => KelolaPetugas()),
                );
              },
            ),
            ListTile(
              title: Text('Laporan Transaksi'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LaporanTransaksi()),
                );
              },
            ),
            ListTile(
              title: Text('Member'),
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
                Navigator.pop(context); // Close the dialog
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
