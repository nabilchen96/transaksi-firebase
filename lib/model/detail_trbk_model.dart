class DetailTrbkModel {
  String? id;
  String kode_barang;
  int jumlah;
  int harga;
  int total_harga;
  String nama;

  DetailTrbkModel({
    this.id,
    required this.kode_barang, 
    required this.jumlah, 
    required this.harga, 
    required this.total_harga, 
    required this.nama
  });

  factory DetailTrbkModel.fromMap(Map<String, dynamic> map, id) {
    return DetailTrbkModel(
      id: id, 
      kode_barang: map['kode_barang'].toString(),
      jumlah: int.parse(map['jumlah'].toString()), 
      harga: int.parse(map['harga'].toString()),
      total_harga: int.parse(map['total_harga'].toString()),
      nama: map['nama'].toString()
    );
  }

  // Konversi dari BarangModel ke Map<String, dynamic>
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'kode_barang': kode_barang,
      'jumlah': jumlah, 
      'harga': harga, 
      'total_harga': total_harga, 
      'nama': nama
    };
  }
}
