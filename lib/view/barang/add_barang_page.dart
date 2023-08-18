// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, avoid_print, library_private_types_in_public_api, use_key_in_widget_constructors, unused_field, unused_import, prefer_final_fields, unnecessary_null_comparison

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_new_app_3/controller/barang_controller.dart';
import 'package:flutter_new_app_3/model/barang_model.dart';
import 'package:flutter_new_app_3/view/barang/barang_list_page.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class AddBarangPage extends StatefulWidget {
  @override
  _AddBarangPageState createState() => _AddBarangPageState();
}

class _AddBarangPageState extends State<AddBarangPage> {
  //inisialisasi variabel
  final ImagePicker _imagePicker = ImagePicker();
  File? _image;
  final BarangController barangController = BarangController();
  bool _isUploading = false;

  //variabel form
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _kode;
  String? _nama;
  int? _stok;
  int? _harga;
  int? _harga_jual;
  String? _keterangan;

  //method untuk mengambil gambar dari media, media
  //ImageSource media adalah parameter yang dimasukan saat method ini dipanggil
  //anda dapat memilih ImageSource dari gallery atau dari camera
  Future<void> _pickImage(ImageSource media) async {
    final pickedFile = await _imagePicker.pickImage(
      source: media,
    );

    //isi variabel _image dengan gambar yang dipilih
    setState(() {
      if (!mounted) return;
      _image = File(pickedFile!.path);
    });
  }

  //method untuk mengirim data ke firebase
  Future<void> _sendImage() async {
    if (_image == null) return;

    try {
      //jika tombol kirim ditekan maka ubah variabel _isUpload menjadi true
      //jika variabel _isUpload true anda bisa menampilkan progress indicator
      setState(() {
        _isUploading = true;
      });

      // Generate nama unik untuk file gambar menggunakan timestamp
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      firebase_storage.Reference ref =
          firebase_storage.FirebaseStorage.instance.ref().child(fileName);
      firebase_storage.UploadTask uploadTask = ref.putFile(_image!);
      firebase_storage.TaskSnapshot storageSnapshot = await uploadTask;

      // Dapatkan URL gambar yang telah diunggah
      String downloadURL = await storageSnapshot.ref.getDownloadURL();

      // Masukkan data yang sudah disiapkan ke dalam BarangModel
      BarangModel newBarang = BarangModel(
        kode: _kode!,
        nama: _nama!,
        gambar: downloadURL,
        stok: _stok!,
        harga: _harga!,
        harga_jual: _harga_jual!,
        keterangan: _keterangan!,
      );

      //addBarang adalah method untuk menambah barang ke firebase
      await barangController.addBarang(newBarang);

      setState(() {
        _isUploading = false;
      });

      //kembali ke halaman sebelumnya
      Navigator.pop(context);
    } catch (e) {

      //jika terjadi error, error dapat dilihat di terminal
      print('Error uploading image: $e');

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
              TextFormField(
                decoration: InputDecoration(labelText: 'Kode Barang'),
                onChanged: (value) => _kode = value,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Kode Barang harus diisi';
                  }
                  return null;
                },
              ),

              TextFormField(
                decoration: InputDecoration(labelText: 'Nama Barang'),
                onChanged: (value) => _nama = value,
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
                onChanged: (value) => _stok = int.parse(value),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Stok harus diisi';
                  }
                  return null;
                },
              ),

              TextFormField(
                decoration: InputDecoration(labelText: 'Harga Modal'),
                keyboardType: TextInputType.number,
                onChanged: (value) => _harga = int.parse(value),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Harga Modal harus diisi';
                  }
                  return null;
                },
              ),

              TextFormField(
                decoration: InputDecoration(labelText: 'Harga Jual'),
                keyboardType: TextInputType.number,
                onChanged: (value) => _harga_jual = int.parse(value),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Harga Jual harus diisi';
                  }
                  return null;
                },
              ),

              TextFormField(
                decoration: InputDecoration(labelText: 'Keterangan'),
                onChanged: (value) => _keterangan = value,
                maxLines: 5,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Keterangan harus diisi';
                  }
                  return null;
                },
              ),

              SizedBox(height: 16),

              Text(
                'File Gambar',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),

              SizedBox(height: 10), //berfungsi untuk menambah spasi

              _image != null
                  ? Image.file(
                      // _image!,
                      File(_image!.path),
                      height: 200,
                      fit: BoxFit.cover,
                      
                      //width dibuat menyesuaikan lebar smartphone apapun
                      width: MediaQuery.of(context).size.width,
                    )
                  : Placeholder(
                      fallbackHeight: 200,
                    ),
              ElevatedButton(
                onPressed: () {
                  _pickImage(ImageSource.camera);
                },
                child: Text('Pilih Gambar'),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (_isUploading != null) {
                      _sendImage();
                    }
                  }
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
