import 'package:flutter/material.dart';

class LaporanTransaksi extends StatelessWidget {
  const LaporanTransaksi({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Laporan Transaksi',
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text(
              'Kasir 1',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('07 Maret 2023 14:14:09'),
              ],
            ),
            trailing: Text(
              'Rp 25.000',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}
