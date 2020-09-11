import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class ShowDonor extends StatefulWidget{
   String _donorCity;
   ShowDonor(this._donorCity);

  @override
  State<StatefulWidget> createState() {
    return ShowDonorState(_donorCity);
  }
  
}

class ShowDonorState extends State<ShowDonor>{
    String _donorCity;
    ShowDonorState(this._donorCity);

  @override
  Widget build(BuildContext context) {

  var _style = TextStyle(fontSize: 15,color: Colors.grey);
  

   var streamBuilder = StreamBuilder<QuerySnapshot>(
     stream: Firestore.instance.collection('blooddonors').where("city",isEqualTo: _donorCity).snapshots(),
     builder: (BuildContext context , AsyncSnapshot<QuerySnapshot> snapshot){
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        } 
        else if(snapshot.hasError){
          return Center(child: Text("Error..."),);
        }
        else {
         if(snapshot.data.documents.length==0){
           return Center(child: Text("No donar available at this location......",
           style:TextStyle(fontSize: 16,color: Colors.grey) ,),);
         }
          return ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context,index){
                      DocumentSnapshot data = snapshot.data.documents[index];
          return Card(
            child: (Container(
              padding: EdgeInsets.only(left: 12,right: 12,top: 8,bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: <Widget>[
                   Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: <Widget>[
                       Row(children: <Widget>[
                         Icon(Icons.account_circle),
                         Padding(padding: EdgeInsets.only(left: 10),),
                         Text(data['name'],style: TextStyle(fontSize: 15,color: Colors.grey),),
                       ],),
                        Padding(padding: EdgeInsets.only(top:8),),
                        Row(children: <Widget>[
                         Icon(Icons.location_city),
                         Padding(padding: EdgeInsets.only(left: 10),),
                         Text(data['city'],style: _style,),

                       ],),
                       Padding(padding: EdgeInsets.only(top:8),),
                        Row(children: <Widget>[
                         Icon(Icons.phone),
                         Padding(padding: EdgeInsets.only(left: 10),),
                         Text(data['phone'],style: _style,),

                       ],),
                     ],
                   ),
                   Divider(),
                   Align(
                     child:
                   Container(
                     child: Text(data['blood group'],style: TextStyle(fontSize: 40,color: Colors.red),),
                   ))
                 ],
            ),
      )
      ),
    );
                },
          );

     }

     } 
   );
      
    return Scaffold(
      appBar: AppBar(title: Text("Donor List"),),
      body: streamBuilder
    );
  }

}