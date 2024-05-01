import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kasir/admin/home/home.dart';
import 'package:kasir/admin/register/register.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kasir/petugas/home/petugas-home.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
 
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _signInWithEmailAndPassword(BuildContext context) async {
    try {
      final String email = _emailController.text.trim();
      final String password = _passwordController.text.trim();

      if (email.isNotEmpty && password.isNotEmpty) {
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        // Memeriksa apakah email pengguna adalah admin
        if (userCredential.user != null) {
          // Jika email admin, navigasikan ke halaman Home
          if (email == 'admin@gmail.com') {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => Home(),
              ),
            );
          } else {
            // Jika bukan email admin, navigasikan ke halaman HomePetugas
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => HomePetugas(),
              ),
            );
          }
        } else {
          // Jika userCredential.user null, tampilkan pesan kesalahan
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(
                  'Error',
                  style: GoogleFonts.poppins(),
                ),
                content: Text(
                  'Login Gagal. Cek kembali Email dan Password Anda.',
                  style: GoogleFonts.poppins(),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'OK',
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
      } else {
        // Jika email atau password kosong, tampilkan pesan kesalahan
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Error'),
              content: const Text('Please enter both email and password.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      // Jika terjadi kesalahan, tampilkan pesan kesalahan
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Login failed. Please check your credentials.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: ListView(
          children: [
            const SizedBox(height: 15),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 350,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                      color: Colors.white,
                      width: 1.0,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Masuk',
                      style: GoogleFonts.poppins(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 15),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: const Color.fromRGBO(255, 255, 255, 1),
                    border: Border.all(color: Colors.grey, width: 1.0),
                  ),
                  child: TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'email',
                      hintStyle: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 17),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 25),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: const Color.fromRGBO(255, 255, 255, 1),
                border: Border.all(color: Colors.grey, width: 1.0),
              ),
              child: TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'kata sandi',
                  hintStyle: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 17),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Container(
              width: double.infinity,
              height: 60,
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFEA5A05),
                ),
                onPressed: () {
                  _signInWithEmailAndPassword(context);
                },
                child: Text(
                  'Masuk',
                  style: GoogleFonts.poppins(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Belum Punya Akun?',
                  style: GoogleFonts.poppins(fontSize: 14, color: Colors.black),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Register(),
                      ),
                    );
                  },
                  child: Text(
                    'Daftar',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Color.fromARGB(255, 234, 90, 5),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
