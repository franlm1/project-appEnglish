import 'package:flutter/material.dart';

import '../menu/animation_route.dart';
import 'MenuControlador.dart';
import 'MenuGaleriaGaleria.dart';

class Galeria extends StatelessWidget {
  const Galeria({Key? key}) : super(key: key);

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
        body: Galeria_(),
        appBar: AppBar(
          title: Text('añadimos archivo a la bd firestore '),
          actions: [
            InkWell(
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
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

class Galeria_ extends StatefulWidget {
  const Galeria_({Key? key}) : super(key: key);

  @override
  State<Galeria_> createState() => _Galeria_State();
}

class _Galeria_State extends State<Galeria_> {
  int? _selectedValueIndex = 1;
  final List<String> itemsModulos = ['Modules 1','Modules 2','Modules 3','Modules 4'];
  final List<String> itemsUnit = ['Course 1', 'Course 2', 'Course 3', 'Course 4'];

  String dropdownValueUnit = 'Course 1';
  String dropdownValueModule = 'Modules 1';
   String tipo = "Videos";
  int selectedIndex = 0;
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Form(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("seleccionamos el tipo y el curso donde queremos que se asigne"),
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
                    child: Text(" ",
                        style: TextStyle(fontSize: 30, color: Colors.red)),
                  ),
                ),
                SizedBox(
                    child: Container(
                  width: 400.0,
                  child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: dropButtonFormFieldUnit()),
                )),
                SizedBox(
                    child: Container(
                  width: 400.0,
                  child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: dropButtonFormFieldModel()),
                )),
                SizedBox(
                    child: Container(
                  width: 400.0,
                  child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: elevatedButton()),
                )),
              ]),
        );
  }

  Widget dropButtonFormFieldUnit() {
    return DropdownButtonFormField(
      value: 'Course 1',
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
          dropdownValueUnit = newValue!;
        });
      },
    );
  }

  Widget dropButtonFormFieldModel() {
    return DropdownButtonFormField(
      value: 'Modules 1',
      icon: const Icon(Icons.arrow_downward, color: Colors.red),
      elevation: 20,
      style: const TextStyle(color: Colors.red),
      items: itemsModulos.map((itemsModulos) {
        return DropdownMenuItem(
          value: itemsModulos,
          child: Text(itemsModulos),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValueModule = newValue!;
        });
      },
    );
  }

  Widget elevatedButton() {
    return ElevatedButton.icon(
        onPressed: () {
             Navigator.push(context, Animation_route(MenuGaleriaGaleria()))
                        .whenComplete(() => Navigator.of(context).pop());
        },
        icon: const Icon(Icons.library_add),
        label: const Text('Selecciona en store'));
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
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('It was add correctly')
            
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Approve'),
              onPressed: () {
                //  Navigator.push(context, Animation_route(const MenuControlador()))
                //       .whenComplete(() => Navigator.of(context).pop());
              },
            ),
          ],
        );
      },
    );
  }

}

 