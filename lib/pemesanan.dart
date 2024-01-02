import 'dart:math';

import 'package:flutter/material.dart';
import 'package:main/data_pesan.dart';

class DataPesan extends StatefulWidget {
  final FormData formData;
  final String invoiceNumber;

  DataPesan({required this.formData}) : invoiceNumber = generateInvoiceNumber();

  static String generateInvoiceNumber() {
    final Random _random = Random();
    const String chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    const int length = 12;

    return List.generate(length, (index) => chars[_random.nextInt(chars.length)]).join();
  }

  @override
  _DataPesanState createState() => _DataPesanState();
}
List<String> dataLabels = [
  'Nama',
  'Alamat',
  'Nomor Telepon',
  'Email',
  'Invoice Number',
];
class _DataPesanState extends State<DataPesan> {
  bool isPaid = false;
  late List<String> dataValues;

  @override
  void initState() {
    super.initState();
    dataValues = [
      widget.formData.nama,
      widget.formData.alamat,
      widget.formData.nomorTelepon,
      widget.formData.email,
      widget.invoiceNumber,
    ];
  }

  void _showConfirmationDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Hapus ${dataLabels[index]}'),
          content: Text('Apakah Anda yakin ingin menghapus ${dataLabels[index]}?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  dataValues[index] = ''; // Hapus data pada indeks tertentu
                });
                Navigator.of(context).pop();
                _showDataDeletedDialog();
                // Tambahkan logika penghapusan dari penyimpanan lokal jika diperlukan
              },
              child: Text('Hapus'),
            ),
          ],
        );
      },
    );
  }
  void _showDataDeletedDialog() {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Data Telah Dihapus'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Pesan'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Nama: ${widget.formData.nama}'),
            Text('Alamat: ${widget.formData.alamat}'),
            Text('Nomor Telepon: ${widget.formData.nomorTelepon}'),
            Text('Email: ${widget.formData.email}'),
            Text('Invoice Number: ${widget.invoiceNumber}'),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  isPaid = !isPaid; // Toggle status paid/unpaid
                });
              },
              style: ElevatedButton.styleFrom(
                primary: isPaid ? Colors.green : Colors.red, // Ganti warna berdasarkan status isPaid
              ),
              child: Text(isPaid ? 'Paid' : 'Unpaid'),
            ),
            ElevatedButton(
              onPressed: () {
                _showConfirmationDialog(dataLabels.length - 1);
                
              },
              child: Text('Hapus History'),
            ),
          ],
        ),
      ),
    );
  }
}
