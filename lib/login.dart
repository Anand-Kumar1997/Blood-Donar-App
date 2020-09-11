import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'components/google_signin_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'google_signin.dart';
//import 'landing.dart';
import 'landing.dart';


class MyLoginPage extends StatefulWidget {
  @override
  _MyLoginPageState createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {

  _signin() async {

   FirebaseUser user = await googleSigninMethod().catchError((e){print(e);});
    Navigator.push(context, MaterialPageRoute(builder: (context)=> MyLandingPage(user) ));
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        exit(0);
      },
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 150,
                    height: 150,
                    child: Hero(tag: 'main_logo',child:Image.asset('assets/logo.png')),
                    margin: EdgeInsets.only(top: 80),
                  ),
                  Container(
                margin: EdgeInsets.only(top: 10,bottom: 200),
                child: Text(
                  "Blood Donation App",
                  style: TextStyle(fontSize: 25,
                  
                  fontWeight: FontWeight.w800,
                  color: Colors.red[300]),
                ),
              ),
                  GoogleSignInButton(
                    darkMode: false,
                    onPressed: _signin,
                  ),
                ],
              ),
            ),
            // Align(
            //     alignment: Alignment.bottomLeft,
            //     child: FlatButton(
            //         onPressed: null,
            //         child: Container(
            //           width: 100,
            //           height: 40,
            //           padding:
            //               EdgeInsets.only(top: 4, bottom: 4, left: 8, right: 8),
            //           child: Text(
            //             "Admin",
            //             style: TextStyle(fontSize: 20),
            //           ),
            //         )))
          ],
        ),
      ),
    );
  }
}
