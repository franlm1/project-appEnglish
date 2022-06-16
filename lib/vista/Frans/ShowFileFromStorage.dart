import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:tuttorial_1/servicios/loadImages.dart';

import 'package:video_player/video_player.dart';

import '../../menu/animation_route.dart';

import 'FormFileFromStorage.dart';
import 'MenuThemeSelectFileFromStorage.dart';

class ShowFileFromStorage extends StatefulWidget {
  final String theme;
  const ShowFileFromStorage(this.theme);
  @override
  State<ShowFileFromStorage> createState() => ShowFileFromStorageState();
}

class ShowFileFromStorageState extends State<ShowFileFromStorage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('SELECT YOUR FILE'),
          automaticallyImplyLeading: false,
          actions: [
            InkWell(
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
                onTap: () {
                  Navigator.push(context, Animation_route(MenuThemeSelectFileFromStorage()))
                      .whenComplete(() => Navigator.of(context).pop());
                }),
            const SizedBox(width: 10),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            child: Column(
              children: [
                Expanded(
                  child: FutureBuilder(
                    future: LoadImagen(widget.theme).loadImages(),
                    builder: (context,
                        AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                      return ListView.builder(
                        itemCount: snapshot.data?.length ?? 0,
                        itemBuilder: (context, index) {
                          final Map<String, dynamic> image =
                              snapshot.data![index];
                              
                          return Card(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: ListTile(
                              dense: false,
                              title: Text(image['uploaded_by']),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      
                                       Navigator.push(context, Animation_route(FormFileFromStorage(image['uploaded_by'],image['url'])))
                      .whenComplete(() => Navigator.of(context).pop());
                                    },
                                    icon: const Icon(
                                      Icons.add,
                                      color: Colors.red,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                    
                                      
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
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

  addItemToFirestoreCloud() {
    setState(() {});
  }

  // Widget dropButtonFormFieldModel() {
  //   return DropdownButtonFormField(
  //     value: 'Modules 1',
  //     icon: const Icon(Icons.arrow_downward, color: Colors.red),
  //     elevation: 20,
  //     style: const TextStyle(color: Colors.red),
  //     items: itemsModulos.map((itemsModulos) {
  //       return DropdownMenuItem(
  //         value: itemsModulos,
  //         child: Text(itemsModulos),
  //       );
  //     }).toList(),
  //     onChanged: (String? newValue) {
  //       setState(() {
  //         dropdownValueModule = newValue!;
  //       });
  //     },
  //   );
  // }
}
