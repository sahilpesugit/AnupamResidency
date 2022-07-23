import 'package:anupam/glassmorphism.dart';
import 'package:anupam/makereservation.dart';
import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:anupam/checkin.dart';
import 'package:anupam/checkout.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:oktoast/oktoast.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:pdf/pdf.dart' as w;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyB4E3iTeRNndiLL-ktfwnJmDhVvoeneCCI", // Your apiKey
      appId: "1:430918641837:web:d571fcf7b2730731a9fe24", // Your appId
      messagingSenderId: "430918641837", // Your messagingSenderId
      projectId: "anupam-residency", // Your projectId
    ),
  );
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  // the root of your application.
  @override
  Widget build(BuildContext context) {
    return 
    OKToast(child:  MaterialApp(
      title: 'Anupam Hotel',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.orange,
        
      ),
      home: FutureBuilder(
        future: _initialization,
        builder: (context, snapshot){
          if(snapshot.hasError){
            print("Error");
          }
          if(snapshot.connectionState==ConnectionState.done){
            return HomePage();
          }
          return CircularProgressIndicator();
        }
      )
    ));
  }
}

class HomePage extends StatelessWidget {
  const HomePage({ Key? key }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final ButtonStyle style =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body:Stack(
        children: [
          
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset("assets/bg4.jpg",
            fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                const SizedBox(
                  height: 200.0,
                ),
                const Center(
                  child: Text(
                    '                     Welcome to\n Anupam Residency Employee Portal',
                    style: TextStyle(
                      color: Colors.deepOrangeAccent,
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Glassmorphism(
              blur: 10,
                opacity: 0.07,
                radius: 20,
                child: Container(
                  height: 300,
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const Text(
                        'Managing Accounts with Ease',
                        style: TextStyle(
                          color: Colors.deepOrangeAccent,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      SizedBox(width: 500,
                      child:
                      Text(
                        'Select one of the Below Options',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.deepOrangeAccent.withOpacity(0.8),
                          fontSize: 16.0,
                        ),
                      ),),
                      const Spacer(),
                      Glassmorphism(
                        blur: 10, 
                        opacity: 1.0, 
                        radius: 100.0, 
                        child: ElevatedButton(
                  
                  onPressed:()
                    {Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Checkin(onSubmit: (value) => value,)));},
                  child: const Text('Check-in'))),
                  const SizedBox(height:10),       
                 Glassmorphism(
                        blur: 10, 
                        opacity: 1.0, 
                        radius: 100.0, 
                        child: ElevatedButton(
                  
                  onPressed:()
                    {Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Checkout()));},
                  child: const Text('Check-out'))),
                  const SizedBox(height: 10),
                  Glassmorphism(
                        blur: 10, 
                        opacity: 1.0, 
                        radius: 100.0, 
                        child: ElevatedButton(
                  
                  onPressed:()
                    {Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MakeReserve(onSubmit: (value) => value,)));},
                  child: const Text('Make Reservation'))),
                  const SizedBox(height: 10),
                  Glassmorphism(
                        blur: 10, 
                        opacity: 1.0, 
                        radius: 100.0, 
                        child: ElevatedButton(
                  
                  onPressed:()
                    {Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Checkout()));},
                  child: const Text('Cancel Reservation'))),
                    ]),),
                ),),
                const SizedBox(
                  height: 100,
            ),

            ],),),
          // decoration: BoxDecoration(  
          //   gradient: LinearGradient(
          //     begin: Alignment.centerLeft,
          //     end: Alignment.centerRight,
          //     colors: [Color.fromRGBO(255, 125, 49,1.0),Color.fromRGBO(255, 252, 128,1.0)]
          //     ), 
          // ),    

          // child: Scaffold(
          //   backgroundColor: Colors.transparent,
          //   body: Center(
          //     child: Column(
          //       children: <Widget>[ 
          //         const SizedBox(height:250),
          //         Text('''Welcome to Anupam Residency
          //         Employee Portal''',
          //       style: TextStyle(fontStyle: FontStyle.normal,
          //       fontWeight: FontWeight.bold,
          //       color: Colors.black54.withOpacity(0.7),
          //       fontSize: 20,)),
          //       const SizedBox(height:30),
          //       SizedBox(height:35,width:160,
          //       child:ElevatedButton(
          //         style: style,
          //         onPressed:()
          //           {Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Checkin(onSubmit: (value) => value,)));},
          //         child: const Text('Check-in'))),
          //         const SizedBox(height:30),       
          //       SizedBox(height:35,width:160,
          //         child: ElevatedButton(
          //           style: style,
          //           onPressed:()
          //             {Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Checkout()));},
          //           child: const Text('Check-out'),)),  
                  
                  
              ],),);
            
          
      
  }
}






