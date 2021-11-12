// ignore: file_names
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:love_bank_messeger/RouteGenerator.dart';

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


  @override
  Widget build(BuildContext context) {

    Timer(Duration(seconds: 3), () =>  Navigator.pushReplacementNamed(context, RouteGenerator.LOGIN));

    return Scaffold(
        appBar: AppBar(
          title: Text('Login'),
          backgroundColor: Color(0xff6241A0),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () =>
                Navigator.pushReplacementNamed(context, RouteGenerator.LOGIN)
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
