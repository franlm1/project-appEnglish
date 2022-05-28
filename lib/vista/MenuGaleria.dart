import 'package:flutter/material.dart';

import '../menu/animation_route.dart';
import 'MenuControlador.dart';

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
          title: Text('Gallery'),
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

  final List<String> itemsModulos = ['Modules 1','Modules 2','Modules 3','Modules 4'];
  final List<String> itemsUnit = ['Unit 1', 'Unit 2', 'Unit 3', 'Unit 4'];

  String dropdownValueUnit = 'Unit 1';
  String dropdownValueModule = 'Modules 1';

  @override
  Widget build(BuildContext context) {
    return Form(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(30.0),
                    child: Text(" Gallery ",
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
         
        },
        icon: const Icon(Icons.library_add),
        label: const Text('Gallery'));
  }
}
