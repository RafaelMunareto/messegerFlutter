import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:love_bank_messeger/pages/auth/Login.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String? _nameUsuario= "";

  Future _recuperarDadosUsuario() async {

    FirebaseAuth auth = FirebaseAuth.instance;
    User? usuarioLogado = await auth.currentUser;

    setState(() {
      _nameUsuario = usuarioLogado!.displayName;
    });

  }


    showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = ElevatedButton(
      child: Text("Cancelar"),
      onPressed:  () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = ElevatedButton(
      child: Text("Sair"),
      onPressed:  () {
        FirebaseAuth auth = FirebaseAuth.instance;
        auth.signOut().then((value) => Navigator.push(context, MaterialPageRoute(builder: (context) => Login(onSubmit: (String value) {  }))));

      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Logout"),
      content: Text("Tem certeza que deseja sair ${_nameUsuario}? "),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  void initState() {
    _recuperarDadosUsuario();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Cadastro'),
          backgroundColor: Color(0xff6241A0),
          actions: [
            IconButton(onPressed: () {
              showAlertDialog(context);
            }, icon: Icon(Icons.logout) )
          ],
        ),
        body: Container(
          padding: EdgeInsets.all(16),
          child: Center(
              child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 32),
                  child: Image.asset('imagens/logo.png', width: 200, height: 150),
                )
              ],
            ),
          )),
        ));
  }
}
