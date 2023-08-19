// ignore_for_file: prefer_const_constructors, unnecessary_brace_in_string_interps, use_key_in_widget_constructors, unnecessary_string_interpolations, unused_local_variable, prefer_const_literals_to_create_immutables, unused_import, non_constant_identifier_names, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_new_app_3/controller/barang_controller.dart';
import 'package:flutter_new_app_3/controller/trbk_controller.dart';
import 'package:flutter_new_app_3/model/barang_model.dart';
import 'package:flutter_new_app_3/model/trbk_model.dart';
import 'package:flutter_new_app_3/view/barang/add_barang_page.dart';
import 'package:flutter_new_app_3/view/trbk/add_trbk_page.dart';
import 'package:flutter_new_app_3/view/trbk/detail_trbk_page.dart';
import 'package:flutter_new_app_3/widget/barang_list_tile.dart';
import 'package:intl/intl.dart';

import '../barang/edit_barang_page.dart';

class TrbkListPage extends StatelessWidget {
  final TrbkController trbkController = TrbkController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaksi Barang Keluar'),
      ),
      body: StreamBuilder<List<TrbkModel>>(
        stream: trbkController.getTrbks(),
        builder: (context, snapshot) {
          print('tes: ${snapshot}');
          if (snapshot.hasData) {
            List<TrbkModel> trbk_keluar = snapshot.data!;
            return ListView.builder(
                itemCount: trbk_keluar.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.only(
                          top: 5,
                          bottom: 5,
                          left: 16,
                          right: 16,
                        ),
                        title: Text(
                          'No Faktur: ' + trbk_keluar[index].no_faktur,
                        ),
                        subtitle: Text(
                          'Tanggal Transaksi: ${DateFormat('dd-MM-yyyy').format(trbk_keluar[index].tgl_keluar)}\n'
                          'Grand Total: Rp ${NumberFormat('###,###').format(trbk_keluar[index].grand_total)}',
                        ),
                        trailing: Column(
                          children: [
                            const Text('Lihat'),
                            SizedBox(
                              height: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailTrbkPage(
                                      noFaktur: trbk_keluar[index].no_faktur
                                    ),
                                  ),
                                );
                              },
                              child: Icon(
                                Icons.remove_red_eye_rounded,
                                size: 30,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider()
                    ],
                  );
                });
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddTrbkPage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
