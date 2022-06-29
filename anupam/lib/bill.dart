import 'package:anupam/checkout.dart';
import 'package:anupam/main.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
class Billing extends StatefulWidget {
  TextEditingController checkoutcont=new TextEditingController();
  Billing({ Key? key,
  required this.checkoutcont }) : super(key: key);

  @override
  makeBill createState() => makeBill();
  
}

class makeBill extends State<Billing>{
  CollectionReference checkin = FirebaseFirestore.instance.collection('Checkin');
  // var chkoutdeet;

  // Future<QueryDocumentSnapshot<Object?>> chkoutData(phno)async {
  //   QuerySnapshot details = await checkin.get();
  //   QueryDocumentSnapshot chkoutdeet;
  //   details.docs.forEach((element) {
  //               if(element.get("phNo")=="${phno}"){
  //                 chkoutdeet=element;
  //               };});
  //   return chkoutdeet;

  // }
  @override
 Widget build(BuildContext context) {
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
                          {Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Checkout()));},
                        child: const Text('Back'),)),
                        SizedBox(width: 20),
                  SizedBox(height:35,width:160,
                            child:ElevatedButton(
                              style: style,
                              onPressed:()
                                {Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HomePage()));},
                              child: const Text('Print'),))
          ]
        ));
        /*var edit1=new Container(
          padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children:<Widget>[
            SizedBox(height:35,width:160,
                            child:ElevatedButton(
                              style: style,
                              onPressed:()
                                {Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HomePage()));},
                              child: const Text('Edit'),))
          ]));*/
        var edit=new Container(
          padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children:<Widget>[
                  // SizedBox(height:35,width:160,
                  //           child:ElevatedButton(
                  //             style: style,
                  //             onPressed:()
                  //               {chkoutData(widget.checkoutcont.text).then((value) => {chkoutdeet=value});print(chkoutdeet.get("name"));},
                  //             child: const Text('Generate Bill'),)),
                  // SizedBox(height:35,width:160,
                  //     child:),            
                  SizedBox(height:35,width:160,
                      child:TextField(
                    obscureText: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Miscellaneous',),)),
                  SizedBox(height:35,width:160,
                            child:ElevatedButton(
                              style: style,
                              onPressed:()
                                {Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Checkout()));},
                              child: const Text('Add'),))
          ]));
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
                  edit,
                  //edit1,
                  buttons,
              ]))
            )

    );
  }


}