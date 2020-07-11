import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
class Location{


  final String adresse;
  final String superficie;
  final String price;
  final String capacity;
  final bool wifi;
  final String imge;
  final String nuid;
 final  double lat ;
 final double long;


  Location({this.adresse, this.superficie, this.price, this.nuid, this.capacity, this.wifi, this.imge, this.lat,this.long});

}