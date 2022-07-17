import 'dart:math';

import 'package:anupam/checkin.dart';
import 'package:anupam/main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:anupam/bill.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:developer';
import 'package:flutter/foundation.dart';
class RoomAlloc extends StatefulWidget {
  TextEditingController namecont=new TextEditingController();
  TextEditingController phNocont=new TextEditingController();
  TextEditingController locationcont=new TextEditingController();
  RoomAlloc({ Key? key,
          required this.namecont,
          required this.locationcont,
          required this.phNocont }) : super(key: key);

  @override
 
  roomAlloc createState() => roomAlloc();
  
  
}

class roomAlloc extends State<RoomAlloc>{
  String roomno="";
  var roomtype;
  //var psingsb=getData(singsbrooms);

  // void listgensingsb() async {
  // final psingsb =await getData(singsbrooms);
  // psingsb.forEach((item){
  //   for(var v in item){

  //   }
  //   });}
  static CollectionReference singsbrooms = FirebaseFirestore.instance.collection('Rooms').doc("SingleSBath").collection("rooms");
  static CollectionReference singbrooms = FirebaseFirestore.instance.collection('Rooms').doc("SingleBath").collection("rooms");
  static CollectionReference dubacrooms = FirebaseFirestore.instance.collection('Rooms').doc("DoubleAC").collection("rooms");
  static CollectionReference dubnrooms = FirebaseFirestore.instance.collection('Rooms').doc("DoubleNAC").collection("rooms");
  static CollectionReference tripacrooms = FirebaseFirestore.instance.collection('Rooms').doc("TripleAC").collection("rooms");
  static CollectionReference tripnrooms = FirebaseFirestore.instance.collection('Rooms').doc("TripleNAC").collection("rooms");
  static CollectionReference quadrooms = FirebaseFirestore.instance.collection('Rooms').doc("Quad").collection("rooms");
  var finaltype; //final type of room selected per checkin
  static List<String> singsb=[];
  static List<String> singb=[];
  static List<String> dubn=[];
  static List<String> dubac=[];
  static List<String> tripn=[];
  static List<String> tripac=[];
  static List<String> quad=[];
  
  //make this list by querying the firestoreDB
  
