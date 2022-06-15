import 'dart:io';

import 'package:file_picker/file_picker.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:tuttorial_1/vista/MenuControlador.dart';
import '../../util/animation_route.dart';


class SelecFileToStorage extends StatefulWidget {
  const SelecFileToStorage({Key? key}) : super(key: key);

  @override
  State<SelecFileToStorage> createState() => _SelecFileToStorageState();
}

class _SelecFileToStorageState extends State<SelecFileToStorage> {

  final _formKey = GlobalKey<FormState>();
  final titulo = TextEditingController();
  final descripcion = TextEditingController();
  late String pickeFileName = "";
  String dropdownValue = 'Theme 1';
  PlatformFile? pickedFile;

  final List<String> itemsTheme = ['Theme 1', 'Theme 2', 'Theme 3', 'Theme 4'];

  Future uploadFile() async {
    if (pickedFile != null) {
      final path = dropdownValue + '/' + pickedFile!.name;
      final file = File(pickedFile!.path!);
      final ref = FirebaseStorage.instance.ref().child(path);
      ref.putFile(file);
      Navigator.push(context, Animation_route(MenuControlador()))
          .whenComplete(() => Navigator.of(context).pop());
    } else {
      setState(() {
        showMyDialog();
      });
    }
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;
    setState(() {
      pickedFile = result.files.first;
      pickeFileName = pickedFile!.name;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('SELECT FILE TO STORAGE'),
          automaticallyImplyLeading: false,
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
        body: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(50.0),
              child: ListView(
                children: [
                 
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
                        padding: const EdgeInsets.all(10.0),
                        child: Center(
                          child: Text(pickeFileName),
                        )),
                  )),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                            child: const Text('Select File'),
                            onPressed: selectFile),
                        ElevatedButton(
                          child: const Text('Upload File'),
                          onPressed: uploadFile,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )));
  }

  Widget dropButtonFormField() {
    return DropdownButtonFormField(
      value: 'Theme 1',
      icon: const Icon(Icons.arrow_downward, color: Colors.red),
      elevation: 20,
      style: const TextStyle(color: Colors.red),
      items: itemsTheme.map((itemsUnit) {
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
        } else if (pickedFile != null) {
          title = pickedFile!.name;
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

  Future<void> showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(''),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text(
                  'Select a file',
                  style:
                      TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                )
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.push(
                      context, Animation_route(const MenuControlador()))
                  .whenComplete(() => Navigator.of(context).pop()),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
