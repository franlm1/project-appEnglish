import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:tuttorial_1/servicios/loadImages.dart';
import 'package:tuttorial_1/vista/galeria/SelectCurseModule.dart';
import 'package:tuttorial_1/vista/media/MediaPdf.dart';
import 'package:tuttorial_1/vista/media/MediaPlayer.dart';


import 'package:tuttorial_1/vista/anadir-contenido/MenuThemeSelectFileFromStorage.dart';
import 'package:video_player/video_player.dart';


import '../../util/animation_route.dart';
import '../media/MediaImage.dart';


class MenuGaleriaGaleria extends StatefulWidget {
  final String curso;
  final String modulo;

  MenuGaleriaGaleria(this.curso, this.modulo);
  @override
  State<MenuGaleriaGaleria> createState() => MenuGaleriaGaleriaState();
}

class MenuGaleriaGaleriaState extends State<MenuGaleriaGaleria> {
  CollectionReference users = FirebaseFirestore.instance.collection('Modulos');
  late CollectionReference mainCollection;
  late VideoPlayerController controller;
  late Future<void> _initializeVideoPlayerFuture;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('STORAGE GALLERY MENU'),
          automaticallyImplyLeading: false,
          actions: [
            InkWell(
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
                onTap: () {
                  Navigator.push(context, Animation_route(SelectCourseModule()))
                      .whenComplete(() => Navigator.of(context).pop());
                }),
            const SizedBox(width: 10),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(5),
          child: Container(
            child: Column(
              children: [
                Expanded(
                  child: FutureBuilder(
                    future: loadGallery(widget.curso),
                    builder: (context,
                        AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            final Map<String, dynamic> image =
                                snapshot.data![index];

                            controller =
                                VideoPlayerController.network(image['url']);
                            _initializeVideoPlayerFuture =
                                controller.initialize();
                            controller.setLooping(true);

                            return Center(
                              child: Container(
                                height: 100,
                                child: Card(
                                  semanticContainer: true,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(30.0)),
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ListTile(
                                          dense: false,
                                          leading: showImageVideo(image['url']),
                                          title: Text(image['name']),
                                          trailing: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              IconButton(
                                                onPressed: () {
                                                  if (image['url'].contains('mp4')){
                                                    Navigator.push(context,Animation_route(MediaPlayer(image['url']))).whenComplete(() =>Navigator.of(context).pop());
                                                  } else if (image['url'].contains('jpg') ||image['url'].contains('png')){ 
                                                    Navigator.push(context,Animation_route(MediaImage(image['url']))).whenComplete(() =>Navigator.of(context).pop());
                                                  } else if (image['url'].contains('pdf')){
                                                    Navigator.push(context,Animation_route(MediaPdf(image['url']))).whenComplete(() =>Navigator.of(context).pop());
                                                  }
                                                },
                                                icon: const Icon(
                                                  Icons.arrow_right_alt_sharp,
                                                  color: Colors.red,
                                                ),
                                              ),
                                              IconButton(
                                                onPressed: () {
                                        	            deleteField(image['id'],widget.modulo);
		                                                  setState(() {});
                                                },
                                                icon: const Icon(
                                                  Icons.delete,
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else {
                        print('error');
                        return Text('error');
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Future<void> deleteField(String idArchivo,String module) {
    return users
        .doc(module)
        .update({idArchivo: FieldValue.delete()})
        .then((value) => print("User's Property Deleted"))
        .catchError(
            (error) => print("Failed to delete user's property: $error"));
  }

  Widget showImageVideo(String url) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 200.0,
        width: 50.0,
        child: url.contains('pdf')
            ? Image(image: AssetImage('assets/english.png'))
            : url.contains('mp4')
                ? VideoPlayer(controller)
                : Image.network(url),
      ),
    );
  }

   Future<List<Map<String, dynamic>>> loadGallery(String curso) async {
    List<Map<String, dynamic>> files = [];
    final docRef = firestore.collection("Modulos").doc(widget.modulo);
      docRef.get().then((DocumentSnapshot doc) {
      final data = doc.data() as Map<String, dynamic>;
      data.forEach((key, value) {
        for (var element in value) {
          if (element["idCurso"] == curso) {
            files.add({
              'id': key,
              "idCurso": element["idCurso"],
              "name": element["name"],
              "idModulo": element["name"],
              "url": element["url"],
            });
          }
        }
      });
    });




    
    
    

    return files;
  }
}
