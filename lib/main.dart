import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
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
      home: WelcomeScreen(),
      routes:{
        'welcome_screen': (context) => WelcomeScreen(),
        // 'registration_screen': (context) =>RegistrationScreen(),
        // 'login_screen': (context) => LoginScreen(),
        // 'home_screen': (context) => HomeScreen()
      },
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
      body: ListUser(),
    );
  }
}
