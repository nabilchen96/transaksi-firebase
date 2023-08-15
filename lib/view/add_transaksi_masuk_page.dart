// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, avoid_print, library_private_types_in_public_api, use_key_in_widget_constructors, unused_field, unused_import, prefer_final_fields, non_constant_identifier_names, unrelated_type_equality_checks

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

class DetailTransaksi {
  final String kodeBarang;
  final int jumlah;
  final int harga;
  final int totalHarga;
  final String nama;

  DetailTransaksi(
      this.kodeBarang, this.jumlah, this.harga, this.totalHarga, this.nama);
}

class _AddTransaksiMasukPageState extends State<AddTransaksiMasukPage> {
  //variabel
  BarangController barangController = BarangController();

  DateTime tanggalPilihan = DateTime.now();
  BarangModel? barangPilihan;
  int? hargaBarang;
  int? totalHargaBarang;
  String? kodeBarang;
  String? namaBarang;

  TextEditingController dateController = TextEditingController();
  TextEditingController fakturController = TextEditingController();
  TextEditingController namaController = TextEditingController();
  TextEditingController nomorTelponController = TextEditingController();
  TextEditingController jumlahController = TextEditingController();

  List<DetailTransaksi> detailTransaksi = [];

  Future<void> pilihTanggal(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: tanggalPilihan, // Initial date when the date picker is shown
      firstDate: DateTime(2000), // Earliest selectable date
      lastDate: DateTime(2101), // Latest selectable date
    );
    if (picked != null && picked != tanggalPilihan) {
      setState(() {
        tanggalPilihan = picked;
        dateController.text = DateFormat('dd-MM-yyyy').format(tanggalPilihan);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Transaksi Baru'),
      ),
      body: ListView(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
        ),
        children: [
          TextFormField(
            decoration: InputDecoration(
              labelText: 'No Faktur',
            ),
            controller: fakturController,
          ),
          GestureDetector(
            onTap: () => pilihTanggal(context),
            child: AbsorbPointer(
              child: TextFormField(
                controller: dateController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Tanggal',
                ),
              ),
            ),
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Nama Pembeli',
            ),
            controller: namaController,
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Nomor Telpon',
            ),
            controller: nomorTelponController,
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Alamat'),
            maxLines: 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 4,
                child: Container(
                  height: 80,
                  child: StreamBuilder<List<BarangModel>>(
                    stream: barangController.getBarangs(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<BarangModel> barangs = snapshot.data!;
                        return DropdownButtonFormField<String>(
                          value: barangPilihan != null &&
                                  barangs.contains(barangPilihan)
                              ? barangPilihan!.kode
                              : null,
                          decoration: InputDecoration(
                            labelText: 'Pilih Barang',
                          ),
                          items: barangs.map((barang) {
                            String displayText =
                                '${barang.kode} - ${barang.nama}';
                            if (displayText.length > 29) {
                              displayText = displayText.substring(0, 29);
                            }
                            return DropdownMenuItem<String>(
                              value: barang.kode,
                              child: Text(
                                displayText,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            );
                          }).toList(),
                          onChanged: (selectedBarangKode) {
                            // Temukan objek barang yang sesuai berdasarkan kode yang dipilih
                            BarangModel selectedBarang = barangs.firstWhere(
                              (barang) => barang.kode == selectedBarangKode,
                              orElse: () => BarangModel(
                                kode: '',
                                nama: '',
                                harga: 0,
                                gambar: '',
                                keterangan: '',
                                stok: 0,
                              ),
                            );

                            // Ambil data harga dan nama dari objek barang yang dipilih
                            namaBarang = selectedBarang.nama;
                            hargaBarang = selectedBarang.harga;
                            kodeBarang = selectedBarang.kode;
                          },
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                flex: 1,
                child: Container(
                  height: 70,
                  child: TextFormField(
                    controller: jumlahController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Jumlah',
                    ),
                  ),
                ),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {

              setState(() {
                
                totalHargaBarang =
                    hargaBarang! * int.parse(jumlahController.text);

                detailTransaksi.add(
                  DetailTransaksi(
                    kodeBarang!,
                    int.parse(jumlahController.text),
                    hargaBarang!,
                    totalHargaBarang!,
                    namaBarang!,
                  ),
                );
              });
            },
            child: Text('Tambah Item'),
          ),
          SizedBox(height: 20), // Tambahkan jarak antara form dan daftar item
          Text(
            'Daftar Item',
            style: TextStyle(fontSize: 16),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.only(top: 8),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: detailTransaksi.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.all(0),
                      title: Text(detailTransaksi[index].nama),
                      subtitle: Text(
                        'Total Item: ${detailTransaksi[index].jumlah}\n'
                        'Harga: Rp ${detailTransaksi[index].harga}\n'
                        'Total Harga: Rp ${detailTransaksi[index].totalHarga}\n',
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          setState(
                            () {
                              detailTransaksi.removeAt(index);
                            },
                          );
                        },
                      ),
                    ),
                    Divider()
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
