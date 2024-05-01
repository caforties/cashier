import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kasir/petugas/home/petugas-home.dart';

class LoginPetugas extends StatefulWidget {
  const LoginPetugas({Key? key}) : super(key: key);

  @override
  _LoginPetugasState createState() => _LoginPetugasState();
}

class _LoginPetugasState extends State<LoginPetugas> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _signInWithEmailAndPassword(BuildContext context) async {
    try {
      final String email = _emailController.text.trim();
      final String password = _passwordController.text.trim();

      if (email.isNotEmpty && password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => HomePetugas(),
          ),
        );
      } else {
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
    return DefaultTextStyle(
      style: TextStyle(
        fontFamily: 'Poppins',
      ),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(30),
          child: ListView(
            children: [
              const SizedBox(
                height: 75,
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
                        'Masuk',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 35),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    'Email',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromRGBO(255, 255, 255, 1),
                      border: Border.all(color: Colors.black45, width: 1.0),
                    ),
                    child: TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'masukkan email',
                        hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 17),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 25),
              const Text(
                'Password',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromRGBO(255, 255, 255, 1),
                  border: Border.all(color: Colors.black45, width: 1.0),
                ),
                child: TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'masukkan password',
                    hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 17),
                  ),
                ),
              ),
              const SizedBox(height: 45),
              Container(
                width: double.infinity,
                height: 50,
                margin: const EdgeInsets.symmetric(horizontal: 15),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 234, 90, 5),
                  ),
                  onPressed: () {
                    _signInWithEmailAndPassword(context);
                  },
                  child: const Text(
                    'masuk',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
