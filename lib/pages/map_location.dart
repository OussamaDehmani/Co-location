import 'package:co_location/pages/add_location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class Map_location extends StatelessWidget {

  MapController controller= MapController();


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title:Text("select Location"),
      ),
      body: FlutterMap(
          mapController: controller,
          options:  MapOptions(
            minZoom: 10.0,
            center: new LatLng(	33.589886,-7.603869),
            onTap: (val)=>{
            Navigator.push(
            context,
            MaterialPageRoute(
            builder: (context) => Addlocation(latitude:val.latitude,longtitude:val.longitude),
            ),
            ),
            },
          ),
          layers: [
            new TileLayerOptions(
                urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: ['a', 'b', 'c']),

          ]
      ),
    );
  }
}

