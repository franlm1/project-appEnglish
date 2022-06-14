import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_auth/firebase_auth.dart';      

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user object based on Firebase User
  User _userFromFirebaseUser(FirebaseUser user){
    return user != null ? User (uid: user.uid): null;
  }
//sign in with emmail as student


//sign out



}