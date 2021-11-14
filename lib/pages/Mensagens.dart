import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:love_bank_messeger/pages/auth/recuperaDadosUsuario.dart';
import 'package:love_bank_messeger/shared/components/caixaMensagens.dart';
import 'package:love_bank_messeger/shared/components/listaMensagens.dart';
import 'package:love_bank_messeger/shared/model/Usuario.dart';

class Mensagens extends StatefulWidget {
  Usuario contato;

  Mensagens(this.contato);

  @override
  _MensagensState createState() => _MensagensState();
}

class _MensagensState extends State<Mensagens> {

  String _idUsuarioLogado;
  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    RecuperaDadosUsuario().dadosUsuario().then((value) {
      setState(() {
        _idUsuarioLogado = value['uid'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Row(
        children: [
          CircleAvatar(
              maxRadius: 20,
              backgroundColor: Colors.grey,
              backgroundImage: widget.contato.urlImagem != null
                  ? NetworkImage(widget.contato.urlImagem)
                  : null),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(widget.contato.nome),
          ),
        ],
      ),),
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("imagens/imagem_fundo.jfif"),
                fit: BoxFit.cover
            )
        ),
        child: SafeArea(
            child: Container(
              padding: EdgeInsets.all(8),
              child: Column(
                children: <Widget>[
                  ListaMensagens(_idUsuarioLogado, widget.contato.uid),
                  CaixaMensagens(_idUsuarioLogado, widget.contato.uid, contato: widget.contato),
                ],
              ),
            )
        ),
      ),
    );
  }
}