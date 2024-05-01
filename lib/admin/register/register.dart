import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kasir/admin/login/login.dart';
import 'package:google_fonts/google_fonts.dart'; // Import Google Fonts

class Register extends StatelessWidget {
  const Register({Key? key}) : super(key: key);

  Future<void> _signUp(String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print('User registered: ${userCredential.user!.uid}');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    String _email = '';
    String _password = '';

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: ListView(
          children: [
            const SizedBox(height: 15),
            Center(
              child: Text(
                'Daftar',
                style: GoogleFonts.poppins(
                  // Menggunakan Poppins sebagai gaya teks
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 40),
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
                    onChanged: (value) {
                      _email = value;
                    },
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
                    onChanged: (value) {
                      _password = value;
                    },
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
                      _signUp(_email, _password);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Login(),
                        ),
                      );
                    },
                    child: Text(
                      'Daftar',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Sudah Punya Akun?',
                      style: GoogleFonts.poppins(
                          fontSize: 14, color: Colors.black),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Login(),
                          ),
                        );
                      },
                      child: Text(
                        'Masuk',
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
          ],
        ),
      ),
    );
  }
}
