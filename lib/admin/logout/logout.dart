import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LogoutPage extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _signOut(BuildContext context) async {
    await _auth.signOut();
    Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Logout'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _signOut(context),
          child: Text('Logout'),
        ),
      ),
    );
  }
}
