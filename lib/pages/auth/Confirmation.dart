// ignore: file_names
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:love_bank_messeger/pages/auth/Login.dart';
import 'package:love_bank_messeger/shared/functions/errorPtBr.dart';

class Confirmation extends StatefulWidget {
  @override
  _ConfirmationState createState() => _ConfirmationState();
}

class _ConfirmationState extends State<Confirmation> {
  String code = '';

  void initial()
  {
    _confirmation(code);
  }

  Future<void> _confirmation(code) async {}

  void createSnackBar(String message, cor) {
    final snackBar =
    new SnackBar(content: new Text(message), backgroundColor: cor);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }



  @override
  Widget build(BuildContext context) {

    Timer(Duration(seconds: 3), () => Navigator.push(context, MaterialPageRoute(builder: (context) => Login(onSubmit: (String value) {}))));

    return Scaffold(
        appBar: AppBar(
          title: Text('Login'),
          backgroundColor: Color(0xff6241A0),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Login(
                          onSubmit: (String value) {},
                        ))),
          ),
        ),
        body: Container(
          transformAlignment: Alignment.center,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: ExactAssetImage("imagens/body_section.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Container(
                padding: EdgeInsets.all(64),
                child: Text(
              "Seu email foi confirmado com sucesso!", textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, color: Colors.white),
            )),
          ),
        ));
  }
}
