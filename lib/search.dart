
import 'package:flutter/material.dart';
import 'donorList.dart';


class Search extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return SearchState();
      }
      
    }
    
    class SearchState extends State<Search>{
  @override
  Widget build(BuildContext context) {
    var _searchController = TextEditingController();



    var tile = Center(
      child: 
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          Container(
        decoration: BoxDecoration(
          border: Border.all(width: 2),
        ),
        child:ListTile(title: TextFormField(controller: _searchController,
      decoration: InputDecoration(hintText: "Enter City"),),
      trailing: Icon(Icons.search),)),

      Padding(padding: EdgeInsets.only(top: 25),),

      RaisedButton(
        onPressed: (){
          var city = _searchController.text;
           Navigator.push(context, MaterialPageRoute(builder: (context)=>ShowDonor(city)));
      },
      child: Text("Search"),
      )

        ],)
      
      ,
    );

    var scaffold = Scaffold(
      appBar: AppBar(title: Text("Search Donar"),),
      body: tile,);
    
    return scaffold;
  }
}