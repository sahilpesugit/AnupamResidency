import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:anupam/checkin.dart';
import 'package:anupam/checkout.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Anupam Hotel',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
       
        primarySwatch: Colors.orange,
        
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));
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
                  Text('''Welcome to Anupam Residency
                  Employee Portal''',
                style: TextStyle(fontStyle: FontStyle.normal,
                fontWeight: FontWeight.bold,
                color: Colors.black54.withOpacity(0.7),
                fontSize: 20,)),
                const SizedBox(height:30),
                SizedBox(height:35,width:160,
                child:ElevatedButton(
                  style: style,
                  onPressed:()
                    {Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Checkin()));},
                  child: const Text('Check-in'))),
                  const SizedBox(height:30),       
                SizedBox(height:35,width:160,
                  child: ElevatedButton(
                    style: style,
                    onPressed:()
                      {Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Checkout()));},
                    child: const Text('Check-out'),)),  
                  
                  
              ]))
            )
          
      );
  }
}






