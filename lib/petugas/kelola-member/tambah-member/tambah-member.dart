import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kasir/petugas/kelola-member/kelola-member.dart';

class TambahMember extends StatefulWidget {
  const TambahMember({Key? key}) : super(key: key);

  @override
  _TambahMemberState createState() => _TambahMemberState();
}

class _TambahMemberState extends State<TambahMember> {
  TextEditingController nama_memberController = TextEditingController();
  TextEditingController nomor_teleponController = TextEditingController();

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
          'Tambah Member',
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
                  'Nama member',
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
            InkWell(
              onTap: () {
                _addDataToFirestore();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => KelolaMember(),
                  ),
                );
              },
              child: Container(
                width: double.infinity,
                height: 50,
                margin: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 234, 90, 5),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Center(
                  child: Text(
                    'Simpan',
                    style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _addDataToFirestore() async {
    try {
      final maxIndex = await _getMaxIndex();

      final newIndex = maxIndex + 1;

      await FirebaseFirestore.instance.collection('member').add({
        'index': newIndex,
        'nama_member': nama_memberController.text,
        'nomor_telepon': nomor_teleponController.text,
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error adding data to Firestore: $e');
      }
    }
  }

  Future<int> _getMaxIndex() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('member')
        .orderBy('index', descending: true)
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      final maxIndex = querySnapshot.docs.first['index'] as int;
      return maxIndex;
    } else {
      return 0;
    }
  }
}
