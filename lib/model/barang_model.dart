class BarangModel {
  String? id;
  String kode;
  String nama;
  String gambar;
  int stok;
  int harga;
  int harga_jual;
  String keterangan;

  BarangModel({
    this.id,
    required this.kode,
    required this.nama,
    required this.gambar,
    required this.stok,
    required this.harga,
    required this.harga_jual,
    required this.keterangan,
  });

  factory BarangModel.fromMap(Map<String, dynamic> map, id) {
    return BarangModel(
      id: id,
      kode: map['kode'],
      nama: map['nama'],
      gambar: map['gambar'],
      stok: map['stok'],
      harga: map['harga'],
      harga_jual: map['harga_jual'],
      keterangan: map['keterangan'],
    );
  }

  // Konversi dari BarangModel ke Map<String, dynamic>
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'kode': kode,
      'nama': nama,
      'gambar': gambar,
      'stok': stok,
      'harga': harga,
      'harga_jual': harga_jual,
      'keterangan': keterangan,
    };
  }
}
