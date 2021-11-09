// ignore: file_names
import 'package:flutter/material.dart';
import 'package:love_bank_messeger/Login.dart';
import 'package:love_bank_messeger/shared/button.dart';
import 'package:love_bank_messeger/shared/input.dart';

class Cadastro extends StatefulWidget {
  @override
  _CadastroState createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff6241A0),
        title: Text('Cadastro'),
      ),
      body: Container(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          verticalDirection: VerticalDirection.down,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.30,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: ExactAssetImage("imagens/body_section.png"),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(144, 74, 144, 74),
                  child: Image.asset(
                    'imagens/logo_coracao.png',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 16),
              child: Center(
                child: Text(
                  'Registre-se',
                  style: TextStyle(
                    fontSize: 32.0,
                  ),
                ),
              ),
            ),
            Input(
                label: 'Nome',
                type: TextInputType.text,
                autofocus: true,
                icon: Icons.account_circle),
            Input(
                label: 'Email',
                type: TextInputType.emailAddress,
                icon: Icons.email),
            Input(
              label: 'Senha',
              type: TextInputType.text,
              obscureText: true,
              icon: Icons.lock,
            ),
            Input(
              label: 'Confirmar Senha',
              type: TextInputType.text,
              obscureText: true,
              icon: Icons.lock,
            ),
            Button(label: 'Cadastrar', tap: () {}),
          ],
        ),
      )),
    );
  }
}
