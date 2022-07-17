// import 'dart:ffi';
import 'package:anupam/checkout.dart';
import 'package:anupam/main.dart';
import 'package:anupam/reserve.dart';
import 'package:anupam/roomalloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:developer';
import 'package:anupam/glassmorphism.dart';
import 'package:flutter/cupertino.dart';


// Create a new user with a first and last name
class MakeReserve extends StatefulWidget {
  const MakeReserve({ Key? key, required this.onSubmit }) : super(key: key);
  final ValueChanged<String> onSubmit;

  @override
  custRes createState() => custRes();
  
}
// final String names="Soil";
// final int phNos=420;
// final String locations="bloreeeeeee";

class custRes extends State<MakeReserve>{
  var _text = '';
  //final _controller = TextEditingController();
  TextEditingController namecont=new TextEditingController();
  TextEditingController phNocont=new TextEditingController();
  TextEditingController locationcont=new TextEditingController();
  CollectionReference singsbrooms = FirebaseFirestore.instance.collection('Rooms').doc("SingleSBath").collection("rooms");
  CollectionReference singbrooms = FirebaseFirestore.instance.collection('Rooms').doc("SingleBath").collection("rooms");
  CollectionReference dubacrooms = FirebaseFirestore.instance.collection('Rooms').doc("DoubleAC").collection("rooms");
  CollectionReference dubnrooms = FirebaseFirestore.instance.collection('Rooms').doc("DoubleNAC").collection("rooms");
  CollectionReference tripacrooms = FirebaseFirestore.instance.collection('Rooms').doc("TripleAC").collection("rooms");
  CollectionReference tripnrooms = FirebaseFirestore.instance.collection('Rooms').doc("TripleNAC").collection("rooms");
  CollectionReference quadrooms = FirebaseFirestore.instance.collection('Rooms').doc("Quad").collection("rooms");
  // static int singsbn=0;
  @override
  void dispose() {
    namecont.dispose();
    super.dispose();
  }
  
  String? get _errorText {
    final phtext = phNocont.value.text;
    //final ntext=namecont.value.text;
    //final ltext=locationcont.value.text;
    final phoneRegExp = RegExp(r"^\+?0[0-9]{10}$");
    if(!phoneRegExp.hasMatch(phtext)){
      return 'Invalid Phone Number';
    }
    if(phtext.isEmpty) {
      return 'Cant be empty';
    }
    //final nameRegExp = new RegExp(r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$");
    //if(!nameRegExp.hasMatch(ntext)){
     // return 'Invalid Name';
    //}
    return null;

  }
  bool _submit() {
    if(_errorText == null) {
      //widget.onSubmit(phNocont.value.text);
      return true;    
    }
    return false;
  }
 Widget build(BuildContext context) {
    CollectionReference checkins = FirebaseFirestore.instance.collection("CheckIn");
  //   Future<void> addCheckin() {
  //     // Call the user's CollectionReference to add a new user
  //     return checkins
  //         .add({
  //           "name": namecont.text, // John Doe
  //           'location': locationcont.text, // Stokes and Sons
  //           'phNo': phNocont.text // 42
  //             })
  //         .then((value) => print("User Added"))
  //         .catchError((error) => print("Failed to add user: $error"));
          
  //  }
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
                              onPressed:(phNocont.value.text.isNotEmpty)&&(namecont.value.text.isNotEmpty)&&(locationcont.value.text.isNotEmpty)
                              ?()
                                // {Map<String,dynamic> data={"name":namecont,"phNo":phNocont,"location":locationcont};
                                // FirebaseFirestore.instance.collection("CheckIn").add(data);
                                // log('name: $namecont');
                                // log('data: $names');
                               {
                                
                                roomAlloc.getData(singsbrooms).then((value) => {roomAlloc.singsb=value});
                                roomAlloc.getData(singbrooms).then((value) => {roomAlloc.singb=value});
                                roomAlloc.getData(dubnrooms).then((value) => {roomAlloc.dubn=value});
                                roomAlloc.getData(dubacrooms).then((value) => {roomAlloc.dubac=value});
                                roomAlloc.getData(tripnrooms).then((value) => {roomAlloc.tripn=value});
                                roomAlloc.getData(tripacrooms).then((value) => {roomAlloc.tripac=value});
                                roomAlloc.getData(quadrooms).then((value) => {roomAlloc.quad=value});
                                print(roomAlloc.dubac.length);
                                // singsbn=roomAlloc.singsb.length;
                                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Reserve(namecont:namecont,locationcont:locationcont,phNocont:phNocont)));} 
                                : null
                                ,
                              child: const Text('Next'),))
          ]
        ));
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
                height: 50.0,
              ),
              const Center(
                child: Text(
                  'Make Reservation',
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
                      height: 450,
                      width: 500,
                      alignment: Alignment.topCenter,
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          const Text(
                            'Enter Guest Details',
                            style: TextStyle(
                              color: Colors.deepOrangeAccent,
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          /*const SizedBox(
                            height: 20,
                            ),*/
                          const SizedBox(height: 30),
                            SizedBox(width: 400, child: TextField(
                     controller: namecont,
                    obscureText: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Name',),
                      onChanged: (text) => setState(()=> _text),)),
                      const SizedBox(height: 20),
                      SizedBox(width: 400,
                      child: TextField(
                     controller: phNocont,
                    obscureText: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Phone Number',
                      //errorText: _errorText
                      ),
                      onChanged: (text) => setState(()=> _text),)),
                      SizedBox(height: 20),
                      SizedBox(width:400,
                      child: TextField(
                        controller: locationcont,
                    obscureText: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Check-In Date',
                      //errorText: _errorText
                      ),
                      onChanged: (text) => setState(()=> _text),)),
                      SizedBox(width:400,
                      child: TextField(
                        controller: locationcont,
                    obscureText: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Check-out Date',
                      //errorText: _errorText
                      ),
                      onChanged: (text) => setState(()=> _text),)),
                      SizedBox(width:400,
                      child: TextField(
                        controller: locationcont,
                    obscureText: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Comments',
                      //errorText: _errorText
                      ),
                      onChanged: (text) => setState(()=> _text),)),
                      buttons,

                        ]),)),)
            ]),)]
              ), 
          );
            
       /*child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: Column(
                children: <Widget>[ 
                   SizedBox(height:250),
                   SizedBox( width:400,
                   child: TextField(
                     controller: namecont,
                    obscureText: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Name',),
                      onChanged: (text) => setState(()=> _text),)),
                  SizedBox(height:20),
                  SizedBox( width:400,
                   child: TextField(
                     controller: phNocont,
                    obscureText: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Phone Number',
                      //errorText: _errorText
                      ),
                      onChanged: (text) => setState(()=> _text),)),
                  SizedBox(height:20),
                  SizedBox( width:400,  
                   child: TextField(
                     controller: locationcont,
                    obscureText: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Location',),
                      onChanged: (text) => setState(()=> _text),)),     
                  buttons,  
                      
                  
              ]))
            )

    );*/
  }


}