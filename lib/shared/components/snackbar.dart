import 'package:flutter/material.dart';

class Snackbar {
  final context;

  Snackbar(this.context);

  void createSnackBar(String message) {
    final snackBar = new SnackBar(content: new Text(message),
        backgroundColor: Colors.red);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
