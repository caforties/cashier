import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

class EditBarang extends StatefulWidget {
  final DocumentSnapshot<Map<String, dynamic>> document;
  final String documentId;

  const EditBarang({
    Key? key,
    required this.document,
    required this.documentId,
  }) : super(key: key);

  @override
  _EditBarangState createState() => _EditBarangState();
}

class _EditBarangState extends State<EditBarang> {
  TextEditingController kode_barangController = TextEditingController();
  TextEditingController nama_barangController = TextEditingController();
  TextEditingController hargaController = TextEditingController();
  TextEditingController stokController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.document != null) {
      final data = widget.document.data();
      if (data != null) {
        kode_barangController.text = data['kode_barang'] ?? '';
        nama_barangController.text = data['nama_barang'] ?? '';
        hargaController.text = data['harga'] ?? '';
        stokController.text = data['stok'] ?? '';
      }
    }
  }

  @override
  void dispose() {
    kode_barangController.dispose();
    nama_barangController.dispose();
    hargaController.dispose();
    stokController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle poppinsTextStyle = GoogleFonts.poppins(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: Colors.grey,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Barang',
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
                Text('Kode Barang',
                    style: GoogleFonts.poppins(
                      color: Colors.grey,
                    )),
                const SizedBox(height: 7),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromRGBO(255, 255, 255, 1),
                    border: Border.all(color: Colors.grey, width: 1.0),
                  ),
                  child: TextField(
                    controller: kode_barangController,
                    style: GoogleFonts.poppins(color: Colors.black),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'masukkan kode barang',
                      hintStyle: GoogleFonts.poppins(),
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
            Text('Nama Barang',
                style: GoogleFonts.poppins(
                  color: Colors.grey,
                )),
            const SizedBox(height: 7),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color.fromRGBO(255, 255, 255, 1),
                border: Border.all(color: Colors.grey, width: 1.0),
              ),
              child: TextField(
                controller: nama_barangController,
                style: GoogleFonts.poppins(color: Colors.black),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'masukkan nama barang',
                  hintStyle: GoogleFonts.poppins(),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 17),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text('Harga',
                style: GoogleFonts.poppins(
                  color: Colors.grey,
                )),
            const SizedBox(height: 7),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color.fromRGBO(255, 255, 255, 1),
                border: Border.all(color: Colors.grey, width: 1.0),
              ),
              child: TextField(
                controller: hargaController,
                style: GoogleFonts.poppins(color: Colors.black),
                decoration: InputDecoration( 
                  border: InputBorder.none,
                  hintText: 'Rp. 0',
                  hintStyle: GoogleFonts.poppins(),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 17),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text('Stok', style: GoogleFonts.poppins(color: Colors.grey)),
            const SizedBox(height: 7),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color.fromRGBO(255, 255, 255, 1),
                border: Border.all(color: Colors.grey, width: 1.0),
              ),
              child: TextField(
                controller: stokController,
                style: GoogleFonts.poppins(color: Colors.black),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'masukkan jumlah stok',
                  hintStyle: GoogleFonts.poppins(),
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
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 234, 90, 5),
                ),
                onPressed: () {
                  updateBarangData();
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

  void updateBarangData() async {
    try {
      String kode_barang = kode_barangController.text;
      String nama_barang = nama_barangController.text;
      String harga = hargaController.text;
      String stok = stokController.text;

      await FirebaseFirestore.instance
          .collection('barang')
          .doc(widget.document.id)
          .update({
        'kode_barang': kode_barang,
        'nama_barang': nama_barang,
        'harga': harga,
        'stok': stok,
      });

      Navigator.pop(context);
    } catch (e) {
      print('Error updating data: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal memperbarui data. Silakan coba lagi.'),
        ),
      );
    }
  }
}
