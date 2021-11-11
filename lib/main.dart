import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:love_bank_messeger/RouteGenerator.dart';
import 'package:love_bank_messeger/pages/Home.dart';
import 'package:love_bank_messeger/pages/auth/Login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseAuth auth = FirebaseAuth.instance;
  var uid = await auth.currentUser.uid;

  runApp(MaterialApp(

    navigatorKey: GlobalKey(),
    theme: ThemeData(primarySwatch: Colors.deepPurple),
    home: uid == null ? Login((_) {}) : Home(),
    debugShowCheckedModeBanner: false,
    initialRoute: "/",
    onGenerateRoute: RouteGenerator.generateRoute,

  ));
}
