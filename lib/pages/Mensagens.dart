import 'dart:async';

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
  final _controllerStream = StreamController<QuerySnapshot>.broadcast();
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    RecuperaDadosUsuario().dadosUsuario().then((value) {
      setState(() {
        _idUsuarioLogado = value['uid'];
        _adicionarListenerMensagens();

      });
    });
  }

  Stream<QuerySnapshot> _adicionarListenerMensagens() {
    final stream = db
        .collection("mensagens")
        .doc(_idUsuarioLogado)
        .collection(widget.contato.uid)
        .orderBy('data', descending: true)
        .snapshots();

    stream.listen((dados) {
      _controllerStream.add(dados);
      Timer(Duration(seconds: 1), (){
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      } );
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
                  ListaMensagens(_idUsuarioLogado, widget.contato.uid, _controllerStream, _scrollController),
                  CaixaMensagens(_idUsuarioLogado, widget.contato.uid, contato: widget.contato),
                ],
              ),
            )
        ),
      ),
    );
  }
}