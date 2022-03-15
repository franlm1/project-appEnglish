import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Users',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.pink,
        brightness: Brightness.light,
      ),
      home: Text("sdf"),
      routes: <String, WidgetBuilder>{},
    );
  }
}

class HomePageMain extends StatefulWidget {
  @override
  _SearchListState createState() => new _SearchListState();
}

class _SearchListState extends State<HomePageMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(



    );
  }
}
