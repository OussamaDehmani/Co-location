
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:co_location/Models/demande.dart';
import 'package:co_location/pages/map.dart';



class myCard extends StatelessWidget {

  final Demande dem;
  myCard({this.dem});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        child: ListTile(
              leading: SizedBox(
                width: 60.0,
                height: 200,
                  child: Image.network(
                "https://lycee-jeanguehenno-saint-amand-montrond.fr/images/logement-locatif-.jpg",
                fit: BoxFit.fill,
          ),
        ),
          title: Text(dem.nom+' :(${dem.phone})'),
          subtitle: Text("budget : ${dem.budget} dh" ),
          trailing: FlatButton.icon(
            icon:  Icon(Icons.location_on),
            label: Text(dem.ville),
            onPressed: (){
              /*Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Map(long: dem.long,lat:dem.lat)),
              );*/
            },
          )
        ),
      ),
    );
  }
}

