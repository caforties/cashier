import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kasir/admin/home/home.dart';
import 'package:kasir/admin/register/register.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _signInWithEmailAndPassword(BuildContext context) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      // Jika login berhasil, lanjutkan ke halaman beranda
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    } catch (e) {
      // Tangani kesalahan yang mungkin terjadi selama proses login
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Login gagal. Silakan coba lagi.'),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            SizedBox(height: 10),
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
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: 400,
                  height: 55,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: const Color.fromRGBO(255, 255, 255, 1),
                    border: Border.all(color: Colors.black45, width: 1.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextField(
                      controller: _emailController,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'masukkan email',
                        hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
                        contentPadding: EdgeInsets.only(left: 10),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: 400,
                  height: 55,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Colors.white,
                    border: Border.all(color: Colors.grey, width: 1.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                        contentPadding: EdgeInsets.only(left: 10),
                      ),
                      obscureText: true,
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Container(
                  width: 400,
                  height: 50,
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 234, 90, 5),
                    ),
                    onPressed: () => _signInWithEmailAndPassword(context),
                    child: Text(
                      'masuk',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Register()),
                    );
                  },
                  child: RichText(
                    text: TextSpan(
                      text: 'Belum punya akun? ',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Daftar',
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
            ),
          ],
        ),
      ),
    );
  }
}
