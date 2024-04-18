import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:kasir/splashscreen/splashscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Inisialisasi Firebase sebelum membangun aplikasi
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          // Tampilkan SplashScreen jika inisialisasi Firebase berhasil
          home: snapshot.connectionState == ConnectionState.done
              ? SplashScreen()
              // Tampilkan loading indicator jika Firebase masih inisialisasi
              : Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
        );
      },
    );
  }
}
