import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:love_bank_messeger/pages/auth/Forget.dart';
import 'package:love_bank_messeger/pages/auth/Login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    theme: ThemeData(primarySwatch: Colors.deepPurple),
    home: Login(onSubmit: (String value)  {}),
    debugShowCheckedModeBanner: false,
  ));
}
