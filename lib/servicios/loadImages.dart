import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class LoadImagen {
  final String selectedValue;
  final String tipo;
  late ListResult result;
  FirebaseStorage storage = FirebaseStorage.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  LoadImagen(this.selectedValue, this.tipo);//--
  LoadImagen.c(this.selectedValue, this.tipo);
  Future<List<Map<String, dynamic>>> loadImages() async {
    List<Map<String, dynamic>> files = [];
      result = await storage.ref().child(selectedValue).child(tipo).list();
    final List<Reference> allFiles = result.items;
    await Future.forEach<Reference>(allFiles, (file) async {
      final String fileUrl = await file.getDownloadURL();
      final FullMetadata fileMeta = await file.getMetadata();
      files.add({
        "url": fileUrl,
        "path": file.fullPath,
        "uploaded_by": fileMeta.customMetadata?['uploaded_by'] ?? 'Nobody',
        "description":
            fileMeta.customMetadata?['description'] ?? 'No description',
      });
    });

    return files;
  }
  Future<List<Map<String, dynamic>>> loadImagesFromFirestore() async {
    List<Map<String, dynamic>> files = [];
      result = await storage.ref().child(selectedValue).child(tipo).list();
    final List<Reference> allFiles = result.items;
    await Future.forEach<Reference>(allFiles, (file) async {
      final String fileUrl = await file.getDownloadURL();
      final FullMetadata fileMeta = await file.getMetadata();
      files.add({
        "url": fileUrl,
        "path": file.fullPath,
        "uploaded_by": fileMeta.customMetadata?['uploaded_by'] ?? 'Nobody',
        "description":
            fileMeta.customMetadata?['description'] ?? 'No description',
      });
    });

    return files;
  }
  Future<void> getData() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await firestore.collection('collectionName').get();;

    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
  //for a specific field
  //  final allData = querySnapshot.docs.map((doc) => doc.get('fieldName')).toList();

    print(allData);
}

}
