import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:love_bank_messeger/shared/model/Mensagem.dart';

class CaixaMensagens extends StatefulWidget {
  final _idUsuarioLogado;
  final _idUsuarioDestinatario;

  CaixaMensagens(this._idUsuarioLogado, this._idUsuarioDestinatario);
  @override
  _CaixaMensagensState createState() => _CaixaMensagensState();
}

class _CaixaMensagensState extends State<CaixaMensagens> {
  TextEditingController _controllerMensagem = TextEditingController();

  FirebaseFirestore db = FirebaseFirestore.instance;

  _enviarMensagem() {
    String textoMensagem = _controllerMensagem.text;
    if (textoMensagem.isNotEmpty) {
      Mensagem mensagem = Mensagem();
      mensagem.idUsuario = widget._idUsuarioLogado;
      mensagem.mensagem = textoMensagem;
      mensagem.urlImagem = "";
      mensagem.tipo = "texto";

      _salvarMensagem(widget._idUsuarioLogado, widget._idUsuarioDestinatario, mensagem);
    }
  }

  _enviarFoto() {}


  _salvarMensagem(String idRemetente, String idDestinatario, Mensagem msg) async {
    await db
        .collection("mensagens")
        .doc(idRemetente)
        .collection(idDestinatario)
        .add(msg.toMap());

    _controllerMensagem.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(8, 16, 8, 8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 8),
              child: TextField(
                controller: _controllerMensagem,
                autofocus: true,
                keyboardType: TextInputType.text,
                style: TextStyle(fontSize: 16),
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(32, 8, 32, 8),
                    hintText: "Digite uma mensagem...",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32)
                    ),
                    prefixIcon: IconButton(
                        icon: Icon(Icons.camera_alt, color: Colors.deepPurple,),
                        onPressed: () { _enviarFoto(); }
                    )
                ),
              ),
            ),
          ),
          FloatingActionButton(
            child: Icon(Icons.send, color: Colors.white,),
            mini: true,
            onPressed: () { _enviarMensagem(); },
          )
        ],
      ),
    );
  }
}
