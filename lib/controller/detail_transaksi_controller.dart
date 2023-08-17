// ignore_for_file: unused_import, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_new_app_3/model/detail_transaksi_model.dart';

class DetailTransaksiMasukController {
  final CollectionReference _DetailTransaksiMasukCollection =
      FirebaseFirestore.instance.collection('detail_transaksi_masuk');

  //menambahkan data TransaksiMasuk
  Future<void> addDetailTransaksiMasuk(
      List<DetailTransaksiModel> DetailTransaksiMasuk) async {
    // await _DetailTransaksiMasukCollection.add(DetailTransaksiMasuk.toMap());
    for (var item in DetailTransaksiMasuk) {
      await _DetailTransaksiMasukCollection.add(item.toMap());
    }
  }
}
