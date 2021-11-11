import 'package:flutter/material.dart';

class Input extends StatefulWidget {
  final label;
  final type;
  final obscureText;
  final autofocus;
  final icon;
  final controller;
  final validator;
  final submit;
  final name;
  Input(
      {this.label,
        this.type,
        this.name,
        this.obscureText = false,
        this.autofocus = false,
        this.validator,
        this.submit = false,
        this.icon,
        this.controller});

  @override
  _InputState createState() => _InputState();
}

class _InputState extends State<Input> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16, bottom: 12),
      child: TextFormField(
        controller: widget.controller,
        autofocus: widget.autofocus,
        keyboardType: widget.type,
        obscureText: widget.obscureText,
        autovalidateMode: widget.submit
            ? AutovalidateMode.onUserInteraction
            : AutovalidateMode.disabled,
        style: TextStyle(fontSize: 16),
        validator: widget.validator,
        onChanged: widget.name,
        decoration: InputDecoration(
          prefixIcon: Icon(widget.icon, color: Colors.grey),
          contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
          labelText: widget.label,
          filled: true,
          fillColor: Color(0xffefeef2),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xff593799), width: 2),
            borderRadius: BorderRadius.circular(25.0),
          ),
          errorBorder: new OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red, width: 2),
            borderRadius: BorderRadius.circular(25.0),
          ),
          focusedErrorBorder: new OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red, width: 2),
            borderRadius: BorderRadius.circular(25.0),
          ),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32),
            borderSide: BorderSide(color: Color(0xffefeef2), width: 0),
          ),
        ),
      ),
    );
  }
}