// ignore_for_file: unused_import, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_new_app_3/model/detail_trbk_model.dart';

class DetailTrbkController {
  final CollectionReference _DetailTrbkCollection =
      FirebaseFirestore.instance.collection('detail_trbk');

  //menambahkan data TransaksiMasuk
  Future<void> addDetailTrbk(
      List<DetailTrbkModel> DetailTrbk) async {
    // await _DetailTrbkCollection.add(DetailTrbk.toMap());
    for (var item in DetailTrbk) {
      await _DetailTrbkCollection.add(item.toMap());
    }
  }
}
