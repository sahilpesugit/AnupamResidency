// import 'dart:ffi';
import 'package:anupam/checkout.dart';
import 'package:anupam/main.dart';
import 'package:anupam/roomalloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:developer';


// Create a new user with a first and last name
class Checkin extends StatefulWidget {
  const Checkin({ Key? key }) : super(key: key);

  @override
  custReg createState() => custReg();
  
}
// final String names="Soil";
// final int phNos=420;
// final String locations="bloreeeeeee";

class custReg extends State<Checkin>{
  TextEditingController namecont=new TextEditingController();
  TextEditingController phNocont=new TextEditingController();
  TextEditingController locationcont=new TextEditingController();
  CollectionReference singsbrooms = FirebaseFirestore.instance.collection('Rooms').doc("SingleSBath").collection("rooms");
  CollectionReference singbrooms = FirebaseFirestore.instance.collection('Rooms').doc("SingleBath").collection("rooms");
  CollectionReference dubacrooms = FirebaseFirestore.instance.collection('Rooms').doc("DoubleAC").collection("rooms");
  CollectionReference dubnrooms = FirebaseFirestore.instance.collection('Rooms').doc("DoubleNAC").collection("rooms");
  CollectionReference tripacrooms = FirebaseFirestore.instance.collection('Rooms').doc("TripleAC").collection("rooms");
  CollectionReference tripnrooms = FirebaseFirestore.instance.collection('Rooms').doc("TripleNAC").collection("rooms");
  CollectionReference quadrooms = FirebaseFirestore.instance.collection('Rooms').doc("Quad").collection("rooms");
  static int singsbn=0;
  @override
 Widget build(BuildContext context) {
    CollectionReference checkins = FirebaseFirestore.instance.collection("CheckIn");
  //   Future<void> addCheckin() {
  //     // Call the user's CollectionReference to add a new user
  //     return checkins
  //         .add({
  //           "name": namecont.text, // John Doe
  //           'location': locationcont.text, // Stokes and Sons
  //           'phNo': phNocont.text // 42
  //             })
  //         .then((value) => print("User Added"))
  //         .catchError((error) => print("Failed to add user: $error"));
          
  //  }
    final ButtonStyle style =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));
    var buttons=new Container(
          padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children:<Widget>[
                  SizedBox(height:35,width:160,
                      child:ElevatedButton(
                        style: style,
                        onPressed:()
                          {Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HomePage()));},
                        child: const Text('Back'),)),
                        SizedBox(width: 20),
                  SizedBox(height:35,width:160,
                            child:ElevatedButton(
                              style: style,
                              onPressed:()
                                // {Map<String,dynamic> data={"name":namecont,"phNo":phNocont,"location":locationcont};
                                // FirebaseFirestore.instance.collection("CheckIn").add(data);
                                // log('name: $namecont');
                                // log('data: $names');
                               {
                                roomAlloc.getData(singsbrooms).then((value) => {roomAlloc.singsb=value});
                                roomAlloc.getData(singbrooms).then((value) => {roomAlloc.singb=value});
                                roomAlloc.getData(dubnrooms).then((value) => {roomAlloc.dubn=value});
                                roomAlloc.getData(dubacrooms).then((value) => {roomAlloc.dubac=value});
                                roomAlloc.getData(tripnrooms).then((value) => {roomAlloc.tripn=value});
                                roomAlloc.getData(tripacrooms).then((value) => {roomAlloc.tripac=value});
                                roomAlloc.getData(quadrooms).then((value) => {roomAlloc.quad=value});
                                singsbn=roomAlloc.singsb.length;
                                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>RoomAlloc(namecont:namecont,locationcont:locationcont,phNocont:phNocont)));}
                                ,
                              child: const Text('Next'),))
          ]
        ));
    return Container(
      decoration: BoxDecoration(  
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Color.fromRGBO(255, 125, 49,1.0),Color.fromRGBO(255, 252, 128,1.0)]
              ), 
          ),  
       child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: Column(
                children: <Widget>[ 
                   SizedBox(height:250),
                   SizedBox( width:400,
                   child: TextField(
                     controller: namecont,
                    obscureText: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Name',),)),
                  SizedBox(height:20),
                  SizedBox( width:400,
                   child: TextField(
                     controller: phNocont,
                    obscureText: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Phone Number',),)),
                  SizedBox(height:20),
                  SizedBox( width:400,  
                   child: TextField(
                     controller: locationcont,
                    obscureText: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Location',),)),     
                  buttons,  
                      
                  
              ]))
            )

    );
  }


}