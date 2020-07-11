import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:co_location/Models/location.dart';
import 'package:co_location/Models/demande.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:co_location/services/auth.dart';

class DatabaseService{



 // final String uid;
//  DatabaseService({this.uid});


  // collection reference
  final CollectionReference location = Firestore.instance.collection("location");
  final CollectionReference demande = Firestore.instance.collection("demande");

  Future<String> inputData() async {
    final FirebaseAuth auth =FirebaseAuth.instance;
    final FirebaseUser user = await auth.currentUser();
    print('---------------'+user.uid);
    return  user.uid.toString();

  }
  //Future Createlocation();
  Future createLocation (  String adresse,String superficie, String price,String capacity,bool wifi, String imge,String nuid,double lat,double long) async {

    return await location.add({
   'adresse':adresse,
   'superficie':superficie,
   'price':price,
   'capacity':capacity,
   'wifi':wifi,
   'imge':imge,
   'nuid':nuid,
    'lat':lat,
   'long':long,
    }).catchError((e){
    });


  }
  //Future CreateDemande();
  Future createDemande (  String nom,String phone, String budget,String commentaire,String nuid,double lat,double long,String ville) async {

    return await demande.add({
      'nom':nom,
      'phone':phone,
      'budget':budget,
      'commentaire':commentaire,
      'nuid':nuid,
      'lat':lat,
      'long':long,
      'ville':ville
    }).catchError((e){
    });


  }
//list for location
List <Location> LocationSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return Location(
        adresse: doc.data['adresse']?? '',
        superficie: doc.data['superficie']?? '',
        price: doc.data['price']?? '',
        capacity: doc.data['capacity']?? '',
        wifi: doc.data['wifi']?? false,
        imge: doc.data['imge']?? '',
        lat: doc.data['lat']?? 15,
        long: doc.data['long']?? 15,

      );
    }).toList();
}

//list for location
  List <Demande> DemandeSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return Demande(
        nom: doc.data['nom']?? '',
        phone: doc.data['phone']?? '',
        budget: doc.data['budget']?? '',
        commentaire: doc.data['commentaire']?? '',
        lat: doc.data['lat']?? 15,
        long: doc.data['long']?? 15,
        ville:doc.data['ville']??''

      );
    }).toList();
  }

  // GET Location

  Stream <List <Location>> get locations{
    return location.snapshots()
        .map(LocationSnapshot);

  }

  // GET Demande

  Stream <List <Demande>> get Demandes{
    return demande.snapshots()
        .map(DemandeSnapshot);
  }
}