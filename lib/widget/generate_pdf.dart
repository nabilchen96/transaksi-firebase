// ignore_for_file: unused_import

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

void createAndSavePDF() async {
  final pdf = pw.Document();

  // Tambahkan konten ke dalam file PDF
  pdf.addPage(
    pw.Page(
      build: (pw.Context context) {
        return pw.Center(
          child: pw.Text('Contoh File PDF di Flutter'),
        );
      },
    ),
  );

  // Dapatkan direktori penyimpanan lokal
  Directory documentDirectory = await getApplicationDocumentsDirectory();
  String documentPath = documentDirectory.path;

  // Buat file PDF dengan nama "example.pdf" di direktori penyimpanan lokal
  File file = File("$documentPath/example.pdf");

  // Simpan file PDF ke penyimpanan lokal
  await file.writeAsBytes(await pdf.save());
}
