
import 'package:co_location/Models/User.dart';
import 'package:co_location/pages/Auth/authentication.dart';
import 'package:co_location/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Mediator extends StatelessWidget {

    @override
  Widget build(BuildContext context) {
    final user=Provider.of<User>(context);
    if(user == null){
    return Authentication();
    }else{
    return Home();

    }
  }
}