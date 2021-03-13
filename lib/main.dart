import 'package:IIIT_Surat_Connect/mainMenu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'authScreens/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  bool isLoggedIn;
  FirebaseAuth auth = FirebaseAuth.instance;
  User user = auth.currentUser;

  if (user == null)
    isLoggedIn = false;
  else
    isLoggedIn = true;
  runApp(MyApp(isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  MyApp(this.isLoggedIn);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'HackBash',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: isLoggedIn == true ? Home() : Login());
  }
}
