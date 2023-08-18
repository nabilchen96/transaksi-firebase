// ignore_for_file: prefer_const_constructors, unnecessary_brace_in_string_interps, use_key_in_widget_constructors, unnecessary_string_interpolations, unused_local_variable, prefer_const_literals_to_create_immutables, unused_import, non_constant_identifier_names, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_new_app_3/controller/trbm_controller.dart';
import 'package:flutter_new_app_3/model/trbm_model.dart';
import 'package:flutter_new_app_3/view/trbm/add_trbk_page.dart';
import 'package:intl/intl.dart';

class TrbmListPage extends StatelessWidget {
  final TrbmController trbmController = TrbmController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaksi Barang Masuk'),
      ),
      body: StreamBuilder<List<TrbmModel>>(
        stream: trbmController.getTrbms(),
        builder: (context, snapshot) {
          print('tes: ${snapshot}');
          if (snapshot.hasData) {
            List<TrbmModel> transaksi_masuk = snapshot.data!;
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
                          'Grand Total: Rp ${NumberFormat('###,###').format(transaksi_masuk[index].grand_total)}',
                          // 'Total: Rp ${transaksi_masuk[index].grand_total}',
                        ),
                        trailing: Column(
                          children: [
                            const Text('Lihat'),
                            SizedBox(
                              height: 10,
                            ),
                            GestureDetector(
                              onTap: (){
                                
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
              builder: (context) => AddTrbmPage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
