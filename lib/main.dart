import 'package:flutter/material.dart';
import 'LandingPage.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(new BlogApp());
}

class BlogApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Notice Board",
      theme: new ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: LandingPage(),
    );
  }
}
