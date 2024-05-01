import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

class EditMember extends StatefulWidget {
  final DocumentSnapshot<Map<String, dynamic>> document;
  final String documentId;

  const EditMember({Key? key, required this.document, required this.documentId})
      : super(key: key);

  @override
  _EditMemberState createState() => _EditMemberState();
}

class _EditMemberState extends State<EditMember> {
  TextEditingController nama_memberController = TextEditingController();
  TextEditingController nomor_teleponController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.document != null) {
      final data = widget.document.data();
      if (data != null) {
        nama_memberController.text = data['nama_member'] ?? '';
        nomor_teleponController.text = data['nomor_telepon'] ?? '';
      }
    }
  }

  @override
  void dispose() {
    nama_memberController.dispose();
    nomor_teleponController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Member',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
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
                  'Nama Member',
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
                    controller: nama_memberController,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'masukkan nama member',
                      hintStyle: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.black,
                      ),
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
              'Nomor Telepon',
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
                controller: nomor_teleponController,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'masukkan nomor telepon',
                  hintStyle: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
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
                  backgroundColor: Color.fromARGB(255, 234, 90, 5),
                ),
                onPressed: () {
                  updateMemberData();
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

  void updateMemberData() async {
    try {
      String nama_member = nama_memberController.text;
      String nomor_telepon = nomor_teleponController.text;

      await FirebaseFirestore.instance
          .collection('member')
          .doc(widget.document.id)
          .update({
        'nama_member': nama_member,
        'nomor_telepon': nomor_telepon,
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
