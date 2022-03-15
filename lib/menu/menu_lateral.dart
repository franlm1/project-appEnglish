import 'package:flutter/material.dart';

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
        children: const [
          DrawerHeader(
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
            ) ,
            ),
        ],
      ),

    );
  }
}
