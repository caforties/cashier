import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kasir/admin/home/home.dart';
import 'package:kasir/admin/login/login.dart'; // Ganti dengan import halaman beranda yang sesuai

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            SizedBox(
              height: 10,
            ),
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
                      'Daftar',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 400,
                  height: 55,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: const Color.fromRGBO(255, 255, 255, 1),
                    border: Border.all(color: Colors.black45, width: 1.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0), // Menambahkan padding horizontal
                    child: TextField(
                      controller: _emailController,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'email',
                        hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
                        contentPadding: EdgeInsets.only(
                            left: 10), // Menyesuaikan padding kiri
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: 400,
                  height: 55,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Colors.white,
                    border: Border.all(color: Colors.grey, width: 1.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0), // Menambahkan padding horizontal
                    child: TextField(
                      controller: _passwordController,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'password',
                        hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
                        contentPadding: EdgeInsets.only(
                            left: 10), // Menyesuaikan padding kiri
                      ),
                      obscureText: true,
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  width: 400,
                  height: 55,
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 234, 90, 5),
                    ),
                    onPressed: () => _register(context),
                    child: Text(
                      'Daftar',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Login()),
                    );
                  },
                  child: RichText(
                    text: TextSpan(
                      text: 'Sudah Punya Akun? ',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Masuk',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color.fromARGB(255, 234, 90, 5),
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  // Fungsi untuk melakukan proses register
  void _register(BuildContext context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      // Jika registrasi berhasil, lanjutkan ke halaman beranda atau halaman lain yang diinginkan
      // Misalnya:
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home()), // Ganti 'Home()' dengan halaman tujuan setelah registrasi berhasil
      );
    } catch (e) {
      // Tangani kesalahan yang mungkin terjadi selama proses registrasi
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Registrasi gagal. Silakan coba lagi.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}
