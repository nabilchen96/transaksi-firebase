// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, avoid_print, library_private_types_in_public_api, use_key_in_widget_constructors, unused_field, unused_import, prefer_final_fields, non_constant_identifier_names

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_new_app_3/controller/barang_controller.dart';
import 'package:flutter_new_app_3/controller/transaksi_masuk_controller.dart';
import 'package:flutter_new_app_3/model/barang_model.dart';
import 'package:flutter_new_app_3/view/barang_list_page.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:intl/intl.dart';

import '../model/transaksi_masuk_model.dart';

class AddTransaksiMasukPage extends StatefulWidget {
  @override
  _AddTransaksiMasukPageState createState() => _AddTransaksiMasukPageState();
}

class _AddTransaksiMasukPageState extends State<AddTransaksiMasukPage> {
  //inisialisasi variabel

  final TransaksiMasukController transaksiMasukController = TransaksiMasukController();

  //khusus untuk date
  TextEditingController _dateController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  bool _isUploading = false;

  //variabel form
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _kode_barang;
  String? _no_faktur;
  String? _nama;
  int? _quantity;
  int? _harga;
  int? _total;
  DateTime? _tgl_masuk;
  String? _kemasan;
  String? _keterangan;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate, // Initial date when the date picker is shown
      firstDate: DateTime(2000), // Earliest selectable date
      lastDate: DateTime(2101), // Latest selectable date
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = DateFormat('dd-MM-yyyy').format(_selectedDate);
      });
    }
  }

  Future<void> _sendTransaksi() async {
    try {
      setState(() {
        _isUploading = true;
      });

      DateTime tglMasuk = DateFormat('dd-MM-yyyy').parse(_dateController.text);

      print(
        // _no_faktur, 
        // _kode_barang, 
        // tglMasuk,  
        // _quantity, 
        // _harga, 
        // _kemasan, 
        _total,
      );

      // Simpan data barang dengan URL gambar ke Firestore
      // TransaksiMasukModel newTransaksi = TransaksiMasukModel(
      //   no_faktur: _no_faktur!, 
      //   kode_barang: _kode_barang!, 
      //   tgl_masuk: tglMasuk, 
      //   quantity: _quantity!, 
      //   harga: _harga!,
      //   kemasan: _kemasan!, 
      //   total: _total!,
      // );

      // await transaksiMasukController.addTransaksiMasuk(newTransaksi);

      // setState(() {
      //   _isUploading = false;
      // });

      // Navigator.pop(context);
    } catch (e) {
      print('Error: $e');
      // Tambahkan handling error sesuai kebutuhan

      setState(() {
        _isUploading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Transaksi Baru'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // ... Form fields lainnya
              TextFormField(
                decoration: InputDecoration(labelText: 'Kode Barang'),
                onChanged: (value) => _kode_barang = value,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Kode Barang harus diisi';
                  }
                  return null;
                },
              ),

              TextFormField(
                decoration: InputDecoration(labelText: 'No Faktur'),
                onChanged: (value) => _no_faktur = value,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Kode Barang harus diisi';
                  }
                  return null;
                },
                
              ),

              GestureDetector(
                onTap: () => _selectDate(context),
                child: AbsorbPointer(
                  child: TextFormField(
                    controller: _dateController,
                    readOnly: true, // to prevent manual editing of the date
                    decoration: InputDecoration(
                      labelText: 'Selected Date',
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: 16,
              ),

              

              

              TextFormField(
                decoration: InputDecoration(labelText: 'Quantity'),
                keyboardType: TextInputType.number,
                onChanged: (value) => _quantity = int.parse(value),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Stok harus diisi';
                  }
                  return null;
                },
              ),

              TextFormField(
                decoration: InputDecoration(labelText: 'Harga'),
                keyboardType: TextInputType.number,
                onChanged: (value) => _harga = int.parse(value),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Harga harus diisi';
                  }
                  return null;
                },
              ),

              TextFormField(
                decoration: InputDecoration(labelText: 'Kemasan'),
                onChanged: (value) => _kemasan = value,
              ),

              SizedBox(height: 16),

              TextFormField(
                decoration: InputDecoration(labelText: 'Total'),
                keyboardType: TextInputType.number,
                onChanged: (value) => _total = int.parse(value),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Total harus diisi';
                  }
                  return null;
                },
              ),

              SizedBox(height: 16),

              ElevatedButton(
                onPressed: _isUploading
                    ? null // Jika proses upload sedang berjalan, nonaktifkan tombol Simpan
                    : () {
                        _sendTransaksi();
                      },
                child: _isUploading
                    ? CircularProgressIndicator() // Tampilkan CircularProgressIndicator saat proses upload berjalan
                    : Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
