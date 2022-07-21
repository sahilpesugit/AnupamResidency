// import 'dart:ffi';
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
  
  // static int singsbn=0;
  @override
  void dispose() {
    
  }

Widget build(BuildContext context){
  return Scaffold(
    body: PdfPreview(build: (context)=> PdfInvoiceAPI.makePdf() ),
  );
//   return Container(
//     padding: const EdgeInsets.all(20.0),
//                     child: Column(
//                       children: [
//                         Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
              
//           children:<Widget>[SizedBox(height:35,width:160,
//                       child:ElevatedButton(
//                         onPressed:() async
//                           {
                            
//                             PdfPreview(build: (context)=> PdfInvoiceAPI.makePdf() );
//                             print(makeBill.billdeets);
//                             print(makeBill.values);
//                           },
//                         child: const Text('Print'),)),
              
//   ])]));
// }
}
}