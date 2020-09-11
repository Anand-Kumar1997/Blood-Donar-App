import 'package:blooddonar/landing.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'login.dart';
import 'main.dart';
import 'google_signin.dart';
import 'package:connectivity/connectivity.dart';


Future<GoogleSignInAccount> _getSignedInAccount() async{

  GoogleSignInAccount account = googleSignIn.currentUser;

  if(account == null){
    account = await googleSignIn.signInSilently();
  }

  return account;
    
}

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> {

  var _function = MyLoginPage();
  var subscription;

  var _scaffoldKey = GlobalKey<ScaffoldState>(); 

  checkConnection() async{

     subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult connectionResult){
        
         if(connectionResult == ConnectivityResult.none){
           var snackBar = SnackBar(content: Text("No connection available"),);
           _scaffoldKey.currentState.showSnackBar(snackBar);
    }
    else
     if(connectionResult == ConnectivityResult.mobile){
        // var snackBar = SnackBar(content: Text("Mobile connection available"),);
        //    _scaffoldKey.currentState.showSnackBar(snackBar);
       startCounter();
      }else
     if(connectionResult == ConnectivityResult.wifi){
        // var snackBar = SnackBar(content: Text("Wifi network available"),);
        //    _scaffoldKey.currentState.showSnackBar(snackBar);
       startCounter();
     
    }

    });
  }

  startCounter() async {
    var _duration = Duration(seconds: 3);
    GoogleSignInAccount account = await _getSignedInAccount();
    if(account != null){
          FirebaseUser user = await signInAccountAuth(account);
           Navigator.push(
          context, MaterialPageRoute(builder: (context) => MyLandingPage(user)));
          
    }
    else{
    await Future.delayed(_duration).then((value) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => _function));
    });
    }
  }

  @override
  void initState() {
    super.initState();
    checkConnection();
   
    subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result){

    });
    //startCounter();
  }
  
  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
             Container(
               margin: EdgeInsets.only(bottom: 10),
               child:Hero(
                tag: "main_logo",
                child: Image.asset(
                  'assets/logo.png',
                  height: 150,
                  width: 150,
                ),
              ), ) ,
              Container(
               // margin: EdgeInsets.only(top: 10),
                child: Text(
                  "Blood Donation App",
                  style: TextStyle(fontSize: 25,
                  
                  fontWeight: FontWeight.w800,
                  color: Colors.red[300]),
                ),
              )
            ],
          )),
    );
  }
}
