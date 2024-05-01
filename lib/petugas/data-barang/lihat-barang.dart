import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

class LihatBarang extends StatelessWidget {
  const LihatBarang({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Data Barang',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('barang').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          final List<DocumentSnapshot> documents = snapshot.data!.docs;
          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (context, index) {
              final data = documents[index].data() as Map<String, dynamic>;
              final namaBarang = data['nama_barang'];
              final harga = data['harga'];
              final stok = data['stok'];
              return ListTile(
                title: Text(
                  namaBarang,
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold, fontSize: 14),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Rp $harga',
                      style: GoogleFonts.poppins(fontSize: 12),
                    ),
                    Text(
                      'Stok : $stok',
                      style:
                          GoogleFonts.poppins(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
              ); 
            },
          );
        },
      ),
    );
  }
}
