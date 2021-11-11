// ignore: file_names
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:love_bank_messeger/pages/auth/Login.dart';
import 'package:love_bank_messeger/shared/components/button.dart';
import 'package:love_bank_messeger/shared/components/input.dart';
import 'package:love_bank_messeger/shared/functions/errorPtBr.dart';
import 'package:validadores/Validador.dart';

class Forget extends StatefulWidget {
  const Forget({Key? key, required this.onSubmit}) : super(key: key);
  final ValueChanged<String> onSubmit;

  @override
  _ForgetState createState() => _ForgetState();
}

class _ForgetState extends State<Forget> {
  TextEditingController _controllerEmail = TextEditingController();
  bool _submitted = false;
  String _name = '';
  final _formKey = GlobalKey<FormState>();

  void dispose() {
    super.dispose();
  }

  void _submit() {
    setState(() => _submitted = true);
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      _esqueceuSenha(_controllerEmail.text);
      FocusScope.of(context).requestFocus(new FocusNode());
    }
  }

  Future<void> _esqueceuSenha(email) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    auth.sendPasswordResetEmail(email: email).catchError((error) {
      createSnackBar(
          ErrorPtBr().verificaCodeErro('auth/' + error.code), Colors.red);
      _controllerEmail.text = '';
      print(ErrorPtBr().verificaCodeErro('auth/' + error.code));
    }).whenComplete(() {
      createSnackBar('Sucesso! Senha enviada com sucesso.', Colors.green);
    });
  }

  void createSnackBar(String message, cor) {
    final snackBar =
        new SnackBar(content: new Text(message), backgroundColor: cor);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Esqueceu a senha'),
        backgroundColor: Color(0xff6241A0),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () =>
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Login(onSubmit: (String value) {})))
        ),
      ),
      body: Container(
          child: SingleChildScrollView(
              child: Form(
        key: _formKey,
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
            Input(
                label: 'Email',
                submit: _submitted,
                name: (text) => setState(() => _name = text),
                type: TextInputType.emailAddress,
                controller: _controllerEmail,
                validator: (text) {
                  return Validador()
                      .add(Validar.EMAIL, msg: 'Email inválido')
                      .valido(text);
                },
                icon: Icons.email),
            Button(
              label: 'Login',
              tap: _name.isNotEmpty ? _submit : null,
            ),
          ],
        ),
      ))),
    );
  }
}
