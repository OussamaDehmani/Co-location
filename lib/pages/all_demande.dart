//import 'dart:js';
import 'package:co_location/Models/demande.dart';
import 'package:co_location/pages/add_demande.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:co_location/pages/add_location.dart';
import 'package:flutter/material.dart';
import 'package:co_location/services/auth.dart';
import 'package:co_location/services/database.dart';
import 'package:provider/provider.dart';
import 'package:co_location/pages/locationList.dart';
import 'package:co_location/Models/location.dart';
import 'package:co_location/pages/demandeList.dart';

class AllDemande extends StatelessWidget {
  final AuthService _auth=AuthService();
  final DatabaseService db= DatabaseService();

  @override
  Widget build(BuildContext context) {

    return StreamProvider<List<Demande>>.value(
      value: DatabaseService().Demandes,
      child: Scaffold(
        backgroundColor: Colors.brown[100],
        appBar: AppBar(
          backgroundColor: Colors.brown[400],
          elevation:0.0,

          actions:<Widget> [
            FlatButton.icon(onPressed: () async{ await _auth.logout();}, icon: Icon(Icons.power_settings_new), label: Text('')),

          ],

        ),
        body: Container(child: Demandes_List()),

        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.indigo,
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DemandeLoc()),
              );
            }

        ),
      ),
    );
  }

}

