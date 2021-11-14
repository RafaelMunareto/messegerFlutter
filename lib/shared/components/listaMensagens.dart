import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ListaMensagens extends StatefulWidget {
  final idUsuarioLogado;
  final idUsuarioDestinatario;
  FirebaseFirestore db = FirebaseFirestore.instance;

  ListaMensagens(this.idUsuarioLogado, this.idUsuarioDestinatario);

  @override
  _ListaMensagensState createState() => _ListaMensagensState();
}

class _ListaMensagensState extends State<ListaMensagens> {
  final _controller = StreamController<QuerySnapshot>.broadcast();

  Stream<QuerySnapshot> _adicionarListenerMensagens() {
    final stream = widget.db
        .collection("mensagens")
        .doc(widget.idUsuarioLogado)
        .collection(widget.idUsuarioDestinatario)
        .orderBy('data', descending: true)
        .snapshots();

    stream.listen((dados) {
      _controller.add(dados);
    });

  }


  @override
  Widget build(BuildContext context) {
    _adicionarListenerMensagens();
    return StreamBuilder(
      stream: _controller.stream,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Center(
              child: Column(
                children: <Widget>[
                  Text(
                    "Carregando mensagens",
                    style: TextStyle(color: Colors.white),
                  ),
                  CircularProgressIndicator()
                ],
              ),
            );
            break;
          case ConnectionState.active:
          case ConnectionState.done:
            QuerySnapshot querySnapshot = snapshot.data;

            if (snapshot.hasError) {
              return Expanded(
                child: Text("Erro ao carregar os dados!"),
              );
            }

            return Expanded(
              child: ListView.builder(
                  itemCount: querySnapshot.docs.length,
                  itemBuilder: (context, indice) {
                    List<DocumentSnapshot> mensagens =
                        querySnapshot.docs.toList();
                    DocumentSnapshot item = mensagens[indice];

                    double larguraContainer =
                        MediaQuery.of(context).size.width * 0.8;

                    Alignment alinhamento = Alignment.centerRight;
                    Color corUm = Color(0xffe4dcf2);
                    Color corDois = Color(0xff8e6bd6);
                    if (widget.idUsuarioLogado != item["idUsuario"]) {
                      alinhamento = Alignment.centerLeft;
                      corUm = Colors.white;
                      corDois = Colors.white;
                    }

                    return Align(
                      alignment: alinhamento,
                      child: Padding(
                        padding: EdgeInsets.all(6),
                        child: Container(
                          width: larguraContainer,
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  corUm,
                                  corDois,
                                ],
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          child: item["tipo"] == "texto"
                              ? Text(
                                  item["mensagem"],
                                  style: TextStyle(fontSize: 18),
                                )
                              : Image.network(item["urlImagem"]),
                        ),
                      ),
                    );
                  }),
            );

            break;
        }
      },
    );
  }
}
