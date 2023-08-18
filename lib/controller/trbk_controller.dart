// ignore_for_file: unused_import, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_new_app_3/model/trbk_model.dart';

class TrbkController {

    final CollectionReference _TrbkCollection =
        FirebaseFirestore.instance.collection('transaksi_Keluar');

  //menambahkan data Trbk
  Future<void> addTrbk(TrbkModel Trbk) async {
    await _TrbkCollection.add(Trbk.toMap());
  }

  
  Stream<List<TrbkModel>> getTrbks() {
    return _TrbkCollection
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              final TrbkData = doc.data() as Map<String, dynamic>;
              return TrbkModel.fromMap(TrbkData, doc.id);
            }).toList());
  }

  // Mengupdate data Trbk
  Future<void> updateTrbk(TrbkModel Trbk) async {
    await _TrbkCollection.doc(Trbk.id).update(Trbk.toMap());
  }

  // Menghapus data Trbk
  Future<void> deleteTrbk(String id) async {
    await _TrbkCollection.doc(id).delete();
  }
}
