import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import '../menu/animation_route.dart';
import '../menu/menu_lateral.dart';
import 'card_foto.dart';

void main() => runApp(AddTask());

class AddTask extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Registrar',
        theme: ThemeData(
          //Se indica que el tema tiene un brillo luminoso/claro
          brightness: Brightness.light,
          primarySwatch: Colors.pink,
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.pink,
        ),
        home: HomePage(title: 'Registrar'),
        routes: <String, WidgetBuilder>{});
  }
}

class HomePage extends StatelessWidget {
  final String title;
  HomePage({Key? key, required this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
          actions: [
            InkWell(
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: Color(0xffffffff),
                ),
                onTap: () {
                  Navigator.push(context, Animation_route(MyApp()))
                      .whenComplete(() => Navigator.of(context).pop());
                }),
            const SizedBox(width: 10),
          ],
        ),
        body: UserForm(),
        drawer: MenuLateral());
  }
}

class UserForm extends StatefulWidget {
  @override
  UserFormState createState() {
    return UserFormState();
  }
}
   // TODO: MENU PRINCIPAL
class UserFormState extends State<UserForm> {
  //ATRIBUTOS

  List<String> spinnerCurso = ['Curso 1', 'Curso 2', 'Curso 3', 'Curso 4'];
  List<String> spinnerModulo = ['Modulo 1', 'Modulo 2', 'Modulo 3', 'Modulo 4'];
  late String dropdownValueCurso, dropdownValueModulo;
  var descripcionVideo = TextEditingController();
  var descripcionDoc = TextEditingController();


  @override
  void initState() {
    dropdownValueCurso = spinnerCurso[0];
    dropdownValueModulo = spinnerModulo[0];
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
 

    return Form(
      key: _formKey,
      child: ListView(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 3.0, horizontal: 10.0),
            child: CardFotos(),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 3.0, horizontal: 50.0),
            child: dropCurso(),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 3.0, horizontal: 50.0),
            child: dropModulo(),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 3.0, horizontal: 50.0),
            child: descripcionesVideo(),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 3.0, horizontal: 50.0),
            child: registrar(),
          ),
        ],
      ),
    );
  }

  // SPINNER DEL CURSO
  Widget dropCurso() {
    return DropdownButton<String>(
        value: dropdownValueCurso,
        icon: const Icon(Icons.arrow_drop_down),
        iconSize: 24,
        elevation: 16,
        style: const TextStyle(color: Colors.red, fontSize: 18),
        underline: Container(
          height: 2,
          color: Colors.pink,
        ),
        items: spinnerCurso.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (String? data) {
          setState(() {
            dropdownValueCurso = data!;
          });
        });
  }

  //SPINNER DEL MODULO

  Widget dropModulo() {
    return DropdownButton<String>(
        value: dropdownValueModulo,
        icon: const Icon(Icons.arrow_drop_down),
        iconSize: 24,
        elevation: 16,
        style: const TextStyle(color: Colors.red, fontSize: 18),
        underline: Container(
          height: 2,
          color: Colors.pink,
        ),
        items: spinnerModulo.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (String? data) {
          setState(() {
            dropdownValueModulo = data!;
          });
        });
  }

  //WIDGET TEXTO DESCRIPCION

  Widget descripcionesVideo() {
    return TextFormField(
      keyboardType: TextInputType.text,
      style: const TextStyle(fontSize: 20.0),
      decoration: InputDecoration(
        labelText: "Descripcion Video",
        fillColor: Colors.white,
        prefixIcon: const Icon(Icons.person),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: const BorderSide(),
        ),
      ),
      // ignore: missing_return
      validator: (value) {
        if (value!.isEmpty) {
          return 'Por favor ingrese una descripcion ';
        }
      },
      controller: descripcionVideo,
    );
  }

  //WIDGET BOTON REGISTRAR

  Widget registrar() {
    return MaterialButton(
      minWidth: 200.0,
      height: 60.0,
      onPressed: () {
         if (_formKey.currentState!.validate()){
                  registrarTask(context);
                }
        ;
      },
      color: Colors.black38,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: setUpButtonChild(),
    );
  }

  //BOTON CIRCULAR PROGRESION
  int _state = 0;
  Widget setUpButtonChild() {
    if (_state == 0) {
      return const Text(
        "Registrar",
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      );
    } else if (_state == 1) {
      return const CircularProgressIndicator(
        valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
      );
    } else {
      return const Text(
        "Registrar",
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      );
    }
  }



  //FUNCION REGISTRAR

  registrarTask(BuildContext context) async {
    int i = 1;
    List<File> _image = [];
    final _auth = FirebaseAuth.instance;
    final storage = FirebaseStorage.instance;
    final _db = FirebaseFirestore.instance;
    var video = CardFoto.croppedFileVideo;
    var documento = CardFoto.croppedFileDoc;


    _image.add(video!);
    _image.add(documento!);

    for (var img in _image) {
       storage.ref().child("uno").child("2").child(descripcionVideo.text).putFile(img);
    }
  


    
   // final videos = CardFoto.croppedFileVideo != null ?  CardFoto.croppedFileVideo : 
   
   /* UploadTask task = storage.ref().child("uno").child("2").child(descripcion.text).putFile(video!);
    task.whenComplete(() async {
      print("ddd");
    });

    if (video != null) {
      setState(() {
        if (_state == 0) {
          animateButton();
        }
      });
      // INSERTA STORAGE

       task.whenComplete(() async {
        TaskSnapshot storageTaskSnapshot = task.snapshot;
        String imgUrl = await storageTaskSnapshot.ref.getDownloadURL();
        DocumentReference ref = _db.collection('Users').doc(email.text);
        ref.set({
          'Name': name.text,
          'LastName': lastname.text,
          'Emoji': '$_currentEmoji',
          'Image': '$imgUrl'
        }).then((value) {
          Navigator.push(context, Animation_route(HomePageMain()))
              .whenComplete(() => Navigator.of(context).pop());
        });
      });
    }
  }

  //ANIMATE BOTON

 void animateButton() {
    setState(() {
      _state = 1;
    });
    Timer(const Duration(seconds: 5), () {
      setState(() {
        _state = 2;
      });
    });*/
  }
}
