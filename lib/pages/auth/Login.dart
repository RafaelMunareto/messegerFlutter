// ignore: file_names
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:love_bank_messeger/pages/auth/Cadastro.dart';
import 'package:love_bank_messeger/pages/Home.dart';
import 'package:love_bank_messeger/pages/auth/Forget.dart';
import 'package:love_bank_messeger/shared/components/button.dart';
import 'package:love_bank_messeger/shared/components/input.dart';
import 'package:love_bank_messeger/shared/components/loading.dart';
import 'package:love_bank_messeger/shared/functions/errorPtBr.dart';
import 'package:love_bank_messeger/shared/model/Credentials.dart';
import 'package:validadores/Validador.dart';

class Login extends StatefulWidget {
  const Login({Key? key, required this.onSubmit}) : super(key: key);
  final ValueChanged<String> onSubmit;
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerSenha = TextEditingController();
  bool _submitted = false;
  String _name = '';
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();

  void dispose() {
    super.dispose();
  }

  void _submit() {
    setState(() => _submitted = true);
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Credentials credencials = Credentials(
        _controllerEmail.text,
        _controllerSenha.text,
      );
      _loginUsuario(credencials);
      FocusScope.of(context).requestFocus(new FocusNode());

    }
  }

  Future<void> _loginUsuario(Credentials credentials) async {
    setState(() {
      _isLoading = true;
    });

    FirebaseAuth auth = FirebaseAuth.instance;

    auth
        .signInWithEmailAndPassword(
        email: credentials.email, password: credentials.senha)
        .then((firebaseUser) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
    }).catchError((error) {
      createSnackBar(
          ErrorPtBr().verificaCodeErro('auth/' + error.code), Colors.red);
      _controllerEmail.text = '';
      _controllerSenha.text = '';
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
      body:  _isLoading ? Loading() :  Container(
          child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child:  Column(
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
              Button(
                label: 'Login',
                tap: _name.isNotEmpty ? _submit : null,
              ),
              Padding(
                  padding: EdgeInsets.only(bottom: 24),
                  child: Center(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Forget(onSubmit: (String value) {  },)));
                        },
                        child: Text("Esqueceu a senha?",
                            style: TextStyle(color: Color(0xff593799), fontSize: 18)),
                      ))),
              Padding(
                  padding: EdgeInsets.only(bottom: 32),
                  child: Center(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Cadastro(onSubmit: (String value) {  },)));
                        },
                        child: Text("Não possui conta? Cadastra-se!",
                            style: TextStyle(color: Color(0xff593799), fontSize: 16)),
                      )))
            ],
          ),
        )
      )),
    );
  }
}