  static Future<List<String>> getData(rooms) async {
      // Get docs from collection reference
      QuerySnapshot querySnapshot = await rooms.get();

      // Get data from docs and convert map to List
      // final allData = querySnapshot.docs.map((doc) => doc.data().toString()).toList();
      List<String> list=[];
      querySnapshot.docs.forEach((element) {
                if(element.get("avail")=="y"){
                  list.add(element.get("num").toString());
                };});
      return(list);
     
  }
  void editStatus(roomno,finaltype)async {
    var docref = finaltype.doc('${roomno}');
    var res = await docref.update({'avail': 'n'});
   }
  @override
  //initially runs once for every class state created
  // void initState(){
  //   var mapper={
  //   'SSB':singbrooms,
  //   'SN': singbrooms,
  //   'DN': dubnrooms,
  //   'DAC':dubacrooms,
  //   'TN': tripnrooms,
  //   'TAC': tripacrooms,
  //   'Q': quadrooms
  // };
  // }
 Widget build(BuildContext context) {
    CollectionReference checkins = FirebaseFirestore.instance.collection("CheckIn");
    Future<void> addCheckin() {
      // Call the user's CollectionReference to add a new user
      return checkins
          .add({
            "name": widget.namecont.text,
            'location': widget.locationcont.text,
            'phNo': widget.phNocont.text,
            'roomno': roomno,
            'date': DateTime.now(),
            'roomtype' : roomtype
              })
          .then((value) => print("User Added")) //Add a toast with success
          .catchError((error) => print("Failed to add user: $error")); //add a toast with error
          
   }
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
                          {Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Checkin(onSubmit: (value) => value,)));},
                        child: const Text('Back'),)),
                        SizedBox(width: 20),
                  SizedBox(height:35,width:160,
                            child:ElevatedButton(
                              style: style,
                              onPressed:(){addCheckin();editStatus(roomno, finaltype);
                                {Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HomePage()));}},
                              child: const Text('Confirm'),))
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
            body: Column(
        children:<Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Room Allocation",textScaleFactor: 2,style: TextStyle(fontWeight:FontWeight.bold),),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Table(
               
            // textDirection: TextDirection.rtl,
            // defaultVerticalAlignment: TableCellVerticalAlignment.bottom,
            // border:TableBorder.all(width: 2.0,color: Colors.red),
            children: [
              TableRow(
                children: [
                  Center(child: Text("Room Type",textScaleFactor: 1.5,),),
                  // Center(child: Text("Number of rooms Available",textScaleFactor: 1.5),),
                  Center(child: Text("Links",textScaleFactor: 1.5),)
                ]
              ),
               TableRow(
                children: [
                  Center(child: Text("Single(Shared Bathroom)",textScaleFactor: 1.5),),
                  // Center(child: Text("${singsb.length}",textScaleFactor: 1.5),),
                  Center(child: ElevatedButton(child: Text('Allot'),
                                              onPressed: (){String selsingsb=singsb.first;showDialog(context: context, builder: (context)=>AlertDialog(
                                              title: Text("Single-Shared Bath"),
                                              content: DropdownButton(value: selsingsb,
                                                                      items: singsb.map((String singsb) {
                                                                          return DropdownMenuItem(
                                                                            value: singsb,
                                                                            child: Text(singsb),
                                                                          );
                                                                        }).toList(),
                                                                      onChanged: (String? newValue){
                                                                        setState(() {
                                                                          selsingsb= newValue!;
                                                                        });
                                                                      },
                                                                     ),
                                              actions:[TextButton(child: Text("Ok"),onPressed: (){roomtype="SingleSBath";roomno=selsingsb;finaltype=singsbrooms;Navigator.pop(context);})] ));},))
                ]
              ),
              TableRow(
                children: [
                  Center(child: Text("Single Room Non A/C",textScaleFactor: 1.5),),
                  // Center(child: Text("${singb.length}",textScaleFactor: 1.5),),
                  Center(child: ElevatedButton(child: Text('Allot'),
                                              onPressed: (){String selsingb=singb.first;showDialog(context: context, builder: (context)=>AlertDialog(
                                              title: Text("Single Room Non A/C"),
                                              content: DropdownButton(value: selsingb,
                                                                      items: singb.map((String singb) {
                                                                          return DropdownMenuItem(
                                                                            value: singb,
                                                                            child: Text(singb),
                                                                          );
                                                                        }).toList(),
                                                                      onChanged: (String? newValue){
                                                                        setState(() {
                                                                          selsingb= newValue!;
                                                                        });
                                                                      },
                                                                     ),
                                              actions:[TextButton(child: Text("Ok"),onPressed: (){roomtype="SingleBath";roomno=selsingb;finaltype=singbrooms;Navigator.pop(context);},),] ));},))
                ]
              ),
              TableRow(
                children: [
                  Center(child: Text("Double Room Non A/C",textScaleFactor: 1.5),),
                  // Center(child: Text("${dubn.length}",textScaleFactor: 1.5),),
                  Center(child: ElevatedButton(child: Text('Allot'),
                                              onPressed: (){String seldubn=dubn.first;showDialog(context: context, builder: (context)=>AlertDialog(
                                              title: Text("Double Room Non A/C"),
                                              content: DropdownButton(value: seldubn,
                                                                      items: dubn.map((String dubn) {
                                                                          return DropdownMenuItem(
                                                                            value: dubn,
                                                                            child: Text(dubn),
                                                                          );
                                                                        }).toList(),
                                                                      onChanged: (String? newValue){
                                                                        setState(() {
                                                                          seldubn= newValue!;
                                                                        });
                                                                      },
                                                                     ),
                                              actions:[TextButton(child: Text("Ok"),onPressed: (){roomtype="DoubleNAC";roomno=seldubn;finaltype=dubnrooms;Navigator.pop(context);},),] ));},))
                ]
              ),
              TableRow(
                children: [
                  Center(child: Text("Double Room A/C",textScaleFactor: 1.5),),
                  // Center(child: Text("${dubac.length}",textScaleFactor: 1.5),),
                  Center(child: ElevatedButton(child: Text('Allot'),
                                              onPressed: (){String seldubac=dubac.first;showDialog(context: context, builder: (context)=>AlertDialog(
                                              title: Text("Double Room A/C"),
                                              content: DropdownButton(value: seldubac,
                                                                      items: dubac.map((String dubac) {
                                                                          return DropdownMenuItem(
                                                                            value: dubac,
                                                                            child: Text(dubac),
                                                                          );
                                                                        }).toList(),
                                                                      onChanged: (String? newValue){
                                                                        setState(() {
                                                                          seldubac= newValue!;
                                                                        });
                                                                      },
                                                                     ),
                                              actions:[TextButton(child: Text("Ok"),onPressed: (){roomtype="DoubleAC";roomno=seldubac;finaltype=dubacrooms;Navigator.pop(context);},),] ));},))
                ]
              ),
              TableRow(
                children: [
                  Center(child: Text("Triple Room Non A/C",textScaleFactor: 1.5),),
                  // Center(child: Text("${tripn.length}",textScaleFactor: 1.5),),
                  Center(child: ElevatedButton(child: Text('Allot'),
                                              onPressed: (){String seltripn=tripn.first;showDialog(context: context, builder: (context)=>AlertDialog(
                                              title: Text("Triple Room Non A/C"),
                                              content: DropdownButton(value: seltripn,
                                                                      items: tripn.map((String tripn) {
                                                                          return DropdownMenuItem(
                                                                            value: tripn,
                                                                            child: Text(tripn),
                                                                          );
                                                                        }).toList(),
                                                                      onChanged: (String? newValue){
                                                                        setState(() {
                                                                          seltripn= newValue!;
                                                                        });
                                                                      },
                                                                     ),
                                              actions:[TextButton(child: Text("Ok"),onPressed: (){roomtype="TripleNAC";roomno=seltripn;finaltype=tripnrooms;Navigator.pop(context);},),] ));},))
                ]
              ),
              TableRow(
                children: [
                  Center(child: Text("Triple Room A/C",textScaleFactor: 1.5),),
                  // Center(child: Text("${tripac.length}",textScaleFactor: 1.5),),
                  Center(child: ElevatedButton(child: Text('Allot'),
                                              onPressed: (){String seltripac=tripac.first;showDialog(context: context, builder: (context)=>AlertDialog(
                                              title: Text("Triple Room A/C"),
                                              content: DropdownButton(value: seltripac,
                                                                      items: tripac.map((String tripac) {
                                                                          return DropdownMenuItem(
                                                                            value: tripac,
                                                                            child: Text(tripac),
                                                                          );
                                                                        }).toList(),
                                                                      onChanged: (String? newValue){
                                                                        setState(() {
                                                                          seltripac= newValue!;
                                                                        });
                                                                      },
                                                                     ),
                                              actions:[TextButton(child: Text("Ok"),onPressed: (){roomtype="TripleAC";roomno=seltripac;finaltype=tripacrooms;Navigator.pop(context);},),] ));},))
                ]
              ),
              TableRow(
                children: [
                  Center(child: Text("Four Bed Room Non A/C",textScaleFactor: 1.5),),
                  // Center(child: Text("${quad.length}",textScaleFactor: 1.5),),
                  Center(child: ElevatedButton(child: Text('Allot'),
                                              onPressed: (){String selquad=quad.first;showDialog(context: context, builder: (context)=>AlertDialog(
                                              title: Text("Four Bed Room Non A/C"),
                                              content: DropdownButton(value: selquad,
                                                                      items: quad.map((String quad) {
                                                                          return DropdownMenuItem(
                                                                            value: quad,
                                                                            child: Text(quad),
                                                                          );
                                                                        }).toList(),
                                                                      onChanged: (String? newValue){
                                                                        setState(() {
                                                                          selquad= newValue!;
                                                                        });
                                                                      },
                                                                     ),
                                              actions:[TextButton(child: Text("Ok"),onPressed: (){roomtype="Quad";roomno=selquad;finaltype=quadrooms;Navigator.pop(context);},),] ));},))
                ]
              ),
            ],
        ),
          ),buttons
        ]
      ),
    ));
  }
}