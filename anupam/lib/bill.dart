import 'package:anupam/checkout.dart';
import 'package:anupam/genBill.dart';
import 'package:anupam/main.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:anupam/roomalloc.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:anupam/pdfInvoiceAPI.dart';
import 'package:oktoast/oktoast.dart';


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
 
  // int isPressed = 0;
  int _count=0;
  static List<Map<String,dynamic>> values=[];
  static List<dynamic> chkoutdeet=[];
  var snapshot;
  var roomtype;
  static var billdeets;
  int miscItems=0;
  TextEditingController misccont=new TextEditingController();
  


  Future<void> delDoc(room) async {
    final QuerySnapshot details = await checkin.get();
    
    checkin.where("roomno", isEqualTo: "${room}").get().then((snapshot) {
      snapshot.docs[0].reference.delete();
      updateonDel(billdeets);
     //change status in the room colllection to available
    });
  }

  void updateonDel(billdeets)async {
      CollectionReference roomref = FirebaseFirestore.instance.collection('Rooms').doc('${billdeets[4]}').collection("rooms");

    var docref = roomref.doc('${billdeets[1]}');
    var res = await docref.update({'avail': 'y'});
   }


  static Future<List<dynamic>> genBill(deetlist) async{
    List<dynamic> billdeets=[];
    DateTime curr =DateTime.now();
    Timestamp stamp=deetlist[2];
    DateTime inTime=DateTime.fromMicrosecondsSinceEpoch(stamp.microsecondsSinceEpoch);
    int diff=curr.difference(inTime).inDays;
    if(diff==0){
      diff=1;
    } //time of stay calculated approximately
    String room=deetlist[1];
    int rate=0; //rate
    QuerySnapshot qs = await rooms.get();
      qs.docs.forEach((element) {
                if(element.id == '${deetlist[4]}'){
                  rate=element.get("rate");
                }});
    billdeets.addAll(deetlist);
    billdeets.add(rate);
    billdeets.add(diff);
    return billdeets;
  }
 
  static Future<List<dynamic>> chkoutData(room)async {
    final QuerySnapshot details = await checkin.get();
    
    List<dynamic> list=[];
    details.docs.forEach((element) {
                if(element.get("roomno")=="${room}"){
                  list.add(element.get("name").toString());
                  list.add(element.get("roomno").toString());
                  list.add(element.get("date"));
                  list.add(element.get("phNo").toString());
                  list.add(element.get("roomtype"));
                }
                ;});
    
    return(list);

   

  }


  _row(int key){
    String name='';
    int rate=0;
    int quantity=0;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(width:80.0),
        SizedBox(width: 180,child: TextFormField(onChanged: (val){name=val;} ,decoration: InputDecoration(border: OutlineInputBorder(), hintText: 'Item')),),
        SizedBox(width:10.0),
        SizedBox(width: 180,child: TextFormField(onChanged: (val1){rate=int.parse(val1);},decoration: InputDecoration(border: OutlineInputBorder(), hintText: 'Rate')),),
        SizedBox(width:10.0),
        SizedBox(width: 180,child: TextFormField(onChanged: (val2){quantity=int.parse(val2);},decoration: InputDecoration(border: OutlineInputBorder(), hintText: 'Number of items')),), 
        SizedBox(width:70,
                      child:ElevatedButton(
                        onPressed:()
                          {
                            showToast('${name} has been added',position: ToastPosition.bottom);
                            _onUpdate(name, rate, quantity);
                          },
                        child: const Text('Add'),)),
    ],);
  }

  _onUpdate(String name,int rate, int quantity){
    Map<String,dynamic> json={'name':name, 'quantity': quantity,'rate': rate} ;
    values.add(json);
    // print(values);
  }

  @override
  void initState() {
    super.initState();
    _count=0;
    values=[];
  }

@override
 Widget build(BuildContext context) {
    final ButtonStyle style =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));
    return Container(
      decoration: BoxDecoration(  
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Color.fromRGBO(255, 125, 49,1.0),Color.fromRGBO(255, 252, 128,1.0)]
              ), 
          ),  
       child: 
       Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: Column(
                children: <Widget>[ 
                  const SizedBox(height:100),
                  Text('Miscellaneous Items',style: TextStyle(
                    color: Colors.black,
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),),
                  Column(children:[
              Container(child: Column(
                children: <Widget>[ 
                      const SizedBox(height:30),
                      Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              
          children:<Widget>[
                      
                      SizedBox(height:50,width:50,
                            child:ElevatedButton(
                              style: style,
                              onPressed:() async
                                {
                                  setState(() {
                                  _count++;
                                  }); },
                              child: const Text('+'),)),

                      SizedBox(height:50,width:50,
                            child:ElevatedButton(
                              style: style,
                              onPressed:() async
                                {
                                  setState(() {
                                    if(_count==0){
                                      _count=0;
                                    }
                                    else{
                                      _count--;
                                    }
                                  }); },child: const Text('-'))),]),
                  Container(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: _count,
                          itemBuilder:  (context,index){
                          return _row(index);
                        },
                        ),
                        Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              
          children:<Widget>[SizedBox(height:35,width:160,
                      child:ElevatedButton(
                        style: style,
                        onPressed:()
                          {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Checkout()));
                          },
                        child: const Text('Back'),)),
                        SizedBox(width: 30),
                         SizedBox(height:35,width:160,
                            child:ElevatedButton(
                          style: style,
                          onPressed:()
                            {
                                  genBill(custRetrieve.deetlist).then((value) => billdeets=value);
                                  setState(() {
                                  billdeets=billdeets;
                                  });

                                  delDoc(billdeets[1]);

                                 Navigator.of(context).push(MaterialPageRoute(builder: (context)=>genPdf())); 
                            },
                          child: const Text('Generate Bill'),))])
                        
                      ],
                    ),
                  ),
                 
                  ]))
                  ,
            ]),
        
            ])))

    );
  }


}