import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:love_bank_messeger/pages/auth/Login.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Cadastro'),
          backgroundColor: Color(0xff6241A0),
          actions: [
            IconButton(onPressed: () {
              FirebaseAuth auth = FirebaseAuth.instance;
              auth.signOut().then((value) => Navigator.pop(context, MaterialPageRoute(builder: (context) => Login(onSubmit: (String value) {  },))));
            }, icon: Icon(Icons.logout) )
          ],
        ),
        body: Container(
          padding: EdgeInsets.all(16),
          child: Center(
              child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 32),
                  child:
                      Image.asset('imagens/logo.png', width: 200, height: 150),
                )
              ],
            ),
          )),
        ));
  }
}
