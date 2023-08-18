// ignore_for_file: non_constant_identifier_names

class TrbkModel {
  String? id;
  String no_faktur;
  DateTime tgl_masuk;
  String nama_pembeli;
  String alamat;
  String nomor_telpon;
  int grand_total;

  TrbkModel({
    this.id,
    required this.no_faktur,
    required this.tgl_masuk,
    required this.nama_pembeli, 
    required this.alamat, 
    required this.nomor_telpon, 
    required this.grand_total
  });

  factory TrbkModel.fromMap(Map<String, dynamic> map, id) {
    return TrbkModel(
      id: id,
      no_faktur: map['no_faktur'].toString(),
      tgl_masuk: map['tgl_masuk'].toDate(),
      nama_pembeli: map['nama_pembeli'].toString(), 
      alamat: map['alamat'].toString(), 
      nomor_telpon: map['nomor_telpon'].toString(), 
      grand_total: int.parse(map['grand_total'].toString()),
    );
  }

  // Konversi dari BarangModel ke Map<String, dynamic>
  Map<String, dynamic> toMap() {
    return {
      'no_faktur': no_faktur,
      'tgl_masuk': tgl_masuk,
      'nama_pembeli': nama_pembeli, 
      'alamat': alamat, 
      'nomor_telpon': nomor_telpon, 
      'grand_total': grand_total
    };
  }
}
