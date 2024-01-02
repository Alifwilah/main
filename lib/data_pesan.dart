import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:main/pemesanan.dart';

// Buat sebuah class untuk menampung data form
class FormData {
  String nama = '';
  String alamat = '';
  String nomorTelepon = '';
  String email = '';
}

// Modifikasi class FormScreen untuk menyimpan dan menampilkan data
class FormScreen extends StatefulWidget {
  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FormData formData = FormData(); // Objek untuk menyimpan data form

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Data'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Nama',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukkan nama';
                  }
                  return null;
                },
                onSaved: (value) {
                  formData.nama = value ?? '';
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Alamat',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukkan alamat';
                  }
                  return null;
                },
                onSaved: (value) {
                  formData.alamat = value ?? '';
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Nomor Telepon',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  LengthLimitingTextInputFormatter(12)
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukkan nomor telepon';
                  }else if (value.length < 10 || value.length > 12) {
                    return 'Nomor telepon harus antara 10 dan 12 digit';
                  }
                  return null;
                },
                onSaved: (value) {
                  formData.nomorTelepon = value ?? '';
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty || !value.contains('@')) {
                    return 'Masukkan email yang valid';
                  }
                  return null;
                },
                onSaved: (value) {
                  formData.email = value ?? '';
                },
              ),
              
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save(); // Simpan data saat form valid
                    Navigator.push(context, 
                    MaterialPageRoute(builder: (context) => DataPesan(formData: formData)));
                    // Lakukan sesuatu dengan data yang disimpan, misalnya tampilkan dalam snackbar
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Data disimpan: ${formData.nama}, ${formData.alamat}, ${formData.nomorTelepon}, ${formData.email}'),
                      ),
                    );
                  }
                },
                child: Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
