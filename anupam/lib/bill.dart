import 'package:anupam/checkout.dart';
import 'package:anupam/main.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:anupam/roomalloc.dart';
class Billing extends StatefulWidget {
  TextEditingController checkoutcont=new TextEditingController();
  Billing({ Key? key,
  required this.checkoutcont }) : super(key: key);

  @override
  
  makeBill createState() => makeBill();
  
}

class makeBill extends State<Billing>{
  static CollectionReference checkin = FirebaseFirestore.instance.collection('CheckIn');
  static CollectionReference tariff = FirebaseFirestore.instance.collection('Tariff');
  static CollectionReference rooms = FirebaseFirestore.instance.collection('Rooms');
  
  
  List<dynamic> chkoutdeet=[];
  var snapshot;
  var mapper={
    'SSB':roomAlloc.singsbrooms,
    'SN': roomAlloc.singbrooms,
    'DN': roomAlloc.dubnrooms,
    'DAC':roomAlloc.dubacrooms,
    'TN': roomAlloc.tripnrooms,
    'TAC': roomAlloc.tripacrooms,
    'Q': roomAlloc.quadrooms
  };
  Future<void> delDoc(room) async {
    final QuerySnapshot details = await checkin.get();
    //print(checkin.doc("Sahil").get());
    //checkin.doc("JtDcmyQnlRvkGfp7BE2l").delete();
    // details.docs.forEach((element) {
    //             if(element.get("phNo")=="${phno}"){
    //               element.delete()
    //             };});
    checkin.where("roomno", isEqualTo: "${room}").get().then((snapshot) {
      snapshot.docs[0].reference.delete();
     //change status in the room colllection to available
    });
  }
  Future<void> genBill(deetlist) async{
    DateTime curr =DateTime.now();
    Timestamp stamp=deetlist[2];
    DateTime inTime=DateTime.fromMicrosecondsSinceEpoch(stamp.microsecondsSinceEpoch);
    final diff=curr.difference(inTime).inDays; //time of stay calculated approximately
    String room=deetlist[1];
    int rate=0; //rate
    // print(room);
    // QuerySnapshot querySnapshot = await tariff.get();
    //   querySnapshot.docs.forEach((element) {
    //             if(element.get("roomno")=="${room}"){
    //               rate=element.get("rate");
    //             }});
    print("${deetlist[4]}");
    rooms.doc("${deetlist[4]}").get().then((snapshot) {
      print(snapshot.data());
    });
    
  }

  static Future<List<dynamic>> chkoutData(room)async {
    final QuerySnapshot details = await checkin.get();
    
    //final List<QueryDocumentSnapshot> chkoutdeet = details.docs;
    List<dynamic> list=[];
    details.docs.forEach((element) {
                if(element.get("roomno")=="${room}"){
                  list.add(element.get("name").toString());
                  list.add(element.get("roomno").toString());
                  list.add(element.get("date"));
                  list.add(element.get("phNo").toString());
                  list.add(element.get("roomtype"));
                };});
    // details.docs.forEach(((element) {
    //             list.add(element.data().toString());
    // }));
    // print(list);
    return(list);
    // details.docs.forEach((element) {
    //             if(element.get("phNo")=="${phno}"){
    //               chkoutdeet=element;
    //             };});
    // final docRef = checkin.doc("");
    // docRef.get().then(
    //   (DocumentSnapshot doc) {
    //     final data = doc.data() as Map<String, dynamic>;
    //     print(data);
    //   },
    //   onError: (e) => print("Error getting document : $e"),
    // );

  }
  @override
  void initState(){
    var mapper={
    'SSB':roomAlloc.singsbrooms,
    'SN': roomAlloc.singbrooms,
    'DN': roomAlloc.dubnrooms,
    'DAC':roomAlloc.dubacrooms,
    'TN': roomAlloc.tripnrooms,
    'TAC': roomAlloc.tripacrooms,
    'Q': roomAlloc.quadrooms
  };}
 Widget build(BuildContext context) {
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
                          {Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Checkout()));},
                        child: const Text('Back'),)),
                        SizedBox(width: 20),
                  SizedBox(height:35,width:160,
                            child:ElevatedButton(
                              style: style,
                              onPressed:()
                                
                                {delDoc(widget.checkoutcont.text);Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HomePage()));},
                              child: const Text('Print'),))
          ]
        ));
        /*var edit1=new Container(
          padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children:<Widget>[
            SizedBox(height:35,width:160,
                            child:ElevatedButton(
                              style: style,
                              onPressed:()
                                {Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HomePage()));},
                              child: const Text('Edit'),))
          ]));*/
        var edit=new Container(
          padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children:<Widget>[
                  SizedBox(height:35,width:160,
                            child:ElevatedButton(
                              style: style,
                              onPressed:()
                                {
                                },
                              child: const Text('Generate Bill'),)),
                  SizedBox(height:35,width:160,
                      ),            
                  SizedBox(height:35,width:160,
                      child:TextField(
                    obscureText: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Miscellaneous',),)),
                  SizedBox(height:35,width:160,
                            child:ElevatedButton(
                              style: style,
                              onPressed:()
                                {genBill(custRetrieve.deetlist);
                                  Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context)=>Checkout()));},
                              child: const Text('Add'),))
          ]));
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
                  const SizedBox(height:250),
                  edit,
                  //edit1,
                  buttons,
              ]))
            )

    );
  }


}