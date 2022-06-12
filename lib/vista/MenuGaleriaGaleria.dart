import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:tuttorial_1/servicios/loadImages.dart';

import 'package:tuttorial_1/vista/MenuThemeSelectFileFromStorage.dart';
import 'package:video_player/video_player.dart';

import '../menu/animation_route.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MenuGaleriaGaleria());
}

class MenuGaleriaGaleria extends StatefulWidget {
  @override
  State<MenuGaleriaGaleria> createState() => MenuGaleriaGaleriaState();
}

class MenuGaleriaGaleriaState extends State<MenuGaleriaGaleria> {
  late CollectionReference mainCollection;
  late VideoPlayerController controller;
  late Future<void> _initializeVideoPlayerFuture;
  FirebaseStorage storage = FirebaseStorage.instance;

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
                  Navigator.push(context,
                          Animation_route(MenuThemeSelectFileFromStorage()))
                      .whenComplete(() => Navigator.of(context).pop());
                }),
            const SizedBox(width: 10),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(100),
          child: Container(
            width: 800,
            child: Column(
              children: [
                const Center(
                  child: Padding(
                      padding: EdgeInsets.all(30),
                      child: Text('STORAGE GALLERY MENU',
                          style: TextStyle(fontSize: 30, color: Colors.red))),
                ),
                Expanded(
                  child: FutureBuilder(
                    future: LoadImagen.c().loadImagesFromFirestdorie(),
                    builder: (context,
                        AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                      return ListView.builder(
                        itemCount: snapshot.data?.length ?? 0,
                        itemBuilder: (context, index) {
                          final Map<String, dynamic> image =
                              snapshot.data![index];
                          controller =
                              VideoPlayerController.network(image['url']);
                          _initializeVideoPlayerFuture =
                              controller.initialize();
                          controller.setLooping(true);
                          // print(image['url']);

                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(image['tipo']),
                                Card(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: ListTile(
                                    dense: false,
                                    //leading: Image.network(image['url']),
                                    leading: image['url'].contains('Video')
                                        ? showImageVideo()
                                        : Image.network(image['url']),
                                    title: Text(image['titulo']),
                                    subtitle: Text(image['descripcion']),
                                    trailing: IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.add,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget showImageVideo() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: 80,
        height: 100,
        child: FutureBuilder(
          future: _initializeVideoPlayerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return AspectRatio(
                aspectRatio: controller.value.aspectRatio,
                child: VideoPlayer(controller),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _button() => IconButton(
        onPressed: () {
          // Navigator.push(context, Animation_route(MenuCloud_()))
          //             .whenComplete(() => Navigator.of(context).pop());
        },
        icon: const Icon(
          Icons.add,
          color: Colors.red,
        ),
      );
}
