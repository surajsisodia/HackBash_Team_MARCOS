import 'package:IIIT_Surat_Connect/facultyContact.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'authScreens/login.dart';
import 'package:firebase_core/firebase_core.dart';
=======
>>>>>>> 1d0d7b2906dfa9cebd73bb0484f0c69e60691869

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
      home: FacultyContact(),
    );
  }
}
