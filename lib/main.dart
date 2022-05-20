import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tuttorial_1/add/add_task.dart';
import 'package:tuttorial_1/screens/login_screen_student.dart';
import 'screens/welcome_screen.dart';
// import 'home_screen.dart';
// import 'signup_screen.dart';
// import 'login_screen.dart';

import 'list/list_user.dart';

void  main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Users',
      theme: ThemeData(
        primarySwatch: Colors.red,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.red,
        brightness: Brightness.dark,
      ),
      home:WelcomeScreen(),
        routes: <String, WidgetBuilder>{},
      
    );
  }
}

class HomePageMain extends StatefulWidget {
  const HomePageMain({Key? key}) : super(key: key);

  @override
  _SearchListState createState() => _SearchListState();
}

class _SearchListState extends State<HomePageMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListUser(),
    );
  }
}
