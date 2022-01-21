import 'package:anupam/checkout.dart';
import 'package:anupam/main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Checkin extends StatefulWidget {
  const Checkin({ Key? key }) : super(key: key);

  @override
  custReg createState() => custReg();
  
}

class custReg extends State<Checkin>{
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
                          {Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HomePage()));},
                        child: const Text('Back'),)),
                        SizedBox(width: 20),
                  SizedBox(height:35,width:160,
                            child:ElevatedButton(
                              style: style,
                              onPressed:()
                                {Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HomePage()));},
                              child: const Text('Next'),))
          ]
        ));
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
                   SizedBox(height:250),
                   SizedBox( width:400,
                   child: TextField(
                    obscureText: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Name',),)),
                  SizedBox(height:20),
                  SizedBox( width:400,
                   child: TextField(
                    obscureText: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Phone Number',),)),
                  SizedBox(height:20),
                  SizedBox( width:400,  
                   child: TextField(
                    obscureText: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Loaction',),)),     
                  buttons,  
                      
                  
              ]))
            )

    );
  }


}