// ignore_for_file: unused_import, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_new_app_3/model/trbk_model.dart';

class TrbkController {
  final CollectionReference _TrbkCollection =
      FirebaseFirestore.instance.collection('trbk');

  //menambahkan data Trbk
  Future<void> addTrbk(TrbkModel Trbk) async {
    await _TrbkCollection.add(Trbk.toMap());
  }

  Stream<List<TrbkModel>> getTrbks() {
    return _TrbkCollection.snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              final TrbkData = doc.data() as Map<String, dynamic>;
              return TrbkModel.fromMap(TrbkData, doc.id);
            }).toList());
  }

  Future<TrbkModel> showTrbks(no_faktur) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('trbk') // Ganti dengan nama koleksi Anda
        .where("no_faktur", isEqualTo: no_faktur)
        .get();

      DocumentSnapshot document = querySnapshot.docs[0];
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      data['id'] = document.id;

      return TrbkModel.fromMap(data, data['id']);
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
