import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/screen/display.dart';
import 'package:flutter_firebase/screen/foodmenu.dart';
import 'package:flutter_firebase/widget/navigation_drawer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: NavigationDrawerWidget(),
        body: TabBarView(
          children: [DisplayScreen(), FoodMenu()],
        ),
        backgroundColor: Colors.blue,
        // bottomNavigationBar: TabBar(
        //   tabs: [
        //     Tab(
        //       child: Row(
        //         mainAxisSize: MainAxisSize.min,
        //         children: [
        //           Icon(Icons.list),
        //           const SizedBox(width: 8),
        //           Text('รายการ'),
        //         ],
        //       ),
        //     ),
        //     Tab(
        //       child: Row(
        //         mainAxisSize: MainAxisSize.min,
        //         children: [
        //           Icon(Icons.library_books),
        //           const SizedBox(width: 8),
        //           Text('เมนูอาหาร'),
        //         ],
        //       ),
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
