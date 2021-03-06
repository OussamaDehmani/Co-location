import 'package:co_location/services/auth.dart';
import 'package:flutter/material.dart';





class SignIn extends StatefulWidget {
    
    final Function toggleView;
    SignIn({this.toggleView});


  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth=AuthService();
  final _formkey = GlobalKey<FormState>();
  String email="";
  String password="";
  String error="";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
      backgroundColor: Colors.green[100],
      elevation:0.0,
      title: Text("Sign In"),
      actions:<Widget> [
        FlatButton.icon(onPressed: (){widget.toggleView();}, icon: Icon(Icons.person), label: Text('Register'))
      ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical:20.0,horizontal:50.0),
        child: Form(
            key: _formkey,
          child: Column(children: <Widget>[
            SizedBox(height: 20.0),
            TextFormField(
              validator: (val)=>val.isEmpty? ' Enter an Email' : null,
              onChanged:(val){
                  setState(()=>email = val );
              }
            ),
            SizedBox(height: 20.0),
            TextFormField(
              validator: (val)=>val.length < 6 ? ' Enter a 6 car to password' : null,
              obscureText: true,//hidden password
              onChanged:(val){
                  setState(()=>password = val );

              }
            ),
            SizedBox(height: 20.0),
            RaisedButton(
              color: Colors.pink[400],
              child: Text(
                "Sing In",
                style: TextStyle(color: Colors.white),
              ),
              
              onPressed: () async{
                if(_formkey.currentState.validate()){
                  // _formkey.currentState.save();
                  dynamic result= await _auth.signInWithEmailAndPassword(email, password);
                  if(result==null){
                    setState(() =>error="error with credentials");
                    print(email);
                    print(password);
                  }


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
    );
  }
}