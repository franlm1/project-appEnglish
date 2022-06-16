

import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:tuttorial_1/vista/MenuControlador.dart';
import 'package:tuttorial_1/vista/galeria/MenuGaleriaGaleria.dart';
import '../../util/animation_route.dart';

class MediaPdf extends StatefulWidget {
  final String url;

   MediaPdf(this.url);

  @override
  State<MediaPdf> createState() => _MediaPdfState();
}

class _MediaPdfState extends State<MediaPdf> {
  bool _isLoading = true;
  late PDFDocument document;

   @override
  void initState() {
    super.initState();
    loadDocument();
  }
  loadDocument() async {
    document = await PDFDocument.fromURL(widget.url);
    
    setState(() => _isLoading = false);
  }
 @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
          title: Text(''),
          automaticallyImplyLeading: false,
          actions: [
            InkWell(
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
                onTap: () {
                  Navigator.push(context,
                          Animation_route(MenuControlador()))
                      .whenComplete(() => Navigator.of(context).pop());
                }),
            const SizedBox(width: 10),
          ],
        ),
      body: Center(
          child: _isLoading
              ? Center(child: CircularProgressIndicator())
              : PDFViewer(document: document)),
    );
  }
}