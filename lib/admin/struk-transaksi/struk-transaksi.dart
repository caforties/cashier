import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:open_file/open_file.dart';

class TransactionDetailPage extends StatelessWidget {
  final Map<String, dynamic> transactionData;

  const TransactionDetailPage({Key? key, required this.transactionData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detail Transaksi',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: buildTransactionDetails(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: generatePdf,
        tooltip: 'Cetak Struk PDF',
        backgroundColor: Colors.white,
        child: Icon(
          Icons.download,
          color: Color(0xFFEA5A05),
        ),
      ),
    );
  }

  Widget buildTransactionDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tanggal Transaksi: ${transactionData['tanggal']}',
          style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        if (transactionData['is_non_member'] == false)
          Text(
            'Member: ${transactionData['member']}',
            style: GoogleFonts.poppins(fontSize: 16),
          ),
        SizedBox(height: 20),
        Divider(
          color: Colors.black,
          height: 20,
          thickness: 2,
        ),
        SizedBox(height: 10),
        Text(
          'Rincian Pesanan:',
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        ListView.builder(
          shrinkWrap: true,
          itemCount: transactionData['barang'].length,
          itemBuilder: (context, index) {
            final item = transactionData['barang'][index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${item['nama_barang']}',
                  style: GoogleFonts.poppins(fontSize: 16),
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Harga: Rp. ${item['harga']}',
                      style: GoogleFonts.poppins(),
                    ),
                    Text(
                      'Qty: ${item['jumlah']}',
                      style: GoogleFonts.poppins(),
                    ),
                  ],
                ),
                SizedBox(height: 10),
              ],
            );
          },
        ),
        Divider(
          color: Colors.black,
          height: 20,
          thickness: 2,
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total Harga',
              style: GoogleFonts.poppins(
                  fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              'Rp. ${transactionData['total_harga']}',
              style: GoogleFonts.poppins(fontSize: 16),
            )
          ],
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Diskon',
              style: GoogleFonts.poppins(
                  fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              'Rp. ${transactionData['diskon'] != null ? transactionData['diskon'] : 0}',
              style: GoogleFonts.poppins(fontSize: 16),
            )
          ],
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total Bayar',
              style: GoogleFonts.poppins(
                  fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              'Rp. ${transactionData['total_bayar']}',
              style: GoogleFonts.poppins(fontSize: 16),
            )
          ],
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Tunai',
              style: GoogleFonts.poppins(
                  fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              'Rp. ${transactionData['uang_tunai']}',
              style: GoogleFonts.poppins(fontSize: 16),
            )
          ],
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Kembalian',
              style: GoogleFonts.poppins(
                  fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              'Rp. ${transactionData['kembalian']}',
              style: GoogleFonts.poppins(fontSize: 16),
            )
          ],
        ),
      ],
    );
  }

  Future<void> generatePdf() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                'Struk Transaksi',
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.Text(
                'Tanggal Transaksi: ${transactionData['tanggal']}',
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              ),
              pw.SizedBox(height: 10),
              if (transactionData['is_non_member'] == false)
                pw.Text(
                  'Member: ${transactionData['member']}',
                ),
              pw.SizedBox(height: 20),
              pw.Divider(),
              pw.SizedBox(height: 10),
              pw.Text(
                'Rincian Pesanan:',
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              ),
              pw.SizedBox(height: 10),
              for (var item in transactionData['barang'])
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      '${item['nama_barang']}',
                    ),
                    pw.SizedBox(height: 5),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text(
                          'Harga: Rp. ${item['harga']}',
                        ),
                        pw.Text(
                          'Qty: ${item['jumlah']}',
                        ),
                      ],
                    ),
                    pw.SizedBox(height: 10),
                  ],
                ),
              pw.Divider(),
              pw.SizedBox(height: 10),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    'Total Harga',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                  ),
                  pw.Text(
                    'Rp. ${transactionData['total_harga']}',
                  )
                ],
              ),
              pw.SizedBox(height: 10),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    'Diskon',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                  ),
                  pw.Text(
                    'Rp. ${transactionData['diskon'] != null ? transactionData['diskon'] : 0}',
                  )
                ],
              ),
              pw.SizedBox(height: 10),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    'Total Bayar',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                  ),
                  pw.Text(
                    'Rp. ${transactionData['total_bayar']}',
                  )
                ],
              ),
              pw.SizedBox(height: 10),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    'Tunai',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                  ),
                  pw.Text(
                    'Rp. ${transactionData['uang_tunai']}',
                  )
                ],
              ),
              pw.SizedBox(height: 10),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    'Kembalian',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                  ),
                  pw.Text(
                    'Rp. ${transactionData['kembalian']}',
                  )
                ],
              ),
            ],
          );
        },
      ),
    );

    final output = await getTemporaryDirectory();
    final file = File('${output.path}/transaction_detail.pdf');
    await file.writeAsBytes(await pdf.save());

    // Open the PDF in default PDF viewer
    OpenFile.open(file.path);
  }
}
