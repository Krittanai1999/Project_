import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/screen/addingredient.dart';
import 'package:flutter_firebase/screen/display.dart';
import 'package:flutter_firebase/screen/foodmenu.dart';
import 'package:flutter_firebase/screen/formscreen.dart';

class NavigationDrawerWidget extends StatelessWidget {
  final padding = EdgeInsets.symmetric(horizontal: 15, vertical: 50);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Colors.blue,
        child: ListView(
          padding: padding,
          children: <Widget>[
            const SizedBox(height: 12),
            buildMenuItem(
                text: "หน้าหลัก",
                icon: Icons.home,
                onClicked: () => selectedItem(context, 0)),
            const SizedBox(height: 12),
            buildMenuItem(
                text: "เพิ่มวัตถุดิบ",
                icon: Icons.add,
                onClicked: () => selectedItem(context, 1)),
            const SizedBox(height: 12),
            Divider(color: Colors.white70),
            const SizedBox(height: 12),
            buildMenuItem(
              text: "เมนูอาหาร",
              icon: Icons.menu_book,
              onClicked: () => selectedItem(context, 2),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    final color = Colors.white;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: TextStyle(color: color)),
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();
    switch (index) {
      case 0:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => DisplayScreen(),
        ));
        break;
      case 1:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AddIngredient(),
        ));
        break;
      case 2:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => FoodMenu(),
        ));
        break;
    }
  }
}
