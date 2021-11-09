// ignore: file_names
import 'package:flutter/material.dart';
import 'package:love_bank_messeger/shared/button.dart';
import 'package:love_bank_messeger/shared/input.dart';

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
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          verticalDirection: VerticalDirection.down,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 16),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.20,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: ExactAssetImage("imagens/top_section.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 32),
              child: Image.asset('imagens/logo.png', width: 120, height: 120),
            ),
            Input(
                label: 'Email',
                type: TextInputType.emailAddress,
                autofocus: true,
                icon: Icons.account_circle),
            Input(
              label: 'Senha',
              type: TextInputType.text,
              obscureText: true,
              icon: Icons.lock,
            ),
            Button(label: 'Login', tap: () {}),
            Padding(
                padding: EdgeInsets.only(bottom: 24),
                child: Center(
                    child: GestureDetector(
                  onTap: () {},
                  child: Text("Esqueceu a senha?",
                      style: TextStyle(color: Color(0xff593799), fontSize: 18)),
                ))),
            Padding(
                padding: EdgeInsets.only(bottom: 32),
                child: Center(
                    child: GestureDetector(
                  onTap: () {},
                  child: Text("Não possui conta? Cadastra-se!",
                      style: TextStyle(color: Color(0xff593799), fontSize: 16)),
                )))
          ],
        ),
      )),
    );
  }
}
