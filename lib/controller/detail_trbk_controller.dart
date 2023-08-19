// ignore_for_file: unused_import, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_new_app_3/model/detail_trbk_model.dart';

class DetailTrbkController {
  final CollectionReference _DetailTrbkCollection =
      FirebaseFirestore.instance.collection('detail_trbk');

  //menambahkan data TransaksiMasuk
  Future<void> addDetailTrbk(List<DetailTrbkModel> DetailTrbk) async {
    // await _DetailTrbkCollection.add(DetailTrbk.toMap());
    for (var item in DetailTrbk) {
      await _DetailTrbkCollection.add(item.toMap());
    }
  }

  //mengambil data berdasarkan parameter
  Future<List<DetailTrbkModel>> showDetailTrbks(no_faktur) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('detail_trbk') // Ganti dengan nama koleksi Anda
        .where("no_faktur", isEqualTo: no_faktur)
        .get();

    List<DetailTrbkModel> dataList = [];

    for (var document in querySnapshot.docs) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      data['id'] = document.id;
      dataList.add(DetailTrbkModel.fromMap(data, data['id']));
    }

    return dataList;
  }
}
