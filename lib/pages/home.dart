//import 'dart:js';
import 'package:co_location/pages/add_demande.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:co_location/pages/add_location.dart';
import 'package:flutter/material.dart';
import 'package:co_location/services/auth.dart';
import 'package:co_location/services/database.dart';
import 'package:provider/provider.dart';
import 'package:co_location/pages/add_demande.dart';
import 'package:co_location/pages/locationList.dart';
import 'package:co_location/pages/all_demande.dart';
import 'package:co_location/Models/location.dart';

class Home extends StatelessWidget {
  final AuthService _auth=AuthService();
  final DatabaseService db= DatabaseService();

  @override
  Widget build(BuildContext context) {

    return StreamProvider<List<Location>>.value(
      value: DatabaseService().locations,
      child: Scaffold(
        backgroundColor: Colors.brown[100],
        appBar: AppBar(
          backgroundColor: Colors.brown[400],
          elevation:0.0,
          title: (FlatButton.icon(onPressed: () {
            Navigator.push(context,MaterialPageRoute(builder: (context) => AllDemande()));
            },
              icon: Icon(Icons.account_balance), label: Text(''))
            ),
          actions:<Widget> [
            FlatButton.icon(onPressed: () async{ await _auth.logout();}, icon: Icon(Icons.power_settings_new), label: Text('')),

          ],

        ),
        body: Container(child: locations_List()),
        
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.indigo,
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Addlocation()),
            );
          }

        ),
      ),
    );
  }

}

