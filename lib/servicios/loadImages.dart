import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadImagen {
  
  late String theme;
  late ListResult result;
  FirebaseStorage storage = FirebaseStorage.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  LoadImagen(this.theme); //--
  LoadImagen.c();
  
  Future<List<Map<String, dynamic>>> loadImages() async {
    List<Map<String, dynamic>> files = [];
    result = await storage.ref().child(this.theme).list();
    final List<Reference> allFiles = result.items;
    await Future.forEach<Reference>(allFiles, (file) async {
      final String name = await file.name;
      final String fileUrl = await file.getDownloadURL();

      files.add({
        "url": fileUrl,
        "path": file.fullPath,
        "uploaded_by": name
      });
    });

    return files;
  }



  Future<List<Map<String, dynamic>>> loadImagesFromFirestdorie() async {
    List<Map<String, dynamic>> files = [];
    final docRef = firestore.collection("Modulos").doc("Modules 1_Course 1");
    docRef.get().then((DocumentSnapshot doc) {
      final data = doc.data() as Map<String, dynamic>;
      data.forEach((key, value) {
        for (var element in value) {
          files.add({
            "url": element["url"],
            "titulo": element["titulo"],
            "tipo": key,
            "descripcion": element["descripcion"],
          });
        }
      });
    });
    return files;
  }

//  final docRef = firestore.collection("Modulos").doc("Modules 1_Course 1");
//     docRef.get().then(
//       (DocumentSnapshot doc) {
//         final data = doc.data() as Map<String, dynamic>;
//         data.forEach((key, value) {
//           for (var element in value) {
//             print(element["tipo"]);

}
