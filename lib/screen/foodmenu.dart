import 'package:flutter/material.dart';

class FoodMenu extends StatefulWidget {
  const FoodMenu({ Key? key }) : super(key: key);

  @override
  _FoodMenuState createState() => _FoodMenuState();
}

class _FoodMenuState extends State<FoodMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("เมนูอาหาร")),
      body: Text("Available"),
      
    );
  }
}