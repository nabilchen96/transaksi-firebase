// ignore_for_file: non_constant_identifier_names

class TrbmModel {
  String? id;
  String no_faktur;
  DateTime tgl_masuk;
  String nama_supplier;
  String alamat;
  String nomor_telpon;
  int harga;
  int grand_total;

  TrbmModel({
    this.id,
    required this.no_faktur,
    required this.tgl_masuk,
    required this.nama_supplier, 
    required this.alamat, 
    required this.nomor_telpon, 
    required this.harga,
    required this.grand_total
  });

  factory TrbmModel.fromMap(Map<String, dynamic> map, id) {
    return TrbmModel(
      id: id,
      no_faktur: map['no_faktur'].toString(),
      tgl_masuk: map['tgl_masuk'].toDate(),
      nama_supplier: map['nama_supplier'].toString(), 
      alamat: map['alamat'].toString(), 
      nomor_telpon: map['nomor_telpon'].toString(), 
      harga: int.parse(map['harga'].toString()),
      grand_total: int.parse(map['grand_total'].toString()),
    );
  }

  // Konversi dari BarangModel ke Map<String, dynamic>
  Map<String, dynamic> toMap() {
    return {
      'no_faktur': no_faktur,
      'tgl_masuk': tgl_masuk,
      'nama_supplier': nama_supplier, 
      'alamat': alamat, 
      'nomor_telpon': nomor_telpon, 
      'harga': harga,
      'grand_total': grand_total
    };
  }
}
