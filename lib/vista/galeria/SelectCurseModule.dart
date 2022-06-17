// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tuttorial_1/vista/MenuControlador.dart';
import '../../util/animation_route.dart';
import 'MenuGaleriaGaleria.dart';
import 'package:restart_app/restart_app.dart';
class SelectCourseModule extends StatefulWidget {
  final String cursoStudent;
  late  bool studen;


SelectCourseModule(this.cursoStudent, this.studen );

  @override
  State<SelectCourseModule> createState() => _SelectCourseModuleState();
}

class _SelectCourseModuleState extends State<SelectCourseModule> {

  final List<String> itemsModulos = ['Module 1','Module 2','Module 3','Module 4','Module 5','Module 6','Module 7'];
  final List<String> itemsCourse = ['Course 1', 'Course 2', 'Course 3', 'Course 4'];
  

  String dropdownValueCourse = 'Course 1';
  String dropdownValueModule = 'Module 1';
  @override
  void initState() {
    if(widget.studen==false){
        save();
    }
      
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('SELECT COURSE Y MODULE'),
          automaticallyImplyLeading: false,
          actions: [
            InkWell(
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
                onTap: () {
                  if(widget.studen!=false){
                        Navigator.push(context, Animation_route(MenuControlador()))
                      .whenComplete(() => Navigator.of(context).pop());
                  }
                
                }),
            const SizedBox(width: 10),
          ],
        ),
        body:Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
              
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
                      child:   Visibility(
                  visible: widget.studen, // bool
                  child: dropButtonFormFieldCourse() , // widget to show/hide
                ),),
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
                  SizedBox(
                    child: Container(
                  width: 400.0,
                  child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Visibility(
                  visible: widget.studen ? widget.studen :true, // bool
                  child: ElevatedButton.icon(
                    onPressed: (){
                    SystemNavigator.pop();
                    }, 
                    icon: const Icon(Icons.exit_to_app),
                   label: const Text('EXIT')), // widget to show/hide
                ),),
                )),
              ]),
        );
        
         
  }
  Widget dropButtonFormFieldCourse() {
    return DropdownButtonFormField(
      value: 'Course 1',
      icon: const Icon(Icons.arrow_downward, color: Colors.red),
      elevation: 20,
      style: const TextStyle(color: Colors.red),
      items: itemsCourse.map((itemsUnit) {
        return DropdownMenuItem(
          value: itemsUnit,
          child: Text(itemsUnit),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValueCourse = newValue!;
        });
      },
    );
  }

  Widget dropButtonFormFieldModel() {
    return DropdownButtonFormField(
      value: 'Module 1',
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
             Navigator.push(context, Animation_route(MenuGaleriaGaleria(dropdownValueCourse,dropdownValueModule,widget.studen)))
                        .whenComplete(() => Navigator.of(context).pop());
        },
        icon: const Icon(Icons.library_add),
        label: const Text('SELECT'));
  }
    Future<void> save() async {
    // Obtain shared preferences.
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('student', widget.studen);
        await prefs.setString('course', widget.cursoStudent);
        
        widget.studen= prefs.getBool('student')!;
        dropdownValueCourse = prefs.getString('course')!;
    }
      

}