import 'package:flutter/material.dart';
import 'package:love_bank_messeger/RouteGenerator.dart';
import 'package:love_bank_messeger/pages/abas/AbaContatos.dart';
import 'package:love_bank_messeger/pages/abas/AbaMensagens.dart';
import 'package:love_bank_messeger/pages/auth/recuperaDadosUsuario.dart';

import 'auth/usuarioLogado.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  String _nome = '';
  TabController _tabController;
  List<String> itensMenu = [
    "Configurações", "Deslogar"
  ];


  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = ElevatedButton(
      child: Text("Cancelar"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = ElevatedButton(
      child: Text("Sair"),
      onPressed: () {
        UsuarioLogado().deslogar(context);
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Logout"),
      content: Text("Tem certeza que deseja sair ${_nome}? "),
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
    UsuarioLogado().deslogado(context);
    RecuperaDadosUsuario().dadosUsuario().then((value) {
      setState(() {
        _nome = value['nome'];
      });
    });
    super.initState();


    _tabController = TabController(
      initialIndex: 0,
      length: 2,
      vsync: this,
    );
  }

  _escolhaMenuItem(String itemEscolhido){

    switch( itemEscolhido ){
      case "Configurações":
        Navigator.pushNamed(context, RouteGenerator.CONFIGURACOES);
        break;
        break;
      case "Deslogar":
        showAlertDialog(context);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("LoveBank"),
        leading: Icon(Icons.all_inbox),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: _escolhaMenuItem,
            itemBuilder: (context){
              return itensMenu.map((String item){
                return PopupMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList();
            },
          )
        ],
        bottom: TabBar(
          indicatorWeight: 4,
          labelStyle: TextStyle(
            fontSize: 18,
          ),
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: <Widget>[Tab(text: "Mensagens"), Tab(text: "Contatos")],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[AbaMensagens(), AbaContatos()],
      ),
    );
  }
}
