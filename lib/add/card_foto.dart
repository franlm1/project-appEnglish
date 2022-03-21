import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

import 'ImagePickerHandler.dart';

class CardFotos extends StatefulWidget {
  @override
  CardFoto createState() {
    return CardFoto();
  }
}

class CardFoto extends State<CardFotos> with ImagePickerListener {
  late ImagePickerHandler imagePicker;
  static File? croppedFileVideo, croppedFileDoc;
  late VideoPlayerController controller;
  late Future<void> _initializeVideoPlayerFuture;
  //late Future<void> _initializeDoc;
  @override
  void initState() {
    super.initState();
    imagePicker = ImagePickerHandler(this);
    //croppedFileVideo = null;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  // TODO: MENU PRINCIPAL
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        //CARD VIDEO
        Card(
          elevation: 5,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          child: InkWell(
            child: Container(
              height: 100,
              width: 200,
              child: showImageVideo(),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlatButton(
                child: Text("Galeria Video"),
                color: Colors.white10,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0)),
                onPressed: () {
                  imagePicker.pickImageFromGalleryVideo();
                }),
          ],
        ),
        // CARD DOCUMENTO
        Card(
          elevation: 5,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          child: InkWell(
              child: Container(
            height: 100,
            width: 200,
            child: showImageDoc(),
          )),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlatButton(
                child: const Text("Galeria Documento"),
                color: Colors.white10,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0)),
                onPressed: () {
                  imagePicker.pickImageFromGalleryDoc();
                }),
          ],
        ),
      ],
    );
  }

  // WIDGET VIDEO
  Widget showImageVideo() {
    if (croppedFileVideo != null) {
      return FutureBuilder(
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
      );
    } else {
      return const Image(image: AssetImage('assets/english.png'));
    }
  }
  // WIDGET DOCUMENTO 
  Widget showImageDoc() {
    if (croppedFileDoc != null) {
      return Image(image: FileImage(croppedFileDoc!));
    } else {
      return const Image(image: AssetImage('assets/english.png'));
    }
  }
  
  //METODOS ABSTRACTOR
  @override
  userImageVideo(File _image) {
    croppedFileVideo = _image;
    controller = VideoPlayerController.file(croppedFileVideo!);
    _initializeVideoPlayerFuture = controller.initialize();
    controller.setLooping(true);
    setState(() {});
  }
  @override
  userImageDoc(File _image) {
    croppedFileDoc = _image;
    setState(() {});
  }
}
