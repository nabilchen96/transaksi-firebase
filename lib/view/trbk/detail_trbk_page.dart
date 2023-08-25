// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations, unused_local_variable, must_be_immutable, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_new_app_3/controller/detail_trbk_controller.dart';
import 'package:flutter_new_app_3/controller/trbk_controller.dart';
import 'package:flutter_new_app_3/model/detail_trbk_model.dart';
import 'package:flutter_new_app_3/model/trbk_model.dart';
import 'package:flutter_new_app_3/view/trbk/edit_trbk_page.dart';
import 'package:intl/intl.dart';

class DetailTrbkPage extends StatefulWidget {
  String noFaktur;

  DetailTrbkPage({required this.noFaktur});

  @override
  State<DetailTrbkPage> createState() => _DetailTrbkPageState();
}

class _DetailTrbkPageState extends State<DetailTrbkPage> {
  int _currentIndex = 0;

  TrbkController trbkController = TrbkController();
  DetailTrbkController detailTrbkController = DetailTrbkController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Barang Kerluar"),
      ),
      body: ListView(
        padding: EdgeInsets.only(
          top: 16,
          left: 16,
          right: 16,
        ),
        children: [
          FutureBuilder<TrbkModel>(
            future: trbkController.showTrbks(widget.noFaktur),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                ); // Tampilkan indikator loading jika data masih dimuat
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (!snapshot.hasData || snapshot.data == null) {
                return Text('Data not found');
              } else {
                TrbkModel trbk = snapshot.data!;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('No Faktur'),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      '${trbk.no_faktur}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Divider(),
                    Text('Tanggal'),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      '${trbk.tgl_keluar}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Divider(),
                    Text('Nama Pembeli'),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      '${trbk.nama_pembeli}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Divider(),
                    Text('Nomor Telpon'),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      '${trbk.nomor_telpon}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Divider(),
                    Text('Alamat'),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      '${trbk.alamat}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Divider(),
                    SizedBox(
                      height: 5,
                    ),
                    Text('List Item'),
                    SizedBox(
                      height: 5,
                    ),
                    FutureBuilder(
                      future:
                          detailTrbkController.showDetailTrbks(widget.noFaktur),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          ); // Tampilkan indikator loading jika data masih dimuat
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else if (!snapshot.hasData || snapshot.data == null) {
                          return Text('Data not found');
                        } else {
                          List<DetailTrbkModel> dataList =
                              snapshot.data as List<DetailTrbkModel>;

                          return ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: dataList.length,
                            itemBuilder: (context, index) {
                              DetailTrbkModel list = dataList[index];
                              return ListTile(
                                contentPadding: EdgeInsets.only(left: 0),
                                title: Text('${list.nama}'),
                                subtitle: Text(
                                  'Total Item: ${list.jumlah}\n'
                                  'Harga: Rp ${NumberFormat('###,###').format(list.harga)}\n'
                                  'Total Harga: Rp ${NumberFormat('###,###').format(list.total_harga)}\n',
                                ),
                              );
                            },
                          );
                        }
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Grand Total'),
                    Text(
                      'Rp ${NumberFormat('###,###').format(trbk.grand_total)}',
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    )
                  ],
                );
              }
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            if (index == 0) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditTrbkPage(
                    no_faktur: widget.noFaktur,
                  ),
                ),
              );
            } else {}
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.edit_note),
            label: 'Edit Data',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.delete),
            label: 'Hapus Data',
          ),
        ],
      ),
    );
  }
}
