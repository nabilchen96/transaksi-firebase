// ignore_for_file: unused_import, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_new_app_3/model/detail_trbm_model.dart';

class DetailTrbmController {
  final CollectionReference _DetailTrbmCollection =
      FirebaseFirestore.instance.collection('detail_trbm');

  //menambahkan data TransaksiMasuk
  Future<void> addDetailTrbm(
      List<DetailTrbmModel> DetailTrbm) async {
    // await _DetailTrbmCollection.add(DetailTrbm.toMap());
    for (var item in DetailTrbm) {
      await _DetailTrbmCollection.add(item.toMap());
    }
  }
}
