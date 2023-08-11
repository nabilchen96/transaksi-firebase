// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_new_app_3/controller/barang_controller.dart';
import 'package:flutter_new_app_3/model/barang_model.dart';
import 'package:flutter_new_app_3/widget/generate_pdf.dart';
import 'package:intl/intl.dart';

class BarangListTile extends StatelessWidget {
  final BarangModel barang;

  BarangListTile({required this.barang});
  @override
  Widget build(BuildContext context) {
    void _showDownloadMessage(BuildContext context) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('PDF sedang diunduh...'),
          duration: Duration(seconds: 2),
        ),
      );
    }

    return ListTile(
      contentPadding: EdgeInsets.only(top: 5, bottom: 5, left: 8, right: 8),
      leading: Image.network(
        barang.gambar,
        width: 50,
        fit: BoxFit.cover,
      ),
      title: Text(barang.nama),
      subtitle: Text(
          'Stok: ${barang.stok} \n'
          'Harga: Rp ${NumberFormat.decimalPattern().format(barang.harga)}'
        ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.file_copy),
            onPressed: () {
              createAndSavePDF(); // Panggil fungsi untuk membuat laporan PDF
              _showDownloadMessage(context);
            },
          ),
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              BarangController barangController = BarangController();
              barangController.deleteBarang(barang.id!);

              print(barang.id);
            },
          ),
        ],
      ),
    );
  }
}
