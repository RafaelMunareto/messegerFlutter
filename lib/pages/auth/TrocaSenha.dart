// ignore: file_names
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:love_bank_messeger/RouteGenerator.dart';
import 'package:love_bank_messeger/shared/components/button.dart';
import 'package:love_bank_messeger/shared/components/input.dart';
import 'package:love_bank_messeger/shared/components/loading.dart';
import 'package:love_bank_messeger/shared/functions/errorPtBr.dart';
import 'package:validadores/Validador.dart';

class TrocaSenha extends StatefulWidget {
  const TrocaSenha(this.onSubmit);
  final ValueChanged<String> onSubmit;

  @override
  _TrocaSenhaState createState() => _TrocaSenhaState();
}

class _TrocaSenhaState extends State<TrocaSenha> {
  TextEditingController _controllerConfirmSenha = TextEditingController();
  TextEditingController _controllerSenha = TextEditingController();
  bool _submitted = false;
  String _name = '';
  bool _isLoading = false;
  String code = '';
  final _formKey = GlobalKey<FormState>();

  void dispose() {
    super.dispose();
  }

  void _submit() {
    setState(() => _submitted = true);
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      _alteraSenha(_controllerSenha.text, code);
      FocusScope.of(context).requestFocus(new FocusNode());
    }
  }

  Future<void> _alteraSenha(password, code) async {
    setState(() {
      _isLoading = true;
    });

    FirebaseAuth auth = FirebaseAuth.instance;

    auth
        .confirmPasswordReset(newPassword: password, code: code)
        .then((firebaseUser) {
      Navigator.pushReplacementNamed(context, RouteGenerator.LOGIN);
    }).catchError((error) {
      createSnackBar(
          ErrorPtBr().verificaCodeErro('auth/' + error.code), Colors.red);
      _controllerSenha.text = '';
      _controllerConfirmSenha.text = '';
      print(ErrorPtBr().verificaCodeErro('auth/' + error.code));
    }).whenComplete(() {
      setState(() {
        _isLoading = false;
      });
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
        title: Text('Trocar senha'),
        backgroundColor: Color(0xff6241A0),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () =>  Navigator.pushReplacementNamed(context, RouteGenerator.LOGIN)
        ),
      ),
      body: _isLoading
          ? Loading()
          : Container(
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
                    label: 'Senha',
                    submit: _submitted,
                    type: TextInputType.text,
                    name: (text) => setState(() => _name = text),
                    obscureText: true,
                    controller: _controllerSenha,
                    validator: (text) {
                      return Validador()
                          .add(Validar.OBRIGATORIO)
                          .minLength(6, msg: 'Min de 6 caracteres')
                          .maxLength(50, msg: 'Max de 50 caracteres')
                          .valido(text);
                    },
                    icon: Icons.lock,
                  ),
                  Input(
                    label: 'Confirmar Senha',
                    type: TextInputType.text,
                    submit: _submitted,
                    controller: _controllerConfirmSenha,
                    name: (text) => setState(() => _name = text),
                    obscureText: true,
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return '[Campo Obrigatório]';
                      }
                      if (_controllerSenha.value.text != text) {
                        return 'As senhas devem ser iguais';
                      }
                      return null;
                    },
                    icon: Icons.lock,
                  ),
                  Button(
                    label: 'Alterar',
                    tap: _name.isNotEmpty ? _submit : null,
                  ),
                  Padding(
                      padding: EdgeInsets.only(bottom: 24),
                      child: Center(
                          child: GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(context, RouteGenerator.LOGIN);
                        },
                        child: Text("Login",
                            style: TextStyle(
                                color: Color(0xff593799), fontSize: 18)),
                      ))),
                ],
              ),
            ))),
    );
  }
}
