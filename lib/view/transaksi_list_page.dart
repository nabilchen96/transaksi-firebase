// ignore_for_file: prefer_const_constructors, unnecessary_brace_in_string_interps, use_key_in_widget_constructors, unnecessary_string_interpolations, unused_local_variable, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_new_app_3/controller/barang_controller.dart';
import 'package:flutter_new_app_3/controller/transaksi_masuk_controller.dart';
import 'package:flutter_new_app_3/model/barang_model.dart';
import 'package:flutter_new_app_3/model/transaksi_masuk_model.dart';
import 'package:flutter_new_app_3/view/add_barang_page.dart';
import 'package:flutter_new_app_3/view/add_transaksi_masuk_page.dart';
import 'package:flutter_new_app_3/widget/barang_list_tile.dart';
import 'package:intl/intl.dart';

import 'edit_barang_page.dart';

class TransaksiListPage extends StatelessWidget {
  final TransaksiMasukController transaksiMasukController =
      TransaksiMasukController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaksi Barang'),
      ),
      body: StreamBuilder<List<TransaksiMasukModel>>(
        stream: transaksiMasukController.getTransaksiMasuks(),
        builder: (context, snapshot) {
          print('tes: ${snapshot}');
          if (snapshot.hasData) {
            List<TransaksiMasukModel> transaksi_masuk = snapshot.data!;
            return ListView.builder(
                itemCount: transaksi_masuk.length,
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
                          'No Faktur: ' + transaksi_masuk[index].no_faktur,
                        ),
                        subtitle: Text(
                          'Tanggal Transaksi: ${DateFormat('dd-MM-yyyy').format(transaksi_masuk[index].tgl_masuk)}\n'
                          'Total: Rp ${NumberFormat('###,###').format(transaksi_masuk[index].total)}',
                        ),
                        trailing: Column(
                          children: [
                            const Text('Lihat'),
                            SizedBox(
                              height: 5,
                            ),
                            Icon(
                              Icons.remove_red_eye_rounded,
                              size: 30,
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
              builder: (context) => AddTransaksiMasukPage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
