import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kasir/admin/struk-transaksi/struk-transaksi.dart';

class RiwayatTransaksiPage extends StatefulWidget {
  @override
  _RiwayatTransaksiPageState createState() => _RiwayatTransaksiPageState();
}

class _RiwayatTransaksiPageState extends State<RiwayatTransaksiPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Riwayat Transaksi',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        // Adjusted the generic type of FutureBuilder
        future: _fetchTransaksi(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!
                  .length, // Added null check operator (!) for snapshot.data
              itemBuilder: (context, index) {
                var transaksi = snapshot.data![
                    index]; // Added null check operator (!) for snapshot.data
                return ListTile(
                  title: Text(
                    'Rp. ${transaksi['total_bayar']}',
                    style: GoogleFonts.poppins(),
                  ),
                  subtitle: Text(
                    '${transaksi['tanggal']}',
                    style: GoogleFonts.poppins(color: Colors.grey),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TransactionDetailPage(
                          transactionData: transaksi,
                        ),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }

  Future<List<Map<String, dynamic>>> _fetchTransaksi() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('transaksi')
          .orderBy('tanggal', descending: true)
          .get();
      List<Map<String, dynamic>> transaksiList = [];
      querySnapshot.docs.forEach((doc) {
        transaksiList.add(doc.data() as Map<String, dynamic>);
      });
      return transaksiList;
    } catch (e) {
      print('Error fetching transaksi: $e');
      return [];
    }
  }
}
