// ignore_for_file: unused_import, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_new_app_3/model/trbm_model.dart';

class TrbmController {

    final CollectionReference _TrbmCollection =
        FirebaseFirestore.instance.collection('trbm');

  //menambahkan data Trbm
  Future<void> addTrbm(TrbmModel Trbm) async {
    await _TrbmCollection.add(Trbm.toMap());
  }

  
  Stream<List<TrbmModel>> getTrbms() {
    return _TrbmCollection
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              final TrbmData = doc.data() as Map<String, dynamic>;
              return TrbmModel.fromMap(TrbmData, doc.id);
            }).toList());
  }

  // Mengupdate data Trbm
  Future<void> updateTrbm(TrbmModel Trbm) async {
    await _TrbmCollection.doc(Trbm.id).update(Trbm.toMap());
  }

  // Menghapus data Trbm
  Future<void> deleteTrbm(String id) async {
    await _TrbmCollection.doc(id).delete();
  }
}
