import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_firebase/model/Ingredient.dart';
import 'package:flutter_firebase/screen/addingredient.dart';
import 'package:flutter_firebase/widget/navigation_drawer.dart';

class DisplayScreen extends StatefulWidget {
  const DisplayScreen({Key? key}) : super(key: key);

  @override
  _DisplayScreenState createState() => _DisplayScreenState();
}

class _DisplayScreenState extends State<DisplayScreen> {
  final formKey = GlobalKey<FormState>();
  Ingredient myingredient = Ingredient();
  // เตรียม Firebase
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  CollectionReference _dataCollection =
      FirebaseFirestore.instance.collection("ingredient");

  TextEditingController ingredient_nameController = TextEditingController();
  TextEditingController expirydateController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  TextEditingController pictureController = TextEditingController();

  _buildTextField(TextEditingController controller, String labelText) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          color: Colors.green[50], border: Border.all(color: Colors.blue)),
      child: TextField(
        controller: controller,
        style: TextStyle(color: Colors.blue),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            labelText: labelText,
            labelStyle: TextStyle(color: Colors.black),
            border: InputBorder.none),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(title: Text("รายการวัตถุดิบ")),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("ingredient").snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var doc = snapshot.data!.docs[index].data();

                return Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.blue,
                          Colors.blue.shade900,
                          Colors.blueAccent,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    height: 150,
                    child: Card(
                      elevation: 10,
                      margin: const EdgeInsets.all(8.0),
                      child: ListTile(
                        leading: IconButton(
                          icon: Icon(Icons.edit),
                          color: Colors.green,
                          onPressed: () {
                            ingredient_nameController.text =
                                doc["ingredient_name"];
                            // expirydateController.text = doc["expiry_date"];
                            quantityController.text = doc["quantity"];
                            commentController.text = doc["comment"];
                            // pictureController.text = doc["picture"];

                            showDialog(
                                context: context,
                                builder: (context) => Dialog(
                                        child: Container(
                                      child: ListView(
                                        shrinkWrap: true,
                                        children: <Widget>[
                                          _buildTextField(
                                              ingredient_nameController,
                                              "ingredient_name"),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          // _buildTextField(
                                          //     expirydateController, "expiry_date"),
                                          // SizedBox(
                                          //   height: 20,
                                          // ),
                                          _buildTextField(
                                              quantityController, "quantity"),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          _buildTextField(
                                              commentController, "comment"),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          // _buildTextField(
                                          //     pictureController, "picture"),
                                          // SizedBox(
                                          //   height: 20,
                                          // ),
                                          FlatButton(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(16.0),
                                                child: Text("Update"),
                                              ),
                                              color: Colors.green,
                                              onPressed: () {
                                                snapshot
                                                    .data!.docs[index].reference
                                                    .update({
                                                  "ingredient_name":
                                                      ingredient_nameController
                                                          .text,
                                                  // "expiry_date": expirydateController.text,
                                                  "quantity":
                                                      quantityController.text,
                                                  "comment":
                                                      commentController.text,
                                                  // "picture": pictureController.text,
                                                }).whenComplete(() =>
                                                        Navigator.pop(context));
                                              }),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          FlatButton(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(16.0),
                                                child: Text("Delete"),
                                              ),
                                              color: Colors.red,
                                              onPressed: () {
                                                snapshot
                                                    .data!.docs[index].reference
                                                    .delete()
                                                    .whenComplete(() =>
                                                        Navigator.pop(context));
                                              }),
                                        ],
                                      ),
                                    )));
                          },
                        ),
                        title: Text(
                          doc["ingredient_name"],
                          style: TextStyle(color: Colors.black, fontSize: 36),
                        ),
                        subtitle: Column(
                          children: <Widget>[
                            Text(
                              "วันหมดอายุ:" +
                                  " " +
                                  doc["expiry_date"].toDate().toString()[0] +
                                  doc["expiry_date"].toDate().toString()[1] +
                                  doc["expiry_date"].toDate().toString()[2] +
                                  doc["expiry_date"].toDate().toString()[3] +
                                  doc["expiry_date"].toDate().toString()[4] +
                                  doc["expiry_date"].toDate().toString()[5] +
                                  doc["expiry_date"].toDate().toString()[6] +
                                  doc["expiry_date"].toDate().toString()[7] +
                                  doc["expiry_date"].toDate().toString()[8] +
                                  doc["expiry_date"].toDate().toString()[9],
                              style: TextStyle(
                                  color: Colors.blue[900], fontSize: 16),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "ปริมาณ: " + doc["quantity"],
                              style: TextStyle(color: Colors.blue[900]),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "ข้อมูล: " + doc["comment"],
                              style: TextStyle(color: Colors.blue[900]),
                            ),
                          ],
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                        ),
                        trailing: Image.network(
                          doc['picture'],
                          height: 350,
                          // fit: BoxFit.cover,
                        ),
                      ),
                    ));
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return AddIngredient();
          }));
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
    );
  }
}
