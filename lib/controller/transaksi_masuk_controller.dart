// ignore_for_file: unused_import, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_new_app_3/model/transaksi_masuk_model.dart';

class TransaksiMasukController {
    final CollectionReference _TransaksiMasukCollection =
        FirebaseFirestore.instance.collection('transaksi_masuk');

  //menambahkan data TransaksiMasuk
  Future<void> addTransaksiMasuk(TransaksiMasukModel TransaksiMasuk) async {
    await _TransaksiMasukCollection.add(TransaksiMasuk.toMap());
  }

  
  Stream<List<TransaksiMasukModel>> getTransaksiMasuks() {
    return _TransaksiMasukCollection
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              final TransaksiMasukData = doc.data() as Map<String, dynamic>;
              return TransaksiMasukModel.fromMap(TransaksiMasukData, doc.id);
            }).toList());
  }

  // Mengupdate data TransaksiMasuk
  Future<void> updateTransaksiMasuk(TransaksiMasukModel TransaksiMasuk) async {
    await _TransaksiMasukCollection.doc(TransaksiMasuk.id).update(TransaksiMasuk.toMap());
  }

  // Menghapus data TransaksiMasuk
  Future<void> deleteTransaksiMasuk(String id) async {
    await _TransaksiMasukCollection.doc(id).delete();
  }
}
