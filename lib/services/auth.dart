import 'package:co_location/Models/User.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:flutter/material.dart';
import 'package:co_location/services/database.dart';

class AuthService{

  final FirebaseAuth _auth =FirebaseAuth.instance;
  Future signIn() async{

    try{
      AuthResult result= await _auth.signInAnonymously();
      FirebaseUser user= result.user;
      return user;

    }catch(e){
      print(e.toString());
      return null;

    }
  }



  /* register email && password */

  Future registerWithEmailAndPassword(String email,String password) async {
    try{
       AuthResult result =  await _auth.createUserWithEmailAndPassword(email: email, password: password);
       FirebaseUser user = result.user;



       return _userFromFirebaseUser(user);
    }catch(ex){
      print(ex);
      return null;

    }
  }




  User _userFromFirebaseUser(FirebaseUser user){
    return user != null ? User(uid: user.uid) : null;
  }

  Stream<User> get user{
    return _auth.onAuthStateChanged.map((FirebaseUser user) => _userFromFirebaseUser(user));
  }


  /* login email && password */

  Future signInWithEmailAndPassword(String email,String password) async {
    try{
      AuthResult result =  await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    }catch(ex){
      print(ex);
      return null;

    }
  }

/* logout */

  Future logout() async {
    try{
      return await _auth.signOut();
    }
    catch(ex){
      print(ex);
      return null;
    }
  }
}