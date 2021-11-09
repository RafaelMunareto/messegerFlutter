// ignore: file_names
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(color: Color(0xfff0eaf9)),
      padding: EdgeInsets.all(16),
      child: Center(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 32),
              child: Image.asset('imagens/logo.png', width: 200, height: 150),
            ),
            Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: TextField(
                    autofocus: true,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                        hintText: 'E-mail',
                        filled: true,
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color(0xff593799), width: 2),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32))))),
            Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                        hintText: 'Senha',
                        filled: true,
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color(0xff593799), width: 2),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32))))),
            Padding(
                padding: EdgeInsets.only(bottom: 8, right: 12),
                child: Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {},
                      child: Text("Esqueceu a senha",
                          style: TextStyle(color: Color(0xff593799))),
                    ))),
            Padding(
              padding: EdgeInsets.only(top: 16, bottom: 10),
              child: ElevatedButton(
                child: Text(
                  "Entrar",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                style: ElevatedButton.styleFrom(
                    primary: Color(0xff593799), // background
                    onPrimary: Color(0xff593799),
                    padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                    shape: new RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0))),
                onPressed: () {},
              ),
            ),
            Padding(
                padding: EdgeInsets.only(bottom: 32),
                child: Center(
                    child: GestureDetector(
                  onTap: () {},
                  child: Text("Não tem conta? Cadastra-se!",
                      style: TextStyle(color: Color(0xff593799))),
                )))
          ],
        ),
      )),
    ));
  }
}
