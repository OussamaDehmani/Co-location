
import 'package:co_location/pages/Auth/Register.dart';
import 'package:co_location/pages/Auth/SignIn.dart';
import 'package:flutter/material.dart';

class Authentication extends StatefulWidget {
  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  bool showSingin=true; 
  void toggleView(){
    setState(() {
      showSingin = !showSingin;
    });
}
  @override
  Widget build(BuildContext context) {
      if(showSingin){
      return SignIn(toggleView: toggleView);
    }else{
      return Register(toggleView: toggleView);
    }
  }
}