import 'package:flutter/material.dart';

class Transaksi extends StatefulWidget {
  @override
  _TransaksiState createState() => _TransaksiState();
}

class _TransaksiState extends State<Transaksi> {
  String _selectedItem = 'Barang 1'; // Barang default yang dipilih
  int _quantity = 1;

  // Daftar nama barang
  List<String> _barangList = ['Barang 1', 'Barang 2', 'Barang 3', 'Barang 4'];

  // List untuk menyimpan transaksi
  List<Map<String, dynamic>> _transaksiList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Transaksi',
          style: TextStyle(fontSize: 12),
        ),
      ),
      body: Column(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                DropdownButton<String>(
                  value: _selectedItem,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedItem = newValue!;
                    });
                  },
                  items: _barangList.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          if (_quantity > 1) {
                            _quantity--;
                          }
                        });
                      },
                      child: Icon(
                        Icons.remove_circle_outline,
                        color: Color.fromARGB(255, 234, 90, 5),
                      ),
                    ),
                    SizedBox(width: 10),
                    Text('$_quantity'),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _quantity++;
                        });
                      },
                      child: Icon(
                        Icons.add_circle_outline,
                        color: Color.fromARGB(255, 234, 90, 5), 
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Tambahkan transaksi ke list
                    _transaksiList.add({
                      'nama_barang': _selectedItem,
                      'jumlah': _quantity,
                    });
                    // Reset pilihan barang dan jumlah
                    _selectedItem = 'Barang 1';
                    _quantity = 1;
                    setState(() {});
                  },
                  child: Text(
                    'Tambah',
                    style: TextStyle(
                      color: Color.fromARGB(255, 234, 90, 5),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: DataTable(
                columns: [
                  DataColumn(label: Text('Nama Barang')),
                  DataColumn(label: Text('Jumlah')),
                  DataColumn(label: Text('Harga')),
                ],
                rows: _transaksiList.map((transaksi) {
                  return DataRow(
                    cells: [
                      DataCell(Text(transaksi['nama_barang'])),
                      DataCell(Text(transaksi['jumlah'].toString())),
                      DataCell(Text(transaksi['harga'].toString())),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
