import 'package:IIIT_Surat_Connect/mainMenu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'authScreens/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HackBash',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Router(),
    );
  }
}

class Router extends StatefulWidget {
  @override
  _RouterState createState() => _RouterState();
}

class _RouterState extends State<Router> {
  void route() async {
    FirebaseAuth _auth = await FirebaseAuth.instance;
    if (_auth.currentUser != null) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
    }
  }

  @override
  void initState() {
    route();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
