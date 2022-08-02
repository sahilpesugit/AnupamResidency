import 'package:anupam/accounts.dart';
import 'package:anupam/glassmorphism.dart';
import 'package:anupam/main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:anupam/bill.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:developer';
import 'package:oktoast/oktoast.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';
import 'dart:convert' show utf8;
import 'dart:html' as html;
import 'package:csv/csv.dart';

class CSV extends StatefulWidget {
  var range;
  CSV({ Key? key,
      required this.range}) : super(key: key);

  @override
  csvGen createState() => csvGen();
  
}

class csvGen extends State<CSV>{
  CollectionReference acc = FirebaseFirestore.instance.collection("Accounts");
  Map<String,List<dynamic>> accountList={};
  List<List<dynamic>> csvList=[['Transaction ID','Date','Phone Number','Mode of Payment','Amount before Tax','Amount after Tax']];
  var finallist;
  void getAccounts(List<DateTime> range){
    acc.where("date",
     isGreaterThanOrEqualTo: range[0], isLessThanOrEqualTo: range[1])
     .get().then((value) => 
        value.docs.forEach((element) {
          accountList[element.id]=
          [element.id,"${DateTime.fromMicrosecondsSinceEpoch(element.get("date").microsecondsSinceEpoch).day}/${DateTime.fromMicrosecondsSinceEpoch(element.get("date").microsecondsSinceEpoch).month}/${DateTime.fromMicrosecondsSinceEpoch(element.get("date").microsecondsSinceEpoch).year}",
          element.get("phNo"),element.get("mode"),element.get("preTamount"),element.get("amount")];
        }));
    finallist=accountList;
  }
  void csvmaker(List<DateTime> range){
    finallist.forEach((k,v)=>csvList.add(v));
    String csv = const ListToCsvConverter().convert(csvList);

final bytes = utf8.encode(csv);
final blob = html.Blob([bytes]);
final url = html.Url.createObjectUrlFromBlob(blob);
final anchor = html.document.createElement('a') as html.AnchorElement
              ..href = url
              ..style.display = 'none'
              ..download = 'accounts(${range[0].day}.${range[0].month}.${range[0].year}-${range[1].day}.${range[1].month}.${range[1].year}).csv';              
anchor.click();
html.Url.revokeObjectUrl(url);
}
  void initState(){
    getAccounts(widget.range);
  }
  @override
 Widget build(BuildContext context) {
    
    final ButtonStyle style =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));
        
    return Container(
      constraints: BoxConstraints.expand(),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/bg4.jpg"),
            fit: BoxFit.cover),
              ),   
       child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: Column(
                children: <Widget>[ 
                  const SizedBox(height:70),
                  const Center(
                    child:Text(
                      "Accounts for Selected Period",
                      style: TextStyle(
                        color: Colors.deepOrangeAccent,
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ),
                  ElevatedButton(onPressed:() {
                        csvmaker(widget.range);
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HomePage())); 
                      }, child: Text('Generate Accounts')),
                //  SizedBox( height:100),
                //  // width:400,
                //  Padding(
                //   padding: const EdgeInsets.symmetric(
                //     horizontal: 20,
                //   ),
                //   child: Glassmorphism(
                //     blur: 10,
                //     opacity: 0.07,
                //     radius: 20,
                //     child: Container(
                //       height:400,
                //       width: 500,
                //       alignment: Alignment.topCenter,
                //       padding: const EdgeInsets.all(20),
                //       child: Column(
                //         children: [
                //       const SizedBox(height:5),
                //       // buttons,
                //       SfDateRangePicker(
                //         view: DateRangePickerView.month,
                //         monthViewSettings: DateRangePickerMonthViewSettings(firstDayOfWeek: 1),
                //         onSelectionChanged: _onSelectionChanged,
                //         selectionMode: DateRangePickerSelectionMode.range,
                //       ),
                //       ElevatedButton(onPressed:() {
                //         getAccounts();
                //         // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HomePage())); 
                //       }, child: Text('Get Accounts'))

                 
                      
                  
              // ]),)),)
              ],),),),);

            

    
  }
  
  


}