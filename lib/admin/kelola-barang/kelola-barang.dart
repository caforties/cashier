import 'package:flutter/material.dart';
import 'package:kasir/admin/kelola-barang/edit-barang/edit-barang.dart';
import 'package:kasir/admin/kelola-barang/tambah-barang/tambah-barang.dart';

class KelolaBarang extends StatelessWidget {
  const KelolaBarang({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Barang',
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
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.edit_outlined,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditBarang()));
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    _showDeleteConfirmationDialog(context);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => TambahBarang()));
        },
        child: Icon(
          Icons.add,
          color: Colors.white, // Mengatur warna ikon menjadi putih
        ),
        backgroundColor: Color.fromARGB(255, 234, 90, 5),
        shape: CircleBorder(), // Membuat tombol menjadi berbentuk bulat
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Hapus Barang"),
          content: Text("Apakah Anda yakin ingin menghapus data?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Tindakan untuk menghapus barang
                Navigator.of(context).pop();
              },
              child: Text(
                "Ya",
                style: TextStyle(
                  color: Color.fromARGB(255, 234, 90, 5),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                "Tidak",
                style: TextStyle(
                  color: Color.fromARGB(255, 234, 90, 5),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
