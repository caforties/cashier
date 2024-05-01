import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

class LihatMember extends StatelessWidget {
  const LihatMember({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Member',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('member').snapshots(),
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
              final nama_member = data['nama_member'];
              final nomor_telepon = data['nomor_telepon'];

              return ListTile(
                title: Text(
                  nama_member,
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold, fontSize: 14),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('$nomor_telepon',
                        style: GoogleFonts.poppins(fontSize: 12)),
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
