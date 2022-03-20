
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import '../main.dart';
import '../menu/animation_route.dart';
import '../menu/menu_lateral.dart';
import 'card_foto.dart';

void main()=> runApp(AddTask());

class AddTask extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Registrar',
      theme: ThemeData(
        //Se indica que el tema tiene un brillo luminoso/claro
        brightness: Brightness.light,
        primarySwatch: Colors.pink,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.pink,
      ),
      home: HomePage(title: 'Registrar'),
        routes: <String, WidgetBuilder>{

        }
    );
  }

}
class HomePage extends StatelessWidget{
  final String title;
  HomePage({Key? key, required this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
          actions: [
            InkWell(
              child: Icon(Icons.arrow_back_ios,
                color: Color(0xffffffff),
              ),
                onTap: (){
                  Navigator.push(context,Animation_route (MyApp())).whenComplete(() => Navigator.of(context).pop());
                }
            ),
            SizedBox(width: 10),
          ],
        ),
        body: UserForm(),
        drawer: MenuLateral()
    );
  }

}
class UserForm extends StatefulWidget{
  @override
  UserFormState createState(){
    return UserFormState();
  }
}
class UserFormState extends State<UserForm>{
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Form(
      key: _formKey,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 3.0,horizontal: 10.0),
              child:CardFotos(),
            ),
          ],
        ),
    );
  }
  
}