
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoadImagen {
  
  late String theme;
  late ListResult result;
  FirebaseStorage storage = FirebaseStorage.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  LoadImagen(this.theme); //--
  LoadImagen.c();
  
  Future<List<Map<String, dynamic>>> loadStorage() async {
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


  Future<List<Map<String, dynamic>>> loadCloud() async {
    List<Map<String, dynamic>> files = [];
    final docRef = firestore.collection("Modulos").doc("Module 1");
    docRef.get().then((DocumentSnapshot doc) {
      final data = doc.data() as Map<String, dynamic>;
      data.forEach((key, value) {
        for (var element in value) {
          files.add({
            'id':key,
            "idCurso": element["idCurso"],
            "name": element["name"],
            "idModulo": element["name"],
            "url": element["url"],
          });
        }
      });
   
    });
    
    return files;
  }

}
