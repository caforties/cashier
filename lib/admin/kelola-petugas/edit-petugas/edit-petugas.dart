import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

class EditPetugas extends StatefulWidget {
  final DocumentSnapshot<Map<String, dynamic>> document;
  final String documentId;

  const EditPetugas(
      {Key? key, required this.document, required this.documentId})
      : super(key: key);

  @override
  _EditPetugasState createState() => _EditPetugasState();
}

class _EditPetugasState extends State<EditPetugas> {
  TextEditingController nomor_kasirController = TextEditingController();
  TextEditingController nama_kasirController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.document != null) {
      final data = widget.document.data();
      if (data != null) {
        nomor_kasirController.text = data['nomor_kasir'] ?? '';
        nama_kasirController.text = data['nama_kasir'] ?? '';
        emailController.text = data['email'] ?? '';
        passwordController.text = data['password'] ?? '';
      }
    }
  }

  @override
  void dispose() {
    nomor_kasirController.dispose();
    nama_kasirController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Petugas',
            style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Nomor Petugas',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 7),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromRGBO(255, 255, 255, 1),
                    border: Border.all(color: Colors.grey, width: 1.0),
                  ),
                  child: TextField(
                    controller: nomor_kasirController,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'masukkan nomor petugas',
                      hintStyle:
                          GoogleFonts.poppins(fontSize: 14, color: Colors.grey),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 17),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Nama Petugas',
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 7),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color.fromRGBO(255, 255, 255, 1),
                border: Border.all(color: Colors.grey, width: 1.0),
              ),
              child: TextField(
                controller: nama_kasirController,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'masukkan nama petugas',
                  hintStyle:
                      GoogleFonts.poppins(fontSize: 14, color: Colors.grey),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 17),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Email',
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 7),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color.fromRGBO(255, 255, 255, 1),
                border: Border.all(color: Colors.grey, width: 1.0),
              ),
              child: TextField(
                controller: emailController,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'masukkan email',
                  hintStyle:
                      GoogleFonts.poppins(fontSize: 14, color: Colors.grey),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 17),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Password',
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 7),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color.fromRGBO(255, 255, 255, 1),
                border: Border.all(color: Colors.grey, width: 1.0),
              ),
              child: TextField(
                controller: passwordController,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'masukkan password',
                  hintStyle:
                      GoogleFonts.poppins(fontSize: 14, color: Colors.grey),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 17),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 400,
              height: 55,
              margin: EdgeInsets.symmetric(horizontal: 15),
              child: FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: Color(0xFFEA5A05),
                ),
                onPressed: () {
                  updatePetugasData();
                },
                child: Text(
                  'Simpan',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void updatePetugasData() async {
    try {
      String nomorKasir = nomor_kasirController.text;
      String nama_kasir = nama_kasirController.text;
      String email = emailController.text;
      String password = passwordController.text;

      await FirebaseFirestore.instance
          .collection('petugas')
          .doc(widget.document.id)
          .update({
        'nomor_kasir': nomorKasir,
        'nama_kasir': nama_kasir,
        'email': email,
        'password': password,
      });

      Navigator.pop(context);
    } catch (e) {
      print('Error updating data: $e');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to update data. Please try again.'),
        ),
      );
    }
  }
}
