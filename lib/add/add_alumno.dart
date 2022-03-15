import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tuttorial_1/main.dart';
import 'package:tuttorial_1/menu/menu_lateral.dart';

import '../menu/animation_route.dart';

void main() => runApp(AddAlumno());

class AddAlumno extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Registrar',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.pink,
        brightness: Brightness.light,
      ),
      home: const HomePage(title: 'Registrar'),
      routes: const <String, WidgetBuilder>{},
    );
  }
}

class HomePage extends StatelessWidget {
  final String title;

  const HomePage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
          actions: [
            InkWell(
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                ),
                onTap: () {
                  Navigator.push(context, Animation_route(MyApp()))
                      .whenComplete(() => Navigator.of(context).pop());
                }),
            SizedBox(width: 10),
          ],
        ),
        body: AlumnoForm(),
        drawer: MenuLateral());
  }
}

class AlumnoForm extends StatefulWidget {
  @override
  AlumnoFormState createState() => AlumnoFormState();
}

class AlumnoFormState extends State<AlumnoForm> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 3.0,horizontal: 10.0),
            child: Column(
              children: [
                Card( 
                  semanticContainer: true,
                  child: Image.network(
                  'https://scontent.falc1-1.fna.fbcdn.net/v/t1.18169-9/58675_334588940027861_6571281867888589763_n.png?_nc_cat=111&ccb=1-5&_nc_sid=09cbfe&_nc_ohc=yijQMh_P2tUAX-LfYtY&_nc_ht=scontent.falc1-1.fna&oh=00_AT8l5Kmk7i2FoW27Fvpp8B2aF4aivTFxcefk2mR3h8tpfA&oe=6257FF2E',
                  fit: BoxFit.fill,
                  
                ),
                elevation:0,
                margin: EdgeInsets.all(10),
                  ),
              ]), 
            ),
        ],
      ),
    );
  }
}
