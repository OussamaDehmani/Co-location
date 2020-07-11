import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class Map extends StatelessWidget {
  final double lat;
  final double long;
  Map({this.lat,this.long});
  MapController controller= MapController();


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title:Text("map page"),
      ),
      body: FlutterMap(
          mapController: controller,
          options:  MapOptions(
            minZoom: 10.0,
            center: new LatLng(lat,long),
            onTap: (val)=>{
              print(val.latitude.toString() ),
            },
          ),
          layers: [
            new TileLayerOptions(
                urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: ['a', 'b', 'c']),
            MarkerLayerOptions(
                markers: [
                  Marker(
                    width: 45.0,
                    height: 45.0,
                    point: LatLng(lat ?? 72,long ??72),
                    builder: (context)=>Container(
                        child:IconButton(
                          icon: Icon(Icons.location_on),
                          color: Colors.red,
                          iconSize: 45,
                          onPressed: (){
                            print(lat);
                          },
                        )
                    ),

                  )
                ]
            )
          ]
      ),
    );
  }
}

