import 'package:anupam/genBill.dart';
import 'package:anupam/main.dart';
import 'package:anupam/pdfInvoiceAPI.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:anupam/bill.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:developer';
class MoP extends StatefulWidget {
  const MoP({ Key? key }) : super(key: key);

  @override
  paymentPage createState() => paymentPage();
  
}

class paymentPage extends State<MoP>{
  static CollectionReference acc = FirebaseFirestore.instance.collection('Accounts');
  List<DropdownMenuItem<String>> get dditems{
  List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(child: Text("Cash"),value: "Cash"),
    DropdownMenuItem(child: Text("Card"),value: "Card"),
    DropdownMenuItem(child: Text("UPI"),value: "UPI"),
  ];
  return menuItems;
}
  String modeP='Cash';
  updateAcc(String modeP,int amt){
    return acc
          .add({
            "mode": modeP,
            // "amount":amt
              })
          .then((value) => print("Transaction Added")) //Add a toast with success
          .catchError((error) => print("Failed to add user: $error"));
  }
  @override
 Widget build(BuildContext context) {
    final ButtonStyle style =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));
    int amt=0;
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
                  DropdownButton(
                    value: modeP,
                    items: dditems,
                    onChanged: (String? newValue){
                      setState(() {
                        modeP=newValue!;
                      });
                    }),
                  SizedBox(height:50,width:120,
                            child:ElevatedButton(
                              style: style,
                              onPressed:()
                                {
                                  // PdfInvoiceAPI.totalTally().then((value)=>{amt=value});
                                  updateAcc(modeP,amt);
                                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HomePage()));},
                              child: const Text('Complete Payment'),))
                
              ]))
            )

    );
  }


}