import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:love_bank_messeger/pages/Home.dart';
import 'package:love_bank_messeger/pages/auth/Login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseAuth auth = FirebaseAuth.instance;
  User? usuarioLogado = await auth.currentUser;

  runApp(MaterialApp(
    theme: ThemeData(primarySwatch: Colors.deepPurple),
    home: usuarioLogado == null ? Login(onSubmit: (String value)  {}) : Home(),
    debugShowCheckedModeBanner: false,
  ));
}
