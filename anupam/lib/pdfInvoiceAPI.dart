// import 'package:anupam/bill.dart';
// // import 'package:flutter/cupertino.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'dart:io';
// import 'package:anupam/pdfApi.dart';
// import 'package:anupam/bill.dart';
// // import 'package:flutter/src/widgets/framework.dart' as fw;


// class PdfInvoiceAPI{
  
//   static Future<File> generate(dynamic billdeets, List<Map<String,dynamic>> values)async{
//     final pdf=pw.Document();
//     pdf.addPage(pw.MultiPage(
//       build: (context)=>[
//         buildTitle(makeBill.billdeets),
  
        
//     ],));
//     return PdfApi.saveDocument(name:'bill', pdf:pdf);
//   }
  
//   static pw.Widget buildTitle(billdeets)=>pw.Column(
//     crossAxisAlignment: pw.CrossAxisAlignment.start,
//     children: [
//       pw.Text('Anupam Residency',style: pw.TextStyle(fontSize: 24,fontWeight: pw.FontWeight.bold,)),
//       pw.Text('Invoice',style: pw.TextStyle(fontSize: 24,fontWeight: pw.FontWeight.bold)),
//       pw.SizedBox(height: 20),
      

//     ]
//   );
// }

// // pw.PageTheme _buildTheme(
// //       PdfPageFormat pageFormat, pw.Font base, pw.Font bold, pw.Font italic) {
// //     return pw.PageTheme(
// //       pageFormat: pageFormat,
// //       theme: pw.ThemeData.withFont(
// //         base: base,
// //         bold: bold,
// //         italic: italic,
// //       ),
// //     );
// //   }
