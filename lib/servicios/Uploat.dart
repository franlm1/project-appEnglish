import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:image_picker/image_picker.dart';
import 'package:tuttorial_1/vista/MenuMovil.dart';
import 'package:file_picker/file_picker.dart';
import '../menu/animation_route.dart';
import '../vista/MenuControlador.dart';

class UploatImagen {
  FilePickerResult? result;
  final String tematica;
  final String titulo;
  final String descripcion;
  final String tipo;
  late int count;

  final storageRef = FirebaseStorage.instance.ref();
  PlatformFile? pickedFile;
  UploatImagen(this.tematica, this.titulo, this.descripcion, this.tipo);

  void main() {
    runApp(MaterialApp(home: MenuMovil()));
  }

  Future seletFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;
    return result.files.first;
  }

//     final picker = ImagePicker();
//     XFile? pickedImage;

//     try {
//       if (tipo.trim() == "Videos") {
//         pickedImage = await picker.pickVideo(
//           source: ImageSource.gallery,
//         );
//       } else {
//         result = await FilePicker.platform.pickFiles(
//           type: FileType.custom,
//           allowedExtensions: ['jpg', 'pdf', 'doc','png'],
//         );
//         // pickedImage =
//         // await picker.pickImage(source: ImageSource.gallery, maxWidth: 1920);

//       }

//       final String fileName = path.basename(pickedImage!.path);
//       File imageFile = File(pickedImage.path);

//       try {
//         if (tipo.trim() == "Videos") {
//           await storage
//               .ref()
//               .child(tematica)
//               .child('Videos')
//               .child(titulo)
//               .putFile(
//                   imageFile,
//                   SettableMetadata(customMetadata: {
//                     'uploaded_by': titulo,
//                     'description': descripcion
//                   }));
//         } else {
//           await storage
//               .ref()
//               .child(tematica)
//               .child('File')
//               .child(titulo)
//               .putFile(
//                   imageFile,
//                   SettableMetadata(customMetadata: {
//                     'uploaded_by': titulo,
//                     'description': descripcion
//                   }));
//         }
//       } on FirebaseException catch (error) {
//         if (kDebugMode) {
//           print(error);
//         }
//       }
//     } catch (err) {
//       if (kDebugMode) {
//         print(err);
//       }
//     }

// FilePickerResult? result = await FilePicker.platform.pickFiles();
// final storageRef = FirebaseStorage.instance.ref();
// final mountainsRef = storageRef.child("mountains.jpg");

// if (result != null) {
//   Uint8List? fileBytes = result.files.first.bytes;
//   String fileName = result.files.first.name;

//   // Upload file

//                await FirebaseStorage.instance.ref().child("path");

}
