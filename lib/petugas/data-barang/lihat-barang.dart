import 'package:flutter/material.dart';

class LihatBarang extends StatelessWidget {
  const LihatBarang({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Data Barang',
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Chitato Beef BBQ 75g'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Harga : Rp7000'),
                Text('Stok : 7'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
