import 'package:flutter/material.dart';
import '../../util/animation_route.dart';
import '../MenuControlador.dart';
import '../galeria/MenuGaleriaGaleria.dart';


class MediaImage extends StatefulWidget {
  late String url;
  MediaImage(this.url);
  

  @override
  State<MediaImage> createState() => _MediaImageState();
}

class _MediaImageState extends State<MediaImage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
          title: Text(''),
          automaticallyImplyLeading: false,
          actions: [
            InkWell(
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
                onTap: () {
                  Navigator.push(context,
                          Animation_route(MenuControlador()))
                      .whenComplete(() => Navigator.of(context).pop());
                }),
            const SizedBox(width: 10),
          ],
        ),
    body: new Image.network(widget.url,fit: BoxFit.cover,height: double.infinity,width: double.infinity,alignment: Alignment.center,),
    );
  }
}