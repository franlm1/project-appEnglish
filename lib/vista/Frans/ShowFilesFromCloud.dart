import 'package:flutter/material.dart';


import '../../menu/animation_route.dart';
import 'MenuControlador.dart';

class ShowFileFromCloud extends StatefulWidget {
  const ShowFileFromCloud({ Key? key }) : super(key: key);

  @override
  State<ShowFileFromCloud> createState() => _ShowFileFromCloudState();
}

class _ShowFileFromCloudState extends State<ShowFileFromCloud> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Form file from storage'),
          automaticallyImplyLeading: false,
          actions: [
            InkWell(
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
                onTap: () {
                  Navigator.push(
                          context, Animation_route(const MenuControlador()))
                      .whenComplete(() => Navigator.of(context).pop());
                }),
            const SizedBox(width: 10),
          ],
        ),
        body:Text('data') ,
        //TODO --------------------------------
    );
    
  }
}