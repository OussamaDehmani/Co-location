
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:co_location/Models/location.dart';
import 'package:co_location/pages/map.dart';



class myCard extends StatelessWidget {

  final Location loc;
  myCard({this.loc});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        child: ListTile(
          leading: SizedBox(
            width: 80.0,
            height: 200,
            child: Image.network(
              "${loc.imge}",
              fit: BoxFit.fill,
            ),
          ),
          title: Text(loc.adresse),
          subtitle: Text("P&C : ${loc.price} dh/${loc.capacity}"),

          trailing: IconButton(
            icon:  Icon(Icons.map),
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Map(long: loc.long,lat:loc.lat)),
              );
            },
          )
        ),
      ),
    );
  }
}

