import 'dart:js';
import 'dart:typed_data';
import 'package:anupam/genBill.dart';
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

class accPdf{
  final int gst=18;
  
  static Future<Uint8List> makePdf() async{
    List<dynamic> amttab= billPdf.totalTally();
    Uint8List logo = (await rootBundle.load('logo.png'))
          .buffer
          .asUint8List();
    Uint8List qrcode = (await rootBundle.load('anupamQR.png'))
          .buffer
          .asUint8List();
    final pdf = pw.Document();
    final mapper={'DoubleAC':'Double AC Room',
                  'DoubleNAC':'Double Non AC Room',
                  'TripleAC':'Triple AC Room',
                  'TripleNAC':'Triple Non AC Room',
                  'SingleBath':'Single Attached Bath Room',
                  'SingleSBath':'Single Shared Bath Room',
                  'Quad':'Four Bed Room'};
    pdf.addPage(
      pw.Page(build: (context){
        // pw.Footer();
        return pw.Column(
          children: [
            pw.Row(
              children: [
                
                pw.SizedBox(width: 250),
                pw.Container(
                  width: 270,
                  height: 60,
                  decoration: pw.BoxDecoration(
                    image: new pw.DecorationImage(image: pw.MemoryImage(logo))
                  )
                )
                
              ]
            ),
            pw.SizedBox(height: 5),

            pw.Row(
              children:[
            pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.start,
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Align(
                  alignment: pw.Alignment.topLeft,
                  child: pw.Text('INVOICE',
                    style: pw.TextStyle(fontSize: 28, fontWeight: pw.FontWeight.bold)),
                ),
                pw.Row( children:[pw.Text('ROOM NUMBER',
                    style: pw.TextStyle(fontSize: 10, fontStyle: pw.FontStyle.italic)),
                pw.SizedBox(width: 10),
                pw.Text('DATE OF ISSUE',
                    style: pw.TextStyle(fontSize: 10, fontStyle: pw.FontStyle.italic)),]),
            // pw.SizedBox(width: 240),
                pw.Row(children: [
                  pw.Text('${makeBill.billdeets[1]}',
                    style: pw.TextStyle(fontSize: 9)),
                  pw.SizedBox(width: 71),
                pw.Text('${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
                    style: pw.TextStyle(fontSize: 9)),
           ]),
                    pw.SizedBox(height: 12),
                    pw.Align(
                  alignment: pw.Alignment.centerLeft,
                  child: pw.Container(
                    child:pw.Text('Billed To,',
                    style: pw.TextStyle(fontSize: 11)),
                  ),
                ),
                pw.Align(
                  alignment: pw.Alignment.centerLeft,
                  child: pw.Container(
                    child: pw.Text('${makeBill.billdeets[0]}', 
                    style: pw.TextStyle(fontSize: 10)),
                  ),
                ),
                pw.Align(
                  alignment: pw.Alignment.centerLeft,
                  child: pw.Container(
                    child: pw.Text('${makeBill.billdeets[3]}', 
                    style: pw.TextStyle(fontSize: 10)),
                  ),
                ),
              ]
            ),
            pw.SizedBox(width: 200),
            pw.Container(
                  width: 100,
                  height: 100,
                  decoration: pw.BoxDecoration(
                    image: new pw.DecorationImage(image: pw.MemoryImage(qrcode))
                  )
                )
            
              ]
              
            ),
            pw.SizedBox(height: 10),
            
            

            pw.SizedBox(height: 10),
            pw.Text('Room Charges', style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold, decoration: pw.TextDecoration.underline) ),
            pw.SizedBox(height: 7),
            pw.Table(
              border: pw.TableBorder.all(),
              children:[
                pw.TableRow(
                  children: [
                    pw.Center(child: pw.Text('Room type',style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),),
                    pw.Center(child: pw.Text('No. of Days',style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),),
                    pw.Center(child: pw.Text('Rate',style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),),
                    pw.Center(child: pw.Text('Amount',style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),),
                  ]
                ),
                pw.TableRow(
                  children: [
                    pw.Center(child: pw.Text('${mapper['${makeBill.billdeets[4]}']}')),
                    pw.Center(child: pw.Text('${makeBill.billdeets[6]}')),
                    pw.Center(child: pw.Text('${makeBill.billdeets[5]}')),
                    pw.Center(child: pw.Text((makeBill.billdeets[6]*makeBill.billdeets[5]).toString())),
                  ]
                ),
              ] ),
              pw.SizedBox(height: 7),
              pw.Row(children: [
                pw.SizedBox(width: 375),
                pw.Text('TOTAL: Rs.${amttab[2]}',textAlign: pw.TextAlign.right),
              ]),
            pw.SizedBox(height: 20),
            pw.Text('Miscellaneous Charges', style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold, decoration: pw.TextDecoration.underline) ),
            pw.SizedBox(height: 7),
            pw.Table(
              border: pw.TableBorder.all(),
              children:[
                pw.TableRow(
                  children: [
                    pw.Center(child: pw.Text('Items',style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),),
                    pw.Center(child: pw.Text('Quantity',style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),),
                    pw.Center(child: pw.Text('Rate',style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),),
                    pw.Center(child: pw.Text('Amount',style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),),
                  ]
                ),
              
           
             
                 for (var i = 0; i < makeBill.values.length; i++)
                  pw.TableRow(
                       children: [
                         pw.Column(
                             children: [
                               pw.Text(makeBill.values[i]['name']),
                             ]
                         ),
                         pw.Column(
                            //  crossAxisAlignment: pw.CrossAxisAlignment
                            //      .center,
                            //  mainAxisAlignment: pw.MainAxisAlignment.center,
                             children: [
                               pw.Text(makeBill.values[i]['quantity'].toString()),
                               //pw.Divider(thickness: 1)
                             ]
                         ),
                         pw.Column(
                            //  crossAxisAlignment: pw.CrossAxisAlignment
                            //      .center,
                            //  mainAxisAlignment: pw.MainAxisAlignment.center,
                             children: [
                               pw.Text(makeBill.values[i]['rate'].toString()),
                               //pw.Divider(thickness: 1)
                             ]
                         ),
                         pw.Column(
                            //  crossAxisAlignment: pw.CrossAxisAlignment
                            //      .center,
                            //  mainAxisAlignment: pw.MainAxisAlignment.center,
                             children: [
                               pw.Text((makeBill.values[i]['rate']*makeBill.values[i]['quantity']).toString()),
                               //pw.Divider(thickness: 1)
                             ]
                         )
                       ]
                   )
           ]
        ),
        pw.SizedBox(height: 7),
        pw.Row(children: [
                pw.SizedBox(width: 375),
                pw.Text('TOTAL: Rs.${amttab[3]}',textAlign: pw.TextAlign.right),
              ]),
        pw.SizedBox(height: 40),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.end,
          crossAxisAlignment: pw.CrossAxisAlignment.end,
          children: [
          pw.SizedBox(width: 250),
          pw.Column(children: [
            pw.Row(children: [
              pw.Text('SUBTOTAL: ',style: pw.TextStyle(fontWeight: pw.FontWeight.bold), textAlign: pw.TextAlign.left),
              pw.Text('Rs.${amttab[0]}')
            ],
            mainAxisAlignment: pw.MainAxisAlignment.end,
            crossAxisAlignment: pw.CrossAxisAlignment.end),
            pw.Row(children: [
              pw.Text('TAX RATE: ',style: pw.TextStyle(fontWeight: pw.FontWeight.bold), textAlign: pw.TextAlign.left),
              pw.Text('${amttab[4]} %')
            ],
            mainAxisAlignment: pw.MainAxisAlignment.end,
            crossAxisAlignment: pw.CrossAxisAlignment.end),
            pw.Row(children: [
              pw.Text('TAX: ',style: pw.TextStyle(fontWeight: pw.FontWeight.bold), textAlign: pw.TextAlign.left),
              pw.Text('Rs.${double. parse((amttab[2]*(amttab[4]/100)). toStringAsFixed(2))}')
            ],
            mainAxisAlignment: pw.MainAxisAlignment.end,
            crossAxisAlignment: pw.CrossAxisAlignment.end),
            pw.Row(children: [
              pw.Text('GRAND TOTAL: ',style: pw.TextStyle(fontWeight: pw.FontWeight.bold), textAlign: pw.TextAlign.left),
              pw.Text('Rs.${double. parse((amttab[1]). toStringAsFixed(2))}')
            ],
            mainAxisAlignment: pw.MainAxisAlignment.end,
            crossAxisAlignment: pw.CrossAxisAlignment.end)
          ])
        ]),
        pw.Expanded(
          child: pw.Align(
            alignment: pw.FractionalOffset(0.5,1.0) ,
            child: pw.Text('Anupam Residency - anupamkochi@gmail.com - (+91)62380447012', style: pw.TextStyle(fontStyle: pw.FontStyle.italic,)),
)
          
          ),

        
        

  ]
);
      })
    );
    return pdf.save();
  }
}



