import 'dart:io';
import 'package:blooddonar/login.dart';
import 'package:blooddonar/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'entry.dart';
import 'search.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyLandingPage extends StatefulWidget {
  FirebaseUser user;
  MyLandingPage(this.user);
  @override
  State<StatefulWidget> createState() {
    return MyLandingPageState(user);
  }
}

class MyLandingPageState extends State<MyLandingPage> {
  FirebaseUser user;
  MyLandingPageState(this.user);
  static String become_a_donar = "Become a Donar";
  static String update_your_info = "Update Your Info";
  static String text_for_button = become_a_donar;
  Map<String, dynamic> userDetails;

  loadData() async {
    var data = await Firestore.instance.collection('blooddonors').document(user.uid);
    data.get().then((value){
      if(value.data == null )
      {
       setState(() {
        text_for_button = become_a_donar; 
       });
      }
      else{
         userDetails = value.data;
        setState(() {
         text_for_button = update_your_info; 
        });
      }
    });
  }

@override
Widget initState() {
  super.initState();
  loadData();
}

  _secondButton() {
    if (text_for_button == become_a_donar) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Entry(user,userDetails)));
      setState(() {
        text_for_button = update_your_info;
      });
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Entry(user,userDetails)));
    }
  }

  @override
  Widget build(BuildContext context) {

    var style = TextStyle(fontSize: 20, color: Colors.grey);

    var drawer = Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          ListView(
            shrinkWrap: true,
            children: <Widget>[
              Container(
                width: double.infinity,
                child: DrawerHeader(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: NetworkImage(user.photoUrl)),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 8),
                      ),
                      Text(
                        user.displayName,
                        style: TextStyle(fontSize: 15, color: Colors.white70),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 8),
                      ),
                      Text(user.email,
                          style: TextStyle(fontSize: 12, color: Colors.white60))
                    ],
                  ),
                  decoration: BoxDecoration(color: Colors.red[800]),
                ),
              )
            ],
          ),
          Expanded(
            child: Container(
              //color: Colors.green[200],
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text(
                      'Search Donor',
                      style: style,
                    ),
                    trailing: Icon(Icons.search),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Search()));
                    },
                  ),
                  Divider(
                    height: 4,
                  ),
                  ListTile(
                    title: Text(
                      'Donation Camp',
                      style: style,
                    ),
                    trailing: Icon(Icons.home),
                  ),
                  Divider(
                    height: 4,
                  ),
                  ListTile(
                    title: Text(
                      'Contact us',
                      style: style,
                    ),
                    trailing: Icon(Icons.phone),
                  ),
                  Divider(
                    height: 4,
                  ),
                  ListTile(
                    title: Text(
                      'About us',
                      style: style,
                    ),
                    trailing: Icon(Icons.account_circle),
                  ),
                  Divider(
                    height: 4,
                  ),
                ],
              ),
            ),
            flex: 3,
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 50,
                width: double.infinity,
                padding: EdgeInsets.only(bottom: 10),
                color: Colors.red[900],
                child: FlatButton(
                    onPressed: () {
                      googleSignIn.signOut();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyLoginPage()));
                    },
                    child: ListTile(
                      title: Text(
                        'Log out',
                        style: TextStyle(fontSize: 25, color: Colors.black54),
                      ),
                      trailing: Icon(Icons.power_settings_new),
                    )),
              ),
            ),
            flex: 1,
          ),
        ],
      ),
    );

    var logoutButton = Container(
      child: FlatButton(
        onPressed: (){
          googleSignIn.signOut();
           Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyLoginPage()));
        },
        child: Icon(
          Icons.power_settings_new,
          size: 30,
        ),
      ),
    );

    var style2 = TextStyle(fontSize: 30, color: Colors.black);

    var column = Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          FlatButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Search()));
              },
              child: Card(
                child: Container(
                    alignment: Alignment.center,
                    height: 100,
                    width: 300,
                    child: Text(
                      "Search Donor",
                      style: TextStyle(fontSize: 30, color: Colors.white60),
                    )),
                color: Colors.red[800],
                elevation: 45,
                borderOnForeground: true,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4)),
              )),
          Padding(
            padding: EdgeInsets.only(top: 25),
          ),
          FlatButton(
                onPressed: _secondButton,
                child:Card(
            child: Container(
              alignment: Alignment.center,
              height: 100,
              width: 300,
              child: Text(
                  text_for_button,
                  style: TextStyle(fontSize: 30, color: Colors.white60),
                ),
            ),
            color: Colors.red[800],
            elevation: 45,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          ),),
          Padding(
            padding: EdgeInsets.only(top: 25),
          ),
        ],
      ),
    );

    var appbar = AppBar(
      title: Text("Blood Donation"),
      actions: <Widget>[logoutButton],
    );
    var scaffold = Scaffold(
      appBar: appbar,
      drawer: drawer,
      body: WillPopScope(
        onWillPop: () {
          exit(0);
        },
        child: column,
      ),
    );
    return scaffold;
  }
}
