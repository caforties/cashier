import 'package:flutter/material.dart';
import 'package:kasir/petugas/kelola-member/edit-member/edit-member.dart';
import 'package:kasir/petugas/kelola-member/tambah-member/tambah-member.dart';

class KelolaMember extends StatelessWidget {
  const KelolaMember({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Member',
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Member 1'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('0897865643254'),
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => EditMember()));
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
              context, MaterialPageRoute(builder: (context) => TambahMember()));
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
          title: Text("Hapus Member"),
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
