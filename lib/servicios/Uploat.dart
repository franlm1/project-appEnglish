import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:image_picker/image_picker.dart';


import '../menu/animation_route.dart';
import '../vista/Frans/MenuMovil.dart';

class UploatImagen {
  final String tematica;
  final String titulo;
  final String descripcion;
  final String tipo;
  late  int count;

  FirebaseStorage storage = FirebaseStorage.instance;

  UploatImagen(this.tematica, this.titulo, this.descripcion, this.tipo);

  void main() {
    runApp(MaterialApp(home: MenuMovil()));
  }

  Future<void> upload() async {
    final picker = ImagePicker();
    XFile? pickedImage;
    try {
      if (tipo.trim() == "Videos") {
        pickedImage = await picker.pickVideo(
          source: ImageSource.gallery,
        );
      } else {
        pickedImage =
            await picker.pickImage(source: ImageSource.gallery, maxWidth: 1920);
      }

      final String fileName = path.basename(pickedImage!.path);
      File imageFile = File(pickedImage.path);

      try {
        if (tipo.trim() == "Videos") {
          await storage.ref().child(tematica).child('Videos').child(titulo).putFile(
              imageFile,
              SettableMetadata(customMetadata: {
                'uploaded_by': titulo,
                'description': descripcion
              }));
        } else {
          await storage
              .ref()
              .child(tematica)
              .child('Archivos')
              .child(titulo)
              .putFile(
                  imageFile,
                  SettableMetadata(customMetadata: {
                    'uploaded_by': titulo,
                    'description': descripcion
                  }));
        }
      } on FirebaseException catch (error) {
        if (kDebugMode) {
          print(error);
        }
      }
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }
  }
}
