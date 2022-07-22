// import 'dart:ffi';
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
    
  // static int singsbn=0;
  @override
  void dispose() {
    
  }

Widget build(BuildContext context){
  return Scaffold(
    body: Stack(children: [
      PdfPreview(build: (context)=> PdfInvoiceAPI.makePdf() ),
      SizedBox(height:50,width:120,
                            child:ElevatedButton(
                              style: style,
                              onPressed:()
                                {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MoP()));},
                              child: const Text('Complete Checkout'),))
    ],)
  );
}
}