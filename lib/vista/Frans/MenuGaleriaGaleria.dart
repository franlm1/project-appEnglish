import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tuttorial_1/menu/animation_route.dart';


import 'MenuGaleria.dart';

class GaleriaGaleria extends StatefulWidget {
  final String modulo, unidad;
  const GaleriaGaleria( this.modulo, this.unidad);

  @override
  State<GaleriaGaleria> createState() => _GaleriaGaleriaState();
}

class _GaleriaGaleriaState extends State<GaleriaGaleria> {

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
                  Navigator.push(context, Animation_route(Galeria()))
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
                    
                    
                      
              
              ],
            ),
          ),
        ));
  }
}
