import 'package:anupam/glassmorphism.dart';
import 'package:anupam/main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:developer';
class Dashboard extends StatefulWidget {
  const Dashboard({ Key? key }) : super(key: key);
  

  @override
  dashB createState() => dashB();
  
}

class dashB extends State<Dashboard>{
  static CollectionReference singsbrooms = FirebaseFirestore.instance.collection('Rooms').doc("SingleSBath").collection("rooms");
  static CollectionReference singbrooms = FirebaseFirestore.instance.collection('Rooms').doc("SingleBath").collection("rooms");
  static CollectionReference dubacrooms = FirebaseFirestore.instance.collection('Rooms').doc("DoubleAC").collection("rooms");
  static CollectionReference dubnrooms = FirebaseFirestore.instance.collection('Rooms').doc("DoubleNAC").collection("rooms");
  static CollectionReference tripacrooms = FirebaseFirestore.instance.collection('Rooms').doc("TripleAC").collection("rooms");
  static CollectionReference tripnrooms = FirebaseFirestore.instance.collection('Rooms').doc("TripleNAC").collection("rooms");
  static CollectionReference quadrooms = FirebaseFirestore.instance.collection('Rooms').doc("Quad").collection("rooms");
  static List<String> singsbnums=[];
  static List<String> singbnums=[];
  static List<String> dubnums=[];
  static List<String> dubacnums=[];
  static List<String> tripnums=[];
  static List<String> tripacnums=[];
  static List<String> quadnums=[];

  static Future<List<String>> roomnoData(rooms) async {
      // Get docs from collection reference
      QuerySnapshot querySnapshot = await rooms.get();

      // Get data from docs and convert map to List
      // final allData = querySnapshot.docs.map((doc) => doc.data().toString()).toList();
      List<String> list=[];
      querySnapshot.docs.forEach((element) {
                
                  list.add(element.get("num").toString());
                });
      return(list);
     
  }
 
  @override
  Widget build(BuildContext context) {
    return Container(
  //     Container(
  // constraints: BoxConstraints.expand(),
  // decoration: const BoxDecoration(
  //   image: DecorationImage(
  //       image: AssetImage("assets/bg4.jpg"), 
  //       fit: BoxFit.cover),
  // ),
  // );
      constraints: BoxConstraints.expand(),
      decoration:const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/bg4.jpg"),
                fit: BoxFit.cover ),
              ), 
          
       child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Column(
        children:<Widget>[
          const SizedBox(height: 50.0),
          const Center(
            child: Text(
              "Dashboard",
              style: TextStyle(
                fontWeight:FontWeight.bold,
                color: Colors.deepOrangeAccent,
                fontSize: 40.0),),
          ),

    ])));
   
  }}