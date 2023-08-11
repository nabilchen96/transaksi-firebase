import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_new_app_3/model/barang_model.dart';

class BarangController {
    final CollectionReference _barangCollection =
        FirebaseFirestore.instance.collection('barangs');

  //menambahkan data barang
  Future<void> addBarang(BarangModel barang) async {
    await _barangCollection.add(barang.toMap());
  }

  
  Stream<List<BarangModel>> getBarangs() {
    return _barangCollection
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              final barangData = doc.data() as Map<String, dynamic>;
              return BarangModel.fromMap(barangData, doc.id);
            }).toList());
  }

  // Mengupdate data barang
  Future<void> updateBarang(BarangModel barang) async {
    await _barangCollection.doc(barang.id).update(barang.toMap());
  }

  // Menghapus data barang
  Future<void> deleteBarang(String id) async {
    await _barangCollection.doc(id).delete();
  }
}
