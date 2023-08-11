// ignore_for_file: non_constant_identifier_names

class TransaksiMasukModel {
  String? id;
  String kode_barang;
  String no_faktur;
  DateTime tgl_masuk;
  int quantity;
  int harga;
  String kemasan;
  int total;

  TransaksiMasukModel({
    this.id,
    required this.kode_barang,
    required this.no_faktur,
    required this.tgl_masuk,
    required this.quantity,
    required this.harga,
    required this.kemasan,
    required this.total,
  });

  factory TransaksiMasukModel.fromMap(Map<String, dynamic> map, id) {
    return TransaksiMasukModel(
      id: id,
      kode_barang: map['kode_barang'].toString(),
      no_faktur: map['no_faktur'].toString(),
      tgl_masuk: map['tgl_masuk'].toDate(),
      quantity: map['quantity'],
      harga: int.parse(map['harga'].toString()),
      kemasan: map['kemasan'],
      total: map['total']
    );
  }

  // Konversi dari BarangModel ke Map<String, dynamic>
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'kode': kode_barang,
      'nama': no_faktur,
      'quantity': quantity,
      'harga': harga,
      'tgl_masuk': tgl_masuk,
      'kemasan': kemasan,
      'total': total
    };
  }
}
