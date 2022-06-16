import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';

import '../../menu/animation_route.dart';
import '../../servicios/Uploat.dart';
import 'MenuControlador.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MenuMovil());
}

class MenuMovil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MENU CONTROLADOR',
      theme: ThemeData(
        primarySwatch: Colors.red,
        brightness: Brightness.light,
      ),
      home: Scaffold(
        body: MenuMovil_(),
        appBar: AppBar(
          title: Text('Mobile Menu'),
          actions: [
            InkWell(
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: Color.fromARGB(255, 210, 38, 38),
                ),
                onTap: () {
                  Navigator.push(context, Animation_route(MenuControlador()))
                      .whenComplete(() => Navigator.of(context).pop());
                }),
            const SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}

class MenuMovil_ extends StatefulWidget {
  
  @override
  State<MenuMovil_> createState() => _MenuMovil_State();
}

class _MenuMovil_State extends State<MenuMovil_> {

  FirebaseStorage storage = FirebaseStorage.instance;
  final List<String> itemsModulos = ['Modules 1', 'Modules 2', 'Modules 3', 'Modules 4'];
  final List<String> itemsUnit = ['Unit 1', 'Unit 2', 'Unit 3', 'Unit 4'];
  int? _selectedValueIndex = 1;
  final titulo = TextEditingController();
  final descripcion = TextEditingController();
  String dropdownValue = 'Unit 1';
  String tipo = "Videos";
  int selectedIndex = 0;
  int index = 0;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: button(index: 1, text: 'Videos'),
                ),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: button(index: 2, text: 'Files'),
                ),
              ],
            ),
            const Center(
              child: Padding(
                padding: EdgeInsets.all(30.0),
                child: Text(" Mobile Menu ",
                    style: TextStyle(fontSize: 30, color: Colors.red)),
              ),
            ),
            SizedBox(
              width: 400.0,
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: textFormFiel(titulo, 'Title')),
            ),
            SizedBox(
                child: Container(
              width: 400.0,
              child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: textFormFiel(descripcion, 'Description')),
            )),
            SizedBox(
                child: Container(
              width: 400.0,
              child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: dropButtonFormField()),
            )),
            SizedBox(
                child: Container(
              width: 400.0,
              child: Padding(
                  padding: const EdgeInsets.all(10.0), child: elevatedButton()),
            )),
          ]),
    );
  }

  Widget button({required String text, required int index}) {
    return InkWell(
      splashColor: Colors.cyanAccent,
      onTap: () {
        setState(() {
          _selectedValueIndex = index;
          if (index == 1) {
            tipo = "Videos";
          } else {
            tipo = "Archivos";
          }
        });
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        color: index == _selectedValueIndex ? Colors.red : Colors.white,
        child: Text(
          text,
          style: TextStyle(
            color: index == _selectedValueIndex ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }

  Widget dropButtonFormField() {
    return DropdownButtonFormField(
      value: 'Unit 1',
      icon: const Icon(Icons.arrow_downward, color: Colors.red),
      elevation: 20,
      style: const TextStyle(color: Colors.red),
      items: itemsUnit.map((itemsUnit) {
        return DropdownMenuItem(
          value: itemsUnit,
          child: Text(itemsUnit),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
        });
      },
    );
  }

  Widget textFormFiel(TextEditingController titulo, String title) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
      controller: titulo,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
          hintText: title,
          hintStyle: const TextStyle(fontSize: 20),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          )),
    );
  }

  Widget elevatedButton() {
    return ElevatedButton.icon(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Processing Data')),
          );
          UploatImagen(dropdownValue,titulo.text, descripcion.text,tipo).upload();
          Navigator.push(context, Animation_route(MenuMovil()))
                      .whenComplete(() => Navigator.of(context).pop());

        }
         setState((){});
          titulo.clear();
          descripcion.clear();
        
        
        
      }, 
      icon: const Icon(Icons.library_add),
       label: const Text('Gallery')
    );
  }
}
//firebase storage
