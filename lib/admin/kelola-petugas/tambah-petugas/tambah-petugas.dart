import 'package:flutter/material.dart';
import 'package:kasir/admin/kelola-petugas/kelola-petugas.dart';

class TambahPetugas extends StatelessWidget {
  const TambahPetugas({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Petugas'),
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
                  'Nomor Petugas',
                  style: TextStyle(
                    // Apply Poppins font here
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
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'masukkan nomor petugas',
                      hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
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
              'Nama Petugas',
              style: TextStyle(
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
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'masukkan nama petugas',
                  hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 17),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Email',
              style: TextStyle(
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
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'masukkan email',
                  hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 17),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Password',
              style: TextStyle(
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
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'masukkan password',
                  hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
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
              child: FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 234, 90, 5),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => KelolaPetugas()),
                  );
                },
                child: Text(
                  'Simpan',
                  style: TextStyle(
                  
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
}
