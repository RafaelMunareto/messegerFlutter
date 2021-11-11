// ignore: file_names
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:love_bank_messeger/pages/auth/Login.dart';
import 'package:love_bank_messeger/shared/components/button.dart';
import 'package:love_bank_messeger/shared/components/input.dart';
import 'package:love_bank_messeger/shared/components/loading.dart';
import 'package:love_bank_messeger/shared/functions/errorPtBr.dart';
import 'package:love_bank_messeger/shared/model/Usuario.dart';
import 'package:validadores/Validador.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({Key? key, required this.onSubmit}) : super(key: key);
  final ValueChanged<String> onSubmit;

  @override
  _CadastroState createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  TextEditingController _controllerNome = TextEditingController();
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
      Usuario usuario = Usuario(
        _controllerNome.text,
        _controllerEmail.text,
        _controllerSenha.text,
      );
      _cadastrarUsuario(usuario);
      FocusScope.of(context).requestFocus(new FocusNode());
    }
  }

  Future<void> _cadastrarUsuario(Usuario usuario) async {
    setState(() {
      _isLoading = true;
    });

    FirebaseAuth auth = FirebaseAuth.instance;

    auth
        .createUserWithEmailAndPassword(
            email: usuario.email, password: usuario.senha)
        .then((firebaseUser) {
      firebaseUser.user!.updateDisplayName(usuario.nome).then((value) {
        createSnackBar('Email de validaçao enviado com sucesso.', Colors.green);
      }).then((value) => Navigator.push(context, MaterialPageRoute(builder: (context) => Login(onSubmit: (String value) {  },))));
    }).catchError((error) {
      createSnackBar(
          ErrorPtBr().verificaCodeErro('auth/' + error.code), Colors.red);
      _controllerNome.text = '';
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
      appBar: AppBar(
        title: Text('Cadastro'),
        backgroundColor: Color(0xff6241A0),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: _isLoading ? Loading() : Container(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    verticalDirection: VerticalDirection.down,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 8),
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
                          submit: _submitted,
                          controller: _controllerNome,
                          name: (text) => setState(() => _name = text),
                          validator: (text) {
                            return Validador()
                                .add(Validar.OBRIGATORIO)
                                .minLength(3, msg: 'Min de 3 caracteres')
                                .maxLength(50, msg: 'Max de 50 caracteres')
                                .valido(text);
                          },
                          icon: Icons.account_circle),
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
                      Input(
                        label: 'Confirmar Senha',
                        type: TextInputType.text,
                        submit: _submitted,
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
                        label: 'Cadastrar',
                        tap: _name.isNotEmpty ? _submit : null,
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
