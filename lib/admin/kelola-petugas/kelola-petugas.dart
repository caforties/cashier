import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kasir/admin/kelola-petugas/edit-petugas/edit-petugas.dart';
import 'package:kasir/admin/kelola-petugas/tambah-petugas/tambah-petugas.dart';

class KelolaPetugas extends StatelessWidget {
  const KelolaPetugas({Key? key}) : super(key: key);

  Future<void> _deleteDocument(String documentId) async {
    try {
      await FirebaseFirestore.instance
          .collection('petugas')
          .doc(documentId)
          .delete();
      print('Document deleted successfully!');
    } catch (e) {
      print('Error deleting document: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Petugas',
            style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("petugas")
            .orderBy("email", descending: true)
            .snapshots(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
                child: Text(
              'Error: ${snapshot.error}',
              style: GoogleFonts.poppins(),
            ));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
                child: Text(
              'Tidak Ada Data',
              style: GoogleFonts.poppins(),
            ));
          }

          List<DocumentSnapshot<Map<String, dynamic>>> data = snapshot
              .data!.docs
              .cast<DocumentSnapshot<Map<String, dynamic>>>();

          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              DocumentSnapshot<Map<String, dynamic>> docs = data[index];

              final email = docs["email"] ?? '';
              final password = docs["password"] ?? '';
              final nama_kasir = docs["nama_kasir"] ?? '';
              final nomor_kasir = docs["nomor_kasir"] ?? '';
              final documentId = docs.id;

              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        nama_kasir.toString(),
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        '$email\npass: $password',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => EditPetugas(
                                      document: docs, documentId: documentId)));
                        },
                        child: Icon(
                          Icons.edit_outlined,
                          color: Colors.black,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext dialogContext) {
                              return AlertDialog(
                                title: Text(
                                  'Konfirmasi',
                                  style: GoogleFonts.poppins(),
                                ),
                                content: Text(
                                  'Anda yakin ingin menghapus data?',
                                  style: GoogleFonts.poppins(),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(dialogContext).pop();
                                    },
                                    child: Text(
                                      'Batal',
                                      style: GoogleFonts.poppins(
                                        color: Color(0xFFEA5A05),
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      _deleteDocument(documentId);
                                      Navigator.of(dialogContext).pop();
                                    },
                                    child: Text(
                                      'Hapus',
                                      style: GoogleFonts.poppins(
                                        color: Color(0xFFEA5A05),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        icon: const Icon(
                          Icons.delete_outline,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => TambahPetugas(),
            ),
          );
        },
        backgroundColor: Color(0xFFEA5A05),
        shape: const CircleBorder(),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
