import 'package:blooddonar/landing.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Entry extends StatefulWidget{
  FirebaseUser _user;
  Map<String, dynamic> _userDetails;
  Entry(this._user,this._userDetails);
  @override
  State<StatefulWidget> createState() {
    return EntryState(_user,this._userDetails);
      }
      
    }
    
    class EntryState extends State<Entry>{
      FirebaseUser _user;
      Map<String, dynamic> _userDetails;
      EntryState(this._user,this._userDetails);

   var _name =  TextEditingController()  ;
   var _city =  TextEditingController()  ;
   var _phone =  TextEditingController()  ;
   String _blood ;
   String _value ;


  @override
  Widget build(BuildContext context) {

    if(!(_userDetails == null)){
      _name.text = _userDetails['name'];
      _city.text = _userDetails['city'];
      _phone.text = _userDetails['phone'];
     // _value = _userDetails['blood group'];
    }else{
    _name.text = _user.displayName;
    }

    var column =
        Container(
          padding: EdgeInsets.only(left: 10,right: 10),
          child:ListView(
      children: <Widget>[

         TextFormField(
           cursorWidth: 2.0,
           showCursor: true,
           controller: _name,
           style: TextStyle(fontSize: 20),
           decoration: InputDecoration(hintText: "Name"),),

           Padding(padding: EdgeInsets.only(top: 15),),

          DropdownButton<String>(
            hint: Text("Select Blood Group"),
            items: [
              DropdownMenuItem<String>(
                value: 'A+',
                child: Text("A+"),
                ),
                DropdownMenuItem<String>(
                value: 'A-',
                child: Text("A-"),
                ),
                DropdownMenuItem<String>(
                value: 'B+',
                child: Text("B+"),
                ),
                DropdownMenuItem<String>(
                value: 'B-',
                child: Text("B-"),
                ),
                DropdownMenuItem<String>(
                value: 'AB+',
                child: Text("AB+"),
                ),
                DropdownMenuItem<String>(
                value: 'AB-',
                child: Text("AB-"),
                ),
                DropdownMenuItem<String>(
                value: 'O+',
                child: Text("O+"),
                ),
                DropdownMenuItem<String>(
                value: 'O-',
                child: Text("O-"),
                ),
            ],
            onChanged: (value){
              setState(() {
               _value = value ;
               value = _value;
               _blood = value;
              });
            },
            value: _value,
            elevation: 2,
            style: TextStyle(color: Colors.red, fontSize: 20),
            isDense: true,
            iconSize: 40.0,
            isExpanded: true,
          ),

           Padding(padding: EdgeInsets.only(top: 15),),

           TextFormField(
           controller: _city,
            style: TextStyle(fontSize: 20),
           decoration: InputDecoration(hintText: "City"),),

            Padding(padding: EdgeInsets.only(top: 15),),

           TextFormField(
           controller: _phone,
            style: TextStyle(fontSize: 20),
           decoration: InputDecoration(hintText: "Phone no"),),

           Padding(padding: EdgeInsets.only(top: 20),),

           RaisedButton(onPressed: (){
                         var name = _name.text;
                         var city = _city.text;
                          var phone = _phone.text;

                  Map<String,String> _details ={
                    'name': name,
                    'city': city,
                    'phone': phone,
                    'uid': _user.uid,
                    'blood group': _blood
                  };

                  DocumentReference dr = Firestore.instance.collection('blooddonors').document(_user.uid);
                  if(_userDetails==null){
                    dr.setData(_details);
                  }else{
                   dr.updateData(_details);
                  }
     
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>MyLandingPage(_user)));
              },
          child: Text("Save",style: TextStyle(fontSize: 20),),)

  
  ],
  ),
  );

    var scaffold = Scaffold(body:column,appBar: AppBar(title: Text("Add Details"),),);
    
    return scaffold;
  }
}