import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:co_location/pages/add_location.dart';
import 'package:flutter/material.dart';
import 'package:co_location/services/auth.dart';
import 'package:co_location/services/database.dart';
import 'package:provider/provider.dart';
import 'package:co_location/Models/location.dart';
import 'package:co_location/pages/cardLocation.dart';
import 'package:provider/provider.dart';



class locations_List extends StatefulWidget {
  @override
  _locations_ListState createState() => _locations_ListState();
}

class _locations_ListState extends State<locations_List> {
  @override
  Widget build(BuildContext context) {

    final locationsData = Provider.of<List<Location>>(context) ?? [];
    return ListView.builder(
        itemCount: locationsData.length,
        itemBuilder: (context,index) {
          return myCard(loc: locationsData[index]);
        }
    );

  }



}


