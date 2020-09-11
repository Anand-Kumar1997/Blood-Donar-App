import 'package:flutter/material.dart';

class Aboutus extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return AboutusState();
  }

}

class AboutusState extends State<Aboutus>{
  @override
  Widget build(BuildContext context) {
    
    var _listView = ListView(
      
    );

    var scaffold = Scaffold(
      appBar:  AppBar(title: Text("About us"),
      ),
      body: _listView,
    );
    return null;
  }
  
}