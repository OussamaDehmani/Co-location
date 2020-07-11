import 'package:co_location/pages/all_demande.dart';
import 'package:co_location/pages/map_location.dart';
import 'package:flutter/material.dart';
import 'package:co_location/services/auth.dart';
import 'package:co_location/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:latlong/latlong.dart';

class DemandeLoc extends StatefulWidget {

  double latitude;
  double longtitude;
  DemandeLoc({this.latitude,this.longtitude});


  @override
  _DemandeLocState createState() => _DemandeLocState();
}

class _DemandeLocState extends State<DemandeLoc> {
  File _image;
  final AuthService _auth=AuthService();
  final DatabaseService db= DatabaseService();
  final _formkey = GlobalKey<FormState>();
  String nom;
  String phone;
  String budget;
  String commentaire;
  String nuid="";
  double lat;
  double long;
  String ville;
  String error="";
  String accountStatus = '******';
  FirebaseUser mCurrentUser;
  FirebaseAuth auth;

  @override
  void initState() {
    super.initState();
    auth = FirebaseAuth.instance;
    _getCurrentUser();

  }

  _getCurrentUser () async {
    mCurrentUser = await auth.currentUser();
    // print('********************************************************Hello ' + mCurrentUser.uid.toString());
    setState(() {
      if(mCurrentUser != null ) {nuid =  mCurrentUser.uid.toString() ;}
    });
  }


  @override
  Widget build(BuildContext context) {


    return Scaffold(
        backgroundColor: Colors.brown[100],
        appBar: AppBar(
          backgroundColor: Colors.brown[400],
          elevation:0.0,
          title: Text("Add Demande"),

        ),
        body:Builder(
          builder: (context) =>   Container(
            padding: EdgeInsets.symmetric(vertical:10.0,horizontal:30.0),
            child: Form(
                key: _formkey,
                child: ListView(
                  children: <Widget>[

                    SizedBox(height: 20.0),

                    TextFormField(

                        decoration: InputDecoration(
                          labelText: " Nom",
                          //border: InputBorder.none,
                          // hintText: 'Enter une adresse'
                        ),
                        validator: (val)=>val.isEmpty? ' Enter votre nom' : null,
                        onChanged:(val){
                          setState(()=>nom = val );
                        }
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                        decoration: InputDecoration(
                          labelText: " phone",
                        ),
                        validator: (val)=>val.isEmpty? ' Enter telephone' : null,
                        onChanged:(val){
                          setState(()=>phone = val );
                        }
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                        decoration: InputDecoration(
                          labelText: " Budget",
                        ),
                        validator: (val)=>val.isEmpty? ' Enter votre budget' : null,
                        onChanged:(val){
                          setState(()=>budget = val );
                        }
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                        decoration: InputDecoration(
                          labelText: " Description",
                        ),
                        validator: (val)=>val.isEmpty? ' Enter votre description' : null,
                        onChanged:(val){
                          setState(()=>commentaire = val );
                        }
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                        decoration: InputDecoration(
                          labelText: " Ville",
                        ),
                        validator: (val)=>val.isEmpty? ' Enter votre ville' : null,
                        onChanged:(val){
                          setState(()=>ville = val );
                        }
                    ),
                    SizedBox(height: 20.0),
                    RaisedButton.icon(
                        color: Colors.indigo[400],
                        icon: Icon(Icons.add_circle,color: Colors.white),
                        label: Text(
                          "Add",
                          style: TextStyle(color: Colors.white),
                        ),

                        onPressed: () {
                          if(_formkey.currentState.validate()){

                            db.createDemande(nom, phone, budget, commentaire, nuid,widget.latitude,widget.longtitude,ville);
                            /* if(result==null){
                        /*setState(() =>error="error with credentials");
                        print(email);
                        print(password);*/
                      }*/
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => AllDemande()),
                            );
                          }
                        }
                    ),
                    SizedBox(height: 20.0),

                    Text(error,
                      style: TextStyle(color: Colors.red,fontSize: 14.0),
                    ),
                  ],)
            ),
          ),
        )
    );
  }

}
