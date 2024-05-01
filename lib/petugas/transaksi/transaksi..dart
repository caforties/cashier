import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart'; // For date formatting

class Transaksi extends StatefulWidget {
  @override
  _TransaksiState createState() => _TransaksiState();
}

class _TransaksiState extends State<Transaksi> {
  String _selectedItem = ''; // Barang default yang dipilih
  int _quantity = 1;
  List<Map<String, dynamic>> _barangList =
      []; // Daftar nama barang dan harganya
  List<Map<String, dynamic>> _transaksiList =
      []; // List untuk menyimpan transaksi
  String _selectedMember = ''; // Member default yang dipilih
  List<String> _memberList = []; // Daftar nama member
  int _hitungTotalHarga() {
    int totalHarga = 0;
    for (var transaksi in _transaksiList) {
      totalHarga += ((int.parse(transaksi['harga'].toString()) ?? 0) *
              (transaksi['jumlah'] ?? 0))
          .toInt();
    }
    return totalHarga;
  }

  bool _isNonMemberSelected = false;

  @override
  void initState() {
    super.initState();
    _fetchBarangList();
    _fetchMemberList();
  }

  Future<void> _fetchBarangList() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('barang').get();
      List<Map<String, dynamic>> barangList = [];
      querySnapshot.docs.forEach((doc) {
        barangList.add({
          'nama_barang': doc['nama_barang'].toString(),
          'harga': doc['harga'] ?? 0,
        });
      });
      setState(() {
        _barangList = barangList;
        _selectedItem =
            barangList.isNotEmpty ? barangList[0]['nama_barang'] : '';
      });
    } catch (e) {
      print('Error fetching barang: $e');
    }
  }

  Future<void> _fetchMemberList() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('member').get();
      List<String> memberList = [];
      querySnapshot.docs.forEach((doc) {
        memberList.add(doc['nama_member'].toString());
      });
      setState(() {
        _memberList = memberList;
        _selectedMember = memberList.isNotEmpty ? memberList[0] : '';
      });
    } catch (e) {
      print('Error fetching member: $e');
    }
  }

  Future<void> _hitungKembalian() async {
    int totalBayar = await _hitungTotalBayar(); // Calculate total payment

    // Parse the cash amount provided by the user
    int uangTunai = int.tryParse(_uangTunaiController.text) ?? 0;

    // Calculate change by subtracting total payment from cash amount
    int kembalian = uangTunai - totalBayar;

    // Update the change text field with the calculated change
    _kembalianController.text = kembalian.toString();
  }

  TextEditingController _uangTunaiController = TextEditingController();
  TextEditingController _kembalianController = TextEditingController();

  Future<int> _hitungTotalBayar() async {
    int totalHarga = _hitungTotalHarga(); // Hitung total harga barang

    // Periksa apakah pengguna adalah non-member
    if (_isNonMemberSelected) {
      return totalHarga; // Jika non-member, kembalikan total harga tanpa diskon
    }

    // Dapatkan diskon dari member jika ada
    int diskon = 0;
    if (_selectedMember.isNotEmpty) {
      diskon = await _fetchDiskonMember(_selectedMember);
    }

    // Periksa apakah total harga memenuhi syarat kelipatan diskon
    if (totalHarga >= 100000) {
      int jumlahKelipatan = totalHarga ~/ 100000; // Hitung jumlah kelipatan
      int diskonKelipatan =
          jumlahKelipatan * 5000; // Hitung jumlah diskon kelipatan
      diskon += diskonKelipatan; // Tambahkan diskon kelipatan ke total diskon
    }

    // Kurangkan diskon dari total harga
    int totalBayar = totalHarga - diskon;

    return totalBayar;
  }

  Future<void> _simpanTransaksi() async {
    try {
      // Mendapatkan tanggal saat ini
      DateTime now = DateTime.now();
      String formattedDate = DateFormat('yyyy-MM-dd - kk:mm:ss').format(now);

      // Hitung total harga
      int totalHarga = _hitungTotalHarga();
// Dapatkan diskon dari member jika ada
      int diskon = 0;
      if (_selectedMember.isNotEmpty) {
        diskon = await _fetchDiskonMember(_selectedMember);
      }
      // Hitung total bayar
      int totalBayar = totalHarga - diskon;

      // Ambil nilai uang tunai dari controller
      int uangTunai = int.tryParse(_uangTunaiController.text) ?? 0;

      // Hitung kembalian
      int kembalian = uangTunai - totalBayar;

      // Simpan transaksi
      await FirebaseFirestore.instance.collection('transaksi').add({
        'tanggal': formattedDate,
        'barang': _transaksiList,
        'member': _selectedMember,
        'is_non_member': _isNonMemberSelected,
        'total_harga': totalHarga,
        // Tampilkan diskon hanya jika diskon tersedia
        if (diskon > 0) 'diskon': diskon,
        'total_bayar': totalBayar,
        'uang_tunai': uangTunai,
        'kembalian': kembalian,
      });

      // Mengurangi stok barang setelah transaksi disimpan
      await _kurangiStokBarang();

      // Reset state dan controllers setelah transaksi disimpan
      setState(() {
        _transaksiList.clear();
        _selectedItem = '';
        _quantity = 1;
        _selectedMember = _memberList.isNotEmpty ? _memberList[0] : '';
        _isNonMemberSelected = false;
        _uangTunaiController.clear();
        _kembalianController.clear();
      });
    } catch (e) {
      print('Error saving transaction: $e');
    }
  }

  Future<void> _kurangiStokBarang() async {
    for (var transaksi in _transaksiList) {
      try {
        // Ambil jumlah stok barang dari Firebase
        DocumentSnapshot snapshot = await FirebaseFirestore.instance
            .collection('barang')
            .doc(transaksi['nama_barang'])
            .get();

        // Kurangi jumlah stok dengan jumlah barang yang dibeli
        int updatedStock = snapshot['stok'] - (transaksi['jumlah'] ?? 0);

        // Pastikan stok tidak kurang dari 0
        updatedStock = updatedStock < 0 ? 0 : updatedStock;

        // Update jumlah stok di Firebase
        await FirebaseFirestore.instance
            .collection('barang')
            .doc(transaksi['nama_barang'])
            .update({'stok': updatedStock});
      } catch (e) {
        print('Error updating stock: $e');
      }
    }
  }

  Future<int> _fetchHargaBarang(String namaBarang) async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('barang')
          .doc(namaBarang)
          .get();
      if (snapshot.exists) {
        return snapshot['harga'] ?? 0;
      } else {
        return 0;
      }
    } catch (e) {
      print('Error fetching harga barang: $e');
      return 0;
    }
  }

  Future<int> _fetchDiskonMember(String member) async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('member')
          .doc(member)
          .get();
      if (snapshot.exists) {
        return snapshot['diskon'] ?? 0;
      } else {
        return 0;
      }
    } catch (e) {
      print('Error fetching diskon member: $e');
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Transaksi',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField<Map<String, dynamic>>(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Color(0xFFE87320)),
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                hintText: 'Pilih Barang',
                hintStyle: GoogleFonts.poppins(color: Colors.grey),
              ),
              style: GoogleFonts.poppins(color: Colors.black),
              value: _barangList.isNotEmpty ? _barangList[0] : null,
              onChanged: (newValue) {
                setState(() {
                  _selectedItem = newValue!['nama_barang'];
                });
              },
              items: _barangList.map((value) {
                return DropdownMenuItem<Map<String, dynamic>>(
                  value: value,
                  child:
                      Text('${value['nama_barang']} - Rp. ${value['harga']}'),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Jumlah:',
                  style: GoogleFonts.poppins(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Row(
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
                        Icons.remove_circle_outline_outlined,
                        color: Color(0xFFEA5A05),
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
                        Icons.add_circle_outline_outlined,
                        color: Color(0xFFEA5A05),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: () async {
                Map<String, dynamic> barang = _barangList.firstWhere(
                    (element) => element['nama_barang'] == _selectedItem,
                    orElse: () => {'nama_barang': '', 'harga': 0});
                _transaksiList.add({
                  'nama_barang': barang['nama_barang'],
                  'jumlah': _quantity,
                  'harga': barang['harga'],
                });
                setState(() {});
              },
              style: TextButton.styleFrom(
                backgroundColor: Color(0xFFEA5A05),
                minimumSize: Size(500, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: Text(
                'Tambah',
                style: GoogleFonts.poppins(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Text(
              'Rincian Pesanan',
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 20),
            Divider(),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: _transaksiList.length,
                      itemBuilder: (BuildContext context, int index) {
                        var transaksi = _transaksiList[index];
                        return ListTile(
                          title: Text(transaksi['nama_barang']),
                          subtitle: Text('Jumlah: ${transaksi['jumlah']}'),
                          trailing: Text('Rp. ${transaksi['harga'] ?? ''}'),
                        );
                      },
                    ),
                    Divider(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total Harga: Rp. ${_hitungTotalHarga()}',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Diskon:',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            FutureBuilder<int>(
                              future: _hitungTotalBayar(),
                              builder: (context, snapshot) {
                                if (_isNonMemberSelected) {
                                  // Jika pengguna memilih Non-Member, tampilkan teks kosong sebagai gantinya
                                  return Text(
                                    'Rp. 0',
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  );
                                } else if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  // Tampilkan widget loading jika masih dalam proses perhitungan
                                  return CircularProgressIndicator();
                                } else if (snapshot.hasError) {
                                  // Tampilkan pesan error jika terjadi kesalahan
                                  return Text('Error: ${snapshot.error}');
                                } else {
                                  // Hitung jumlah diskon
                                  int diskon =
                                      _hitungTotalHarga() - snapshot.data!;
                                  // Tampilkan jumlah diskon jika perhitungan berhasil
                                  return Text(
                                    'Rp. $diskon',
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            FutureBuilder<int>(
                              future: _hitungTotalBayar(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  // Tampilkan widget loading jika masih dalam proses perhitungan
                                  return CircularProgressIndicator();
                                } else if (snapshot.hasError) {
                                  // Tampilkan pesan error jika terjadi kesalahan
                                  return Text('Error: ${snapshot.error}');
                                } else {
                                  // Tampilkan total bayar jika perhitungan berhasil
                                  return Text(
                                    'Total Bayar: Rp. ${snapshot.data}',
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                child: OutlinedButton(
                                  onPressed: () {
                                    setState(() {
                                      _isNonMemberSelected = false;
                                    });
                                  },
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      value: _selectedMember,
                                      onChanged: (newValue) {
                                        setState(() {
                                          _selectedMember = newValue!;
                                          _isNonMemberSelected = false;
                                        });
                                      },
                                      items: _memberList.map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                              height: 20,
                            ),
                            Expanded(
                              child: Container(
                                child: OutlinedButton(
                                  onPressed: () {
                                    setState(() {
                                      _isNonMemberSelected = true;
                                    });
                                  },
                                  child: Text(
                                    'Non-Member',
                                    style: GoogleFonts.poppins(
                                        color: Colors.black),
                                  ),
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                    ),
                                    minimumSize:
                                        MaterialStateProperty.all<Size>(
                                      Size(double.infinity, 55),
                                    ),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                      _isNonMemberSelected
                                          ? Color(0xFFEA5A05)
                                          : Colors.transparent,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(right: 10.0),
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  controller: _uangTunaiController,
                                  onChanged: (value) {
                                    if (value.isEmpty) {
                                      _kembalianController.text =
                                          '0'; // Menampilkan angka 0 jika uang tunai kosong
                                    } else {
                                      _hitungKembalian(); // Calculate change when cash input changes
                                    }
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'Uang Tunai',
                                    hintStyle: GoogleFonts.poppins(),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(left: 10.0),
                                child: TextField(
                                  controller: _kembalianController,
                                  readOnly:
                                      true, // Membuat TextField hanya bisa dibaca
                                  decoration: InputDecoration(
                                    labelText: 'Kembalian',
                                    hintStyle: GoogleFonts.poppins(),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: _simpanTransaksi,
              style: TextButton.styleFrom(
                backgroundColor: Color(0xFFEA5A05),
                minimumSize: Size(500, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: Text(
                'Simpan',
                style: GoogleFonts.poppins(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
