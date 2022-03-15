import 'package:flutter/material.dart';
import 'package:tuttorial_1/add/add_alumno.dart';

import '../main.dart';
import 'animation_route.dart';

class MenuLateral extends StatefulWidget {
  @override
  Menu createState() => Menu();
}

class Menu extends State<MenuLateral> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children:  [
          const DrawerHeader(
            child: Text(
              "Alex",
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.black54,
              shape: BoxShape.rectangle,
            ),
          ),
          ListTile(
              leading: const Icon(
                Icons.home,
                color: Colors.black,
              ),
              title: const Text('Inicio'),
              onTap: () => Navigator.pop(context, Animation_route(MyApp()))
              ),  
        ListTile(
              leading: const Icon(
                Icons.person,
                color: Colors.black,
              ),
              title: const Text('Registrar'),
              onTap: () => Navigator.push(context, Animation_route(AddAlumno()))
              ),
        ],
      ),
    );
  }
}
