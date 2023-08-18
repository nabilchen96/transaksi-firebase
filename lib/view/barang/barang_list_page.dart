// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_new_app_3/controller/barang_controller.dart';
import 'package:flutter_new_app_3/model/barang_model.dart';
import 'package:flutter_new_app_3/view/barang/add_barang_page.dart';
import 'package:flutter_new_app_3/widget/barang_list_tile.dart';
import 'package:intl/intl.dart';

import 'edit_barang_page.dart';

class BarangListPage extends StatelessWidget {
  final BarangController barangController = BarangController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Barang'),
      ),
      body: StreamBuilder<List<BarangModel>>(
        stream: barangController.getBarangs(),
        builder: (context, snapshot) {
          print('tes: ${snapshot}');
          if (snapshot.hasData) {
            List<BarangModel> barangs = snapshot.data!;
            return ListView(
              children: [
                GridView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: barangs.length, //total jumlah barang
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 1,
                    childAspectRatio: 0.81,
                  ),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          // DetailPage adalah halaman yang dituju
                          MaterialPageRoute(
                            builder: (context) => EditBarangPage(
                              id: barangs[index].id.toString(),
                              nama: barangs[index].nama,
                              stok: barangs[index].stok,
                              harga: barangs[index].harga,
                              harga_jual: barangs[index].harga_jual,
                              keterangan: barangs[index].keterangan,
                              kode: barangs[index].kode,
                              gambar: barangs[index].gambar,
                            ),
                          ),
                        );
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              child: Container(
                                height: 120,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  ),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                      barangs[index]
                                          .gambar, // Ganti dengan URL gambar Anda
                                    ),
                                  ),
                                ),
                                width: MediaQuery.of(context).size.width,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 8,
                                left: 8,
                                right: 8,
                              ),
                              child: Expanded(
                                child: Text(
                                  barangs[index].nama,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8, 8, 0, 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween, // Menampilkan tombol di sebelah kanan
                                children: [
                                  Text(
                                    'Rp. ${NumberFormat('###,###').format(barangs[index].harga_jual)}',
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween, // Menampilkan tombol di sebelah kanan
                                children: [
                                  Text(
                                    'Stok: ${barangs[index].stok}',
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            );
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
              builder: (context) => AddBarangPage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
