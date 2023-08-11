// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, avoid_print, library_private_types_in_public_api, use_key_in_widget_constructors, unused_field, unused_import, prefer_final_fields, prefer_const_constructors_in_immutables

import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_new_app_3/controller/barang_controller.dart';
import 'package:flutter_new_app_3/model/barang_model.dart';
import 'package:flutter_new_app_3/view/barang_list_page.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class EditBarangPage extends StatefulWidget {
  final String id;
  final String kode;
  final String nama;
  final int stok;
  final int harga;
  final String keterangan;
  final String gambar;

  EditBarangPage(
      {required this.id,
      required this.kode,
      required this.nama,
      required this.stok,
      required this.harga,
      required this.keterangan,
      required this.gambar});

  @override
  _EditBarangPageState createState() => _EditBarangPageState();
}

class _EditBarangPageState extends State<EditBarangPage> {
  //inisialisasi variabel
  final ImagePicker _imagePicker = ImagePicker();
  File? _image;
  final BarangController barangController = BarangController();
  bool _isUploading = false;

  //variabel form
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _kode = TextEditingController();
  TextEditingController _nama = TextEditingController();
  TextEditingController _stok = TextEditingController();
  TextEditingController _harga = TextEditingController();
  TextEditingController _keterangan = TextEditingController();
  String? _gambar;

  Future<void> _pickImage(ImageSource media) async {
    final pickedFile = await _imagePicker.pickImage(
      source: media,
    );

    setState(() {
      if (!mounted) return;
      _image = File(pickedFile!.path);
    });
  }

  void initState() {
    super.initState();

    _kode.text = widget.kode;
    _nama.text = widget.nama;
    _stok.text = widget.stok.toString();
    _harga.text = widget.harga.toString();
    _keterangan.text = widget.keterangan;
    _gambar = widget.gambar;

    print(widget.id);
  }

  Future<void> _uploadImage() async {
    if (_image == null) return;

    try {
      setState(() {
        _isUploading = true;
      });

      // Generate nama unik untuk file gambar menggunakan timestamp
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();

      //menyimpan gambar ke firebase
      firebase_storage.Reference ref =
          firebase_storage.FirebaseStorage.instance.ref().child(fileName);
      firebase_storage.UploadTask uploadTask = ref.putFile(_image!);
      firebase_storage.TaskSnapshot storageSnapshot = await uploadTask;

      // Dapatkan URL gambar yang telah diunggah
      String downloadURL = await storageSnapshot.ref.getDownloadURL();

      // Simpan data barang dengan URL gambar ke Firestore
      BarangModel newBarang = BarangModel(
        kode: _kode.text,
        nama: _nama.text,
        gambar: downloadURL,
        stok: int.parse(_stok.text),
        harga: int.parse(_harga.text),
        keterangan: _keterangan.text,
        id: widget.id,
      );

      print(_kode);
      print('object');

      await barangController.updateBarang(newBarang);

      setState(() {
        _isUploading = false;
      });

      Navigator.pop(context);
    } catch (e) {
      print('Error uploading image: $e');
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
        title: Text('Tambah Barang Baru'),
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
                // onChanged: (value) => _kode.text = value,
                controller: _kode,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Kode Barang harus diisi';
                  }
                  return null;
                },
              ),

              TextFormField(
                decoration: InputDecoration(labelText: 'Nama Barang'),
                // onChanged: (value) => _nama.text = value,
                controller: _nama,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Nama Barang harus diisi';
                  }
                  return null;
                },
              ),

              TextFormField(
                decoration: InputDecoration(labelText: 'Stok'),
                keyboardType: TextInputType.number,
                // onChanged: (value) => _stok.text = value,
                controller: _stok,
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
                // onChanged: (value) => _harga.text = value,
                controller: _harga,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Harga harus diisi';
                  }
                  return null;
                },
              ),

              TextFormField(
                decoration: InputDecoration(labelText: 'Keterangan'),
                // onChanged: (value) => _keterangan.text = value,
                controller: _keterangan,
                maxLines: 5,
              ),

              SizedBox(height: 16),

              Text(
                'File Gambar',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),

              SizedBox(height: 10),

              _image != null
                  ? Image.file(
                      // _image!,
                      File(_image!.path),
                      height: 200,
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width,
                    )
                  : Image.network(
                    widget.gambar, 
                    fit: BoxFit.cover, //agar ukuran gambar tidak gepeng
                    height: 200,
                    width: MediaQuery.of(context).size.width, //agar menyesuaikan lebar hp
                  ),
              ElevatedButton(
                onPressed: () {
                  _pickImage(ImageSource.camera);
                },
                child: Text('Pilih Gambar'),
              ),
              ElevatedButton(
                onPressed: _isUploading
                    ? null // Jika proses upload sedang berjalan, nonaktifkan tombol Simpan
                    : () {
                        _uploadImage();
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
