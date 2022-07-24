import 'package:anupam/main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:anupam/bill.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:developer';
import 'package:oktoast/oktoast.dart';
class Checkout extends StatefulWidget {
  const Checkout({ Key? key }) : super(key: key);

  @override
  custRetrieve createState() => custRetrieve();
  
}

class custRetrieve extends State<Checkout>{
  TextEditingController checkoutcont=new TextEditingController();
  CollectionReference checkin = FirebaseFirestore.instance.collection("CheckIn");
  var checker;
  static List<dynamic> deetlist=[];
  @override
 Widget build(BuildContext context) {
   
   
    Future<bool> checkDB(String roomno) async{
      final QuerySnapshot details = await checkin.get();
      List temp=details.docs.where((element) => element.get('roomno')=='$roomno').toList();
      
      if(temp.length>0){
        return true;
      }
      else{
        return false;
      }
      
      
      
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
                          {Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HomePage()));},
                        child: const Text('Back'),)),
                        SizedBox(width: 20),
                  SizedBox(height:35,width:160,
                            child:ElevatedButton(
                              style: style,
                              onPressed:()
                                {
                                  checkDB(checkoutcont.text).then((value) => checker=value);
                                  print(checker);
                                  if(checker){
                                    makeBill.chkoutData(checkoutcont.text).then((value) => deetlist=value);
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Billing(checkoutcont:checkoutcont)));  
                                }
                                else{
                                    showToast('Room not currently occupied',position: ToastPosition.bottom);
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Checkout()));
                                  }
                                  }
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
                  const SizedBox(height:250),
                 SizedBox( width:400,
                   child: TextField(
                    controller: checkoutcont,
                    obscureText: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Room Number',),)),
                      buttons,
                 
                      
                  
              ]))
            )

    );
  }


}