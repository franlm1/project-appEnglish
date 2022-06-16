
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tuttorial_1/vista/MenuControlador.dart';
import 'package:firebase_core/firebase_core.dart';
import '../../util/animation_route.dart';
import 'MenuThemeSelectFileFromStorage.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
}

class Modules {
  static String name = 'Module 1';
  static String nameCourse = 'Course 1';


}

class FormFileFromStorage extends StatefulWidget {
  final String nameFile;
  final String url;
  
  FormFileFromStorage(this.nameFile, this.url);



  @override
  State<FormFileFromStorage> createState() => _MenuMovil_State();
}

class _MenuMovil_State extends State<FormFileFromStorage> {
  
  FirebaseFirestore firestore = FirebaseFirestore.instance;


  final List<String> itemsCourse = [
    'Course 1',
    'Course 2',
    'Course 3',
    'Course 4'
  ];

  final List<String> itemsModule = [
    'Module 1',
    'Module 2',
    'Module 3',
    'Module 4',
    'Module 5',
    'Module 7'
  
  ];

  
  Widget dropButtonModule() {
    return DropdownButtonFormField(

      icon: const Icon(Icons.arrow_downward, color: Colors.red),
      elevation: 20,
      style: const TextStyle(color: Colors.red),
      hint:Text( Modules.name,style:TextStyle(color: Colors.red)),
      items: itemsModule.map((itemsModule) {
        return DropdownMenuItem(
          value: itemsModule,
          child: Text(itemsModule),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          Modules.name = newValue!;
        });
      },
    );
  }
  

  Widget dropButtonCourse() {
    return DropdownButtonFormField(
      
      icon: const Icon(Icons.arrow_downward, color: Colors.red),
      hint: Text(Modules.nameCourse,style: TextStyle(color: Colors.red),),
      elevation: 20,
      style: const TextStyle(color: Colors.red),
      items: itemsCourse.map((itemsCourse) {
        return DropdownMenuItem(
          value: itemsCourse,
          child: Text(itemsCourse),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          Modules.nameCourse = newValue!;
        });
      },
    );
  }

  Widget elevatedButton() {
    return ElevatedButton.icon(
        onPressed: () {
          try {
          
            uploadFile();
            save();
          } catch (e) {}
        },
        icon: const Icon(Icons.library_add),
        label: const Text('Gallery'));
  }

  Future uploadFile() async {
      if (widget.nameFile != "Select a file") {
        final file = <String, dynamic>{
          'url': widget.url,
          'name': widget.nameFile,
          'idCurso':Modules.nameCourse,
          'idModulo':Modules.name

        };

        
    
        try {
            DocumentReference documentCurso = firestore.collection('Cursos').doc(Modules.nameCourse);
            documentCurso.set({'idModule':Modules.name}).whenComplete(() => null);
            DocumentReference documentArchivo = firestore.collection('Archivos').doc();
            documentArchivo.set({'url': widget.url, 'name': widget.nameFile,'idModulo':Modules.name}).whenComplete(() { 
              DocumentReference documentModulo = firestore.collection('Modulos').doc(Modules.name);
              documentModulo.set({documentArchivo.id:FieldValue.arrayUnion([file])},SetOptions(merge: true)).whenComplete(() { });
            });

            

            Navigator.push(
                      context, Animation_route(const MenuControlador()))
                  .whenComplete(() => Navigator.of(context).pop());
          
        } catch (err) {
          
        } 
    }else{
      showMyDialog();
    }
  }

  Future<void> save() async {
    // Obtain shared preferences.
   final prefs = await SharedPreferences.getInstance();
   await prefs.setString('module', Modules.name);
   await prefs.setString('course', Modules.nameCourse);
  
       final String? action = prefs.getString('module');
       final String? actionCourse = prefs.getString('module');
       if(action != null && actionCourse != null){
        Modules.name=action;
        Modules.nameCourse=actionCourse;

   }
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
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            child: Center(
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                SizedBox(
                    child: Container(
                  width: 400.0,
                  child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: dropButtonCourse()),
                )),
                SizedBox(
                    child: Container(
                  width: 400.0,
                  child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: dropButtonModule()),
                )),
                SizedBox(
                  child: Container(
                      width: 400.0,
                      child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextField(
                            decoration: InputDecoration(
                                hintText: widget.nameFile,
                                hintStyle: const TextStyle(color: Colors.red),
                                suffixIcon: IconButton(
                                  icon: const Icon(
                                    Icons.add,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                            context,
                                            Animation_route(
                                                const MenuThemeSelectFileFromStorage()))
                                        .whenComplete(
                                            () => Navigator.of(context).pop());
                                  },
                                )),
                          ))),
                ),
                SizedBox(
                    child: Container(
                  width: 400.0,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ElevatedButton(
                      child: const Text('Upload File'),
                      onPressed: uploadFile,
                    ),
                  ),
                )),
              ]),
            ),
          ),
        ));
  }
}
