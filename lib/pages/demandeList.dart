import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:co_location/Models/demande.dart';
import 'package:co_location/pages/add_location.dart';
import 'package:flutter/material.dart';
import 'package:co_location/services/auth.dart';
import 'package:co_location/services/database.dart';
import 'package:provider/provider.dart';
import 'package:co_location/Models/location.dart';
import 'package:co_location/pages/cardDemande.dart';
import 'package:provider/provider.dart';



class Demandes_List extends StatefulWidget {
  @override
  _Demandes_ListState createState() => _Demandes_ListState();
}

class _Demandes_ListState extends State<Demandes_List> {
  @override
  Widget build(BuildContext context) {

    final demandesData = Provider.of<List<Demande>>(context) ?? [];
    return ListView.builder(
        itemCount: demandesData.length,
        itemBuilder: (context,index) {
          return myCard(dem: demandesData[index]);
        }
    );

  }



}


