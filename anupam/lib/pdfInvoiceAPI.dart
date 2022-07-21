import 'dart:js';
import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;
import 'package:anupam/bill.dart';
import 'package:flutter/cupertino.dart';
// import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:io';
import 'package:anupam/bill.dart';
// import 'package:flutter/src/widgets/framework.dart' as fw;

class PdfInvoiceAPI{
  static Future<Uint8List> makePdf() async{
    Uint8List data = (await rootBundle.load('logo.png'))
          .buffer
          .asUint8List();
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(build: (context){
        return pw.Column(
          children: [
            pw.Row(
              children: [
                pw.Text('INVOICE',
                    style: pw.TextStyle(fontSize: 30, fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(width: 190),
                pw.Container(
                  width: 200,
                  height: 40,
                  decoration: pw.BoxDecoration(
                    image: new pw.DecorationImage(image: pw.MemoryImage(data))
                  )
                )
                
              ]
            ),
            pw.SizedBox(height: 20),
            pw.Row(
              children: [
                pw.Text('ROOM NUMBER',
                    style: pw.TextStyle(fontSize: 8, fontStyle: pw.FontStyle.italic)),
                pw.SizedBox(width: 10),
                pw.Text('DATE OF ISSUE',
                    style: pw.TextStyle(fontSize: 8, fontStyle: pw.FontStyle.italic)),
              ]
            ),
            pw.Row(
              children: [
                pw.Text('${makeBill.billdeets[1]}',
                    style: pw.TextStyle(fontSize: 6)),
                pw.SizedBox(width: 60),
                pw.Text('${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
                    style: pw.TextStyle(fontSize: 6)),
              ]
            ),
            pw.Text('Billed To,',
            style: pw.TextStyle(fontSize: 7)),
            pw.Text('${makeBill.billdeets[0]}.', 
            style: pw.TextStyle(fontSize: 6)),
            pw.Text('${makeBill.billdeets[3]}.', 
            style: pw.TextStyle(fontSize: 6)),

            pw.SizedBox(height: 20),
            pw.Text('Room Charges'),
            pw.Table(
              children:[
                pw.TableRow(
                  children: [
                    pw.Center(child: pw.Text('Description')),
                    pw.Center(child: pw.Text('No. of Days')),
                    pw.Center(child: pw.Text('Rate')),
                    pw.Center(child: pw.Text('Amount')),
                  ]
                ),
              ] ),
            pw.SizedBox(height: 20),
            pw.Text('Miscellaneous Charges'),
            pw.Table(
              children:[
                pw.TableRow(
                  children: [
                    pw.Center(child: pw.Text('Items')),
                    pw.Center(child: pw.Text('Quantity')),
                    pw.Center(child: pw.Text('Rate')),
                    pw.Center(child: pw.Text('Amount')),
                  ]
                ),
              ] ),
        //     pw.Table(
        //       children: [
        //          for (var i = 0; i < makeBill.values.length; i++)
        //           pw.TableRow(
        //                children: [
        //                  pw.Column(
        //                      crossAxisAlignment: pw.CrossAxisAlignment
        //                          .center,
        //                      mainAxisAlignment: pw.MainAxisAlignment.center,
        //                      children: [
        //                        pw.Text(makeBill.values[i][0],
        //                            style: pw.TextStyle(fontSize: 6)),
        //                        pw.Divider(thickness: 1)
        //                      ]
        //                  ),
        //                  pw.Column(
        //                      crossAxisAlignment: pw.CrossAxisAlignment
        //                          .center,
        //                      mainAxisAlignment: pw.MainAxisAlignment.center,
        //                      children: [
        //                        pw.Text(makeBill.values[i][1],
        //                            style: pw.TextStyle(fontSize: 6)),
        //                        pw.Divider(thickness: 1)
        //                      ]
        //                  ),
        //                  pw.Column(
        //                      crossAxisAlignment: pw.CrossAxisAlignment
        //                          .center,
        //                      mainAxisAlignment: pw.MainAxisAlignment.center,
        //                      children: [
        //                        pw.Text(makeBill.values[i][2],
        //                            style: pw.TextStyle(fontSize: 6)),
        //                        pw.Divider(thickness: 1)
        //                      ]
        //                  ),
        //                  pw.Column(
        //                      crossAxisAlignment: pw.CrossAxisAlignment
        //                          .center,
        //                      mainAxisAlignment: pw.MainAxisAlignment.center,
        //                      children: [
        //                        pw.Text(makeBill.values[i][1]*makeBill.values[i][2],
        //                            style: pw.TextStyle(fontSize: 6)),
        //                        pw.Divider(thickness: 1)
        //                      ]
        //                  )
        //                ]
        //            )
        //    ]
        // )



            
          ]
        );
      })
    );
    return pdf.save();
  }
}



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

// pw.PageTheme _buildTheme(
//       PdfPageFormat pageFormat, pw.Font base, pw.Font bold, pw.Font italic) {
//     return pw.PageTheme(
//       pageFormat: pageFormat,
//       theme: pw.ThemeData.withFont(
//         base: base,
//         bold: bold,
//         italic: italic,
//       ),
//     );
//   }
