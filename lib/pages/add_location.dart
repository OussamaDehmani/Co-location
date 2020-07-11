import 'package:co_location/pages/home.dart';
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

class Addlocation extends StatefulWidget {

  double latitude;
  double longtitude;
  Addlocation({this.latitude,this.longtitude});


  @override
  _AddlocationState createState() => _AddlocationState();
}

class _AddlocationState extends State<Addlocation> {
  File _image;
  final AuthService _auth=AuthService();
  final DatabaseService db= DatabaseService();
  final _formkey = GlobalKey<FormState>();
  String adresse="";
  String superficie="";
  String price="";
  String capacity="";
  bool wifi=false;
  String imge="";
  String nuid="";
  double lat;
  double long;
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

    Future getImage() async {
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);

      setState(() {
        _image = image;
        print('Image Path $_image');
      });
    }

    Future uploadPic(BuildContext context) async{
      String fileName = basename(_image.path);
      var timekey =new DateTime.now();
      StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child("imagesLocation");
      StorageUploadTask uploadTask = firebaseStorageRef.child(timekey.toString()+".jpg").putFile(_image);
      var ImgUrl =await (await uploadTask.onComplete).ref.getDownloadURL();
      setState(() {
        print("Profile Picture uploaded");
        imge=ImgUrl.toString();
        print(imge);
        Scaffold.of(context).showSnackBar(SnackBar(content: Text('Profile Picture Uploaded')));
      });
    }


    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation:0.0,
        title: Text("Add Location"),

      ),
      body:Builder(
      builder: (context) =>   Container(
        padding: EdgeInsets.symmetric(vertical:10.0,horizontal:30.0),
        child: Form(
            key: _formkey,
            child: ListView(
              children: <Widget>[

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: CircleAvatar(
                        radius: 100,
                        backgroundColor: Colors.indigo[300],
                        child: ClipOval(
                          child: new SizedBox(
                            width: 180.0,
                            height: 180.0,
                            child: (_image!=null)?Image.file(
                              _image,
                              fit: BoxFit.fill,
                            ):Image.network(
                              "https://images.unsplash.com/photo-1502164980785-f8aa41d53611?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 60.0),
                      child: IconButton(
                        icon: Icon(
                          Icons.camera,
                          size: 30.0,
                        ),
                        onPressed: () {
                          getImage();
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),

                TextFormField(

                    decoration: InputDecoration(
                      labelText: " Adresse",
                        //border: InputBorder.none,
                       // hintText: 'Enter une adresse'
                    ),
                    validator: (val)=>val.isEmpty? ' Enter une adresse' : null,
                    onChanged:(val){
                        setState(()=>adresse = val );
                    }
                ),
                SizedBox(height: 20.0),
                TextFormField(
                    decoration: InputDecoration(
                      labelText: " superficie",
                    ),
                    validator: (val)=>val.isEmpty? ' Enter une superficie' : null,
                    onChanged:(val){
                       setState(()=>superficie = val );
                    }
                ),
                SizedBox(height: 20.0),
                TextFormField(
                    decoration: InputDecoration(
                      labelText: " price",
                    ),
                    validator: (val)=>val.isEmpty? ' Enter un prix' : null,
                    onChanged:(val){
                        setState(()=>price = val );
                    }
                ),
                SizedBox(height: 20.0),
                TextFormField(
                    decoration: InputDecoration(
                      labelText: " Capacity",
                    ),
                    validator: (val)=>val.isEmpty? ' Enter une capacity' : null,
                    onChanged:(val){
                       setState(()=>capacity = val );
                    }
                ),
                SizedBox(height: 20.0),
                RadioListTile(
                  groupValue: wifi,
                  title: Text('wifi integré'),
                  value: true,
                  onChanged: (val) {
                    setState(() {
                      wifi = val;
                    });
                  },
                ),
                RadioListTile(
                  groupValue: wifi,
                  title: Text('wifi non integré'),
                  value: false,
                  onChanged: (val) {
                    setState(() {
                      wifi = val;
                    });
                  },
                ),

                SizedBox(height: 20.0),
                FlatButton.icon(

                  color: Colors.green[200],
                  label:Text(
                    "select position",
                    style: TextStyle(color: Colors.white),
                  ),
                  icon: Container(child: Icon(Icons.add_location)),
                  onPressed: (){
                    print('clicked');
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Map_location()),
                    );
                  },
                ),
                SizedBox(height: 20.0),
                RaisedButton(
                    color: Colors.indigo[400],
                    child: Text(
                      "Add",
                      style: TextStyle(color: Colors.white),
                    ),

                    onPressed: ()async {
                      if(_formkey.currentState.validate()){
                        await uploadPic(context);
                          db.createLocation(adresse, superficie, price, capacity, true, imge, nuid,widget.latitude,widget.longtitude);
                        /* if(result==null){
                        /*setState(() =>error="error with credentials");
                        print(email);
                        print(password);*/
                      }*/
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Home()),
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
