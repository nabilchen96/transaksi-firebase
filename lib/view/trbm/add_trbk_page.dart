// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, avoid_print, library_private_types_in_public_api, use_key_in_widget_constructors, unused_field, unused_import, prefer_final_fields, non_constant_identifier_names, unrelated_type_equality_checks, unnecessary_string_interpolations

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_new_app_3/controller/barang_controller.dart';
import 'package:flutter_new_app_3/controller/detail_trbm_controller.dart';
import 'package:flutter_new_app_3/controller/trbm_controller.dart';
import 'package:flutter_new_app_3/model/barang_model.dart';
import 'package:flutter_new_app_3/model/detail_trbm_model.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter_new_app_3/model/trbm_model.dart';
import 'package:intl/intl.dart';

class AddTrbmPage extends StatefulWidget {
  @override
  _AddTrbmPageState createState() => _AddTrbmPageState();
}

class _AddTrbmPageState extends State<AddTrbmPage> {
  //variabel
  BarangController barangController = BarangController();
  TrbmController trbmController = TrbmController();

  DetailTrbmController detailTrbmController = DetailTrbmController();

  DateTime tanggalPilihan = DateTime.now();
  BarangModel? barangPilihan;
  int? hargaBarang;
  int? totalHargaBarang;
  String? kodeBarang;
  String? namaBarang;
  bool _isUploading = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController dateController = TextEditingController();
  TextEditingController fakturController = TextEditingController();
  TextEditingController namaController = TextEditingController();
  TextEditingController nomorTelponController = TextEditingController();
  TextEditingController jumlahController = TextEditingController();
  TextEditingController grandTotalController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  TextEditingController hargaController = TextEditingController();

  List<DetailTrbmModel> detailTransaksiModel = [];

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

  int calculateGrandTotal() {
    int grandTotal = 0;
    for (var item in detailTransaksiModel) {
      grandTotal += item.total_harga;
    }
    return grandTotal;
  }

  void updateGrandTotal() {
    int grandTotal = calculateGrandTotal();
    grandTotalController.text = '${NumberFormat('###,###').format(grandTotal)}';
    // grandTotalController.text = '${grandTotal}';
  }

  Future<void> sendData() async {
    try {
      setState(() {
        _isUploading = true;
      });

      //kirim data transaksi barang masuk
      DateTime tglMasuk = DateFormat('dd-MM-yyyy').parse(dateController.text);

      TrbmModel newTransaksi = TrbmModel(
        no_faktur: fakturController.text,
        tgl_masuk: tglMasuk,
        alamat: alamatController.text,
        grand_total: int.parse(grandTotalController.text.replaceAll(',', '')),
        nama_supplier: namaController.text,
        nomor_telpon: nomorTelponController.text,
        harga: int.parse(hargaController.text),
      );

      await trbmController.addTrbm(newTransaksi);

      //kirim data detail transaksi barang masuk
      await detailTrbmController.addDetailTrbm(detailTransaksiModel);

      setState(() {
        _isUploading = false;
      });

      Navigator.pop(context);
    } catch (e) {
      print('errornya adalah ${e}');
      setState(() {
        _isUploading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Transaksi Masuk'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
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
              validator: (value) {
                if (value!.isEmpty) {
                  return 'No Faktur harus diisi';
                }
                return null;
              },
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
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Tanggal harus diisi';
                    }
                    return null;
                  },
                ),
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Nama Supplier',
              ),
              controller: namaController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Nama Supplier harus diisi';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Nomor Telpon',
              ),
              controller: nomorTelponController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Nomor Telpon harus diisi';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Alamat'),
              maxLines: 2,
              controller: alamatController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Alamat harus diisi';
                }
                return null;
              },
            ),
            Container(
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
                        String displayText = '${barang.kode} - ${barang.nama}';
                        if (displayText.length > 37) {
                          displayText = displayText.substring(0, 37);
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
                            harga_jual: 0,
                            gambar: '',
                            keterangan: '',
                            stok: 0,
                          ),
                        );

                        // Ambil data harga dan nama dari objek barang yang dipilih
                        setState(() {
                          namaBarang = selectedBarang.nama;
                          hargaBarang = selectedBarang.harga_jual;
                          kodeBarang = selectedBarang.kode;
                          hargaController.text = hargaBarang.toString();
                        });
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 4,
                  child: Container(
                    height: 70,
                    child: TextFormField(
                      controller: hargaController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Harga',
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  flex: 2,
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
                      int.parse(hargaController.text)! * int.parse(jumlahController.text);

                  detailTransaksiModel.add(
                    DetailTrbmModel(
                      id: '',
                      kode_barang: kodeBarang!,
                      jumlah: int.parse(jumlahController.text),
                      harga: int.parse(hargaController.text),
                      total_harga: totalHargaBarang!,
                      nama: namaBarang!,
                    ),
                  );

                  updateGrandTotal();
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
                itemCount: detailTransaksiModel.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.all(0),
                        title: Text(detailTransaksiModel[index].nama),
                        subtitle: Text(
                          'Total Item: ${detailTransaksiModel[index].jumlah}\n'
                          'Harga: Rp ${NumberFormat('###,###').format(detailTransaksiModel[index].harga)}\n'
                          'Total Harga: Rp ${NumberFormat('###,###').format(detailTransaksiModel[index].total_harga)}\n',
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            setState(
                              () {
                                detailTransaksiModel.removeAt(index);
                                updateGrandTotal();
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
            ),
            SizedBox(
              height: 20,
            ),
            Text('Grand Total'),
            TextFormField(
              readOnly: true,
              controller: grandTotalController,
              style: TextStyle(fontSize: 30),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Grand Total Tidak Boleh Kosong, Anda Harus Memilih Minimal 1 Item';
                }
                return null;
              },
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  if (_isUploading != null) {
                    sendData();
                  }
                }
              },
              child: _isUploading
                  ? CircularProgressIndicator()
                  : Text('Simpan Data'),
            ),
          ],
        ),
      ),
    );
  }
}
