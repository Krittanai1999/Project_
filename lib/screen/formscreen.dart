// // ignore_for_file: prefer_const_constructors

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_firebase/model/datatest.dart';
// import 'package:form_field_validator/form_field_validator.dart';

// class FormScreen extends StatefulWidget {
//   const FormScreen({Key? key}) : super(key: key);

//   @override
//   _FormScreenState createState() => _FormScreenState();
// }

// class _FormScreenState extends State<FormScreen> {
//   final formKey = GlobalKey<FormState>();
//   DataTest myDataTest = DataTest();
//   // เตรียม Firebase
//   final Future<FirebaseApp> firebase = Firebase.initializeApp();
//   CollectionReference _dataCollection = FirebaseFirestore.instance.collection("datatest");


//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//         future: firebase,
//         builder: (context, snapshot) {
//           if (snapshot.hasError) {
//             return Scaffold(
//                 appBar: AppBar(
//                   title: Text("Error"),
//                 ),
//                 body: Center(
//                   child: Text("${snapshot.error}"),
//                 ));
//           }
//           if (snapshot.connectionState == ConnectionState.done) {
//             return Scaffold(
//               appBar: AppBar(
//                 title: Text("เเบบฟอร์ม"),
//               ),
//               body: Container(
//                 padding: EdgeInsets.all(20),
//                 child: Form(
//                   key: formKey,
//                   child: SingleChildScrollView(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "ชื่อ",
//                           style: TextStyle(fontSize: 20),
//                         ),
//                         TextFormField(
//                           validator: RequiredValidator(
//                               errorText: "กรุณาป้อนข้อมูล (Fname)"),
//                           onSaved: (String? fname) {
//                             myDataTest.fname = fname;
//                           },
//                         ),
//                         SizedBox(
//                           height: 15,
//                         ),
//                         Text(
//                           "นามสกุล",
//                           style: TextStyle(fontSize: 20),
//                         ),
//                         TextFormField(
//                           validator: RequiredValidator(
//                               errorText: "กรุณาป้อนข้อมูล (Lname)"),
//                           onSaved: (String? lname) {
//                             myDataTest.lname = lname;
//                           },
//                         ),
//                         SizedBox(
//                           height: 15,
//                         ),
//                         Text(
//                           "อีเมล",
//                           style: TextStyle(fontSize: 20),
//                         ),
//                         TextFormField(
//                           validator: MultiValidator([
//                             EmailValidator(
//                                 errorText:
//                                     "กรุณาป้อนข้อมูล (Email) ให้ถูกต้อง"),
//                             RequiredValidator(
//                                 errorText: "กรุณาป้อนข้อมูล (Email)")
//                           ]),
//                           onSaved: (String? email) {
//                             myDataTest.email = email;
//                           },
//                           keyboardType: TextInputType.emailAddress,
//                         ),
//                         SizedBox(
//                           height: 15,
//                         ),
//                         Text(
//                           "เเต้ม",
//                           style: TextStyle(fontSize: 20),
//                         ),
//                         TextFormField(
//                           validator: RequiredValidator(
//                               errorText: "กรุณาป้อนข้อมูล (Score)"),
//                           onSaved: (String? score) {
//                             myDataTest.score = score;
//                           },
//                           keyboardType: TextInputType.number,
//                         ),
//                         SizedBox(
//                           width: double.infinity,
//                           child: ElevatedButton(
//                             child: Text(
//                               "Save",
//                               style: TextStyle(fontSize: 20),
//                             ),
//                             onPressed: () async{
//                               if (formKey.currentState!.validate()) {
//                                 formKey.currentState!.save();
//                                 await _dataCollection.add({
//                                   "fname":myDataTest.fname,
//                                   "lname":myDataTest.lname,
//                                   "email":myDataTest.email,
//                                   "score":myDataTest.score,
//                                 });
//                                 formKey.currentState!.reset();
//                               }
//                             },
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             );
//           }
//           return Scaffold(
//             body: Center(
//               child: CircularProgressIndicator(),
//             ),
//           );
//         });
//   }
// }
