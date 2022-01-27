// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/model/Ingredient.dart';
import 'package:form_field_validator/form_field_validator.dart';

class AddIngredient extends StatefulWidget {
  const AddIngredient({Key? key}) : super(key: key);

  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<AddIngredient> {
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        myingredient.expiry_date = selectedDate;
      });
  }

  final formKey = GlobalKey<FormState>();
  Ingredient myingredient = Ingredient();
  // เตรียม Firebase
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  CollectionReference _dataCollection =
      FirebaseFirestore.instance.collection("ingredient");

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: firebase,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
                appBar: AppBar(
                  title: Text("Error"),
                ),
                body: Center(
                  child: Text("${snapshot.error}"),
                ));
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              appBar: AppBar(
                title: Text("เพิ่มวัตถุดิบ"),
              ),
              body: Container(
                padding: EdgeInsets.all(20),
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "ชื่อวัตถุดิบ",
                          style: TextStyle(fontSize: 20),
                        ),
                        TextFormField(
                          maxLength: 25,
                          validator: RequiredValidator(
                              errorText: "กรุณาป้อนข้อมูลชื่อวัตถุดิบ"),
                          onSaved: (String? ingredient_name) {
                            myingredient.ingredient_name = ingredient_name;
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Text(
                              "วันหมดอายุ = ",
                              style: TextStyle(fontSize: 20),
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              "${selectedDate.toLocal()}".split(' ')[0],
                              style: TextStyle(fontSize: 17),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () => _selectDate(context),
                          child: Text('เลือกวันหมดอายุ'),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "ปริมาณ",
                          style: TextStyle(fontSize: 20),
                        ),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          validator: MultiValidator([
                            RequiredValidator(
                                errorText: "กรุณาป้อนข้อมูลปริมาณ")
                          ]),
                          onSaved: (String? quantity) {
                            myingredient.quantity = quantity;
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Comment",
                          style: TextStyle(fontSize: 20),
                        ),
                        TextFormField(
                          maxLength: 100,
                          onSaved: (String? comment) {
                            myingredient.comment = comment;
                          },
                        ),
                        Text(
                          "URL รูปภาพ",
                          style: TextStyle(fontSize: 20),
                        ),
                        TextFormField(
                          validator: MultiValidator([
                            RequiredValidator(
                                errorText: "กรุณาป้อนข้อมูล URL รูปภาพ")
                          ]),
                          onSaved: (String? picture) {
                            myingredient.picture = picture;
                          },
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            child: Text(
                              "บันทึก",
                              style: TextStyle(fontSize: 20),
                            ),
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                formKey.currentState!.save();
                                await _dataCollection.add({
                                  "ingredient_name":
                                      myingredient.ingredient_name,
                                  "expiry_date": myingredient.expiry_date,
                                  "quantity": myingredient.quantity,
                                  "comment": myingredient.comment,
                                  "picture": myingredient.picture,
                                });
                                formKey.currentState!.reset();
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
