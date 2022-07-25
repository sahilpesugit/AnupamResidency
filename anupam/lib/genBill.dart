// import 'dart:ffi';
import 'dart:html';

import 'package:anupam/MoP.dart';
import 'package:anupam/checkout.dart';
import 'package:anupam/main.dart';
import 'package:anupam/roomalloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:developer';
import 'package:anupam/glassmorphism.dart';
import 'package:flutter/cupertino.dart';
import 'package:anupam/bill.dart';
import 'package:pdf/pdf.dart';
import 'package:anupam/pdfInvoiceAPI.dart';
import 'package:printing/printing.dart';


// Create a new user with a first and last name
class genPdf extends StatefulWidget {
  genPdf ({ Key? key}) : super(key: key);
  @override
  billPdf createState() => billPdf();
  
}
// final String names="Soil";
// final int phNos=420;
// final String locations="bloreeeeeee";

class billPdf extends State<genPdf>{
  final ButtonStyle style =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));
     static List<dynamic> amt=[];
     var color=Colors.lightBlue;
  static totalTally(){
    final totalroom=(makeBill.billdeets[6]*makeBill.billdeets[5]);
    final amttab=[];
    double totalmisc=0;
    final nactaxrate=12;
    final actaxrate=15;
    final finaltax;
    if(makeBill.values.length>0){
      makeBill.values.forEach((element) { 
      totalmisc =(element['rate']*element['quantity'])+totalmisc;
    });
    }
    
    double preamt=totalroom+totalmisc;
    double postamt=0;
    if(makeBill.billdeets[5]>=1000){
      postamt=((actaxrate*preamt)/100)+preamt;
      finaltax=actaxrate;
    }
    else{
      postamt=((nactaxrate*preamt)/100)+preamt;
      finaltax=nactaxrate;
    }
    print(preamt);
    print(postamt);
    amttab.add(preamt);
    amttab.add(postamt);
    amttab.add(totalroom);
    amttab.add(totalmisc);
    amttab.add(finaltax);
    return amttab;
  }
  @override
  void dispose() {
    
  }
 
Widget build(BuildContext context){
  return Scaffold(
    body: Stack(children: [
      PdfPreview(build: (context)=> PdfInvoiceAPI.makePdf() ),
      Container(
        alignment: Alignment.topCenter,
        padding: EdgeInsets.all(10),
        child: SizedBox(height:50,width:120,
                            child:ElevatedButton(
                              
                              style: style,
                              onPressed:()
                                {
                                  amt=totalTally();

                                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MoP()));
                                },
                              child: const Text('Complete Checkout'),)),
        
      ),
      
    ],)
  );
}
}