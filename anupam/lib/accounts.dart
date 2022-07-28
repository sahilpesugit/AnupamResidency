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

class Accounts extends StatefulWidget {
  const Accounts({ Key? key }) : super(key: key);

  @override
  accGen createState() => accGen();
  
}

class accGen extends State<Accounts>{
  CollectionReference acc = FirebaseFirestore.instance.collection("Accounts");
  Map<String,List<dynamic>> accountList={};
  List<DateTime> range=[];

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
      setState(() {
        range=[];
        range.add(args.value.startDate);
        range.add(args.value.endDate.add(new Duration(hours: 24)));
      });    
      }

  void getAccounts() {
    acc.where("date",
     isGreaterThanOrEqualTo: range[0], isLessThanOrEqualTo: range[1])
     .get().then((value) => 
        value.docs.forEach((element) {
          accountList[element.id]=[element.get("amount"),element.get("date"),element.get("mode"),element.get("phNo"),element.get("preTamount")];
        }));
    print(accountList);
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
                      "Accounts",
                      style: TextStyle(
                        color: Colors.deepOrangeAccent,
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ),
                 SizedBox( height:100),
                 // width:400,
                 Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Glassmorphism(
                    blur: 10,
                    opacity: 0.07,
                    radius: 20,
                    child: Container(
                      height:400,
                      width: 500,
                      alignment: Alignment.topCenter,
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                      const SizedBox(height:5),
                      // buttons,
                      SfDateRangePicker(
                        view: DateRangePickerView.month,
                        monthViewSettings: DateRangePickerMonthViewSettings(firstDayOfWeek: 1),
                        onSelectionChanged: _onSelectionChanged,
                        selectionMode: DateRangePickerSelectionMode.range,
                      ),
                      ElevatedButton(onPressed:() {
                        getAccounts();
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HomePage())); 
                      }, child: Text('Get Accounts'))

                 
                      
                  
              ]),)),),],),),),);

            

    
  }
  
  


}