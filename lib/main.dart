import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kasir/admin/home/home.dart';
import 'package:kasir/admin/kelola-barang/kelola-barang.dart';
import 'package:kasir/admin/kelola-petugas/kelola-petugas.dart';
import 'package:kasir/admin/lihat-member/lihat-member.dart';
import 'package:kasir/admin/login/login.dart';
import 'package:kasir/admin/register/register.dart';
import 'package:kasir/petugas/home/petugas-home.dart';
import 'package:kasir/petugas/kelola-member/kelola-member.dart';
import 'package:kasir/petugas/transaksi/transaksi..dart';
import 'package:kasir/splashscreen/splashscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mycashier',
      theme: ThemeData(fontFamily: 'poppins'),
      debugShowCheckedModeBanner: false,
      home: Login(),
    );
  }
}
