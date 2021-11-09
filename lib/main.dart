import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:love_bank_messeger/Home.dart';
import 'package:love_bank_messeger/Login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    theme: ThemeData(primaryColor: Color(0xff593799)),
    home: Login(),
    debugShowCheckedModeBanner: false,
  ));
}
