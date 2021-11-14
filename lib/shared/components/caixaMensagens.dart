import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:love_bank_messeger/shared/model/Conversa.dart';
import 'package:love_bank_messeger/shared/model/Mensagem.dart';

class CaixaMensagens extends StatefulWidget {
  final _idUsuarioLogado;
  final _idUsuarioDestinatario;
  final contato;
  final _controller = StreamController<QuerySnapshot>.broadcast();
  CaixaMensagens(this._idUsuarioLogado, this._idUsuarioDestinatario, {this.contato});

  @override
  _CaixaMensagensState createState() => _CaixaMensagensState();
}

class _CaixaMensagensState extends State<CaixaMensagens> {
  TextEditingController _controllerMensagem = TextEditingController();
  File _imagem;
  bool _subindoImagem = false;
  FirebaseFirestore db = FirebaseFirestore.instance;
  List<String> itensMenu = ["Câmera", "Galeria"];

  _enviarMensagem() {
    String textoMensagem = _controllerMensagem.text;
    if (textoMensagem.isNotEmpty) {
      Mensagem mensagem = Mensagem();
      mensagem.idUsuario = widget._idUsuarioLogado;
      mensagem.mensagem = textoMensagem;
      mensagem.urlImagem = "";
      mensagem.data = Timestamp.now().toString();
      mensagem.tipo = "texto";

      _salvarMensagem(
          widget._idUsuarioLogado, widget._idUsuarioDestinatario, mensagem);
      _salvarMensagem(
          widget._idUsuarioDestinatario, widget._idUsuarioLogado, mensagem);

      _salvarConversa(mensagem);
    }
  }


  _salvarConversa(Mensagem msg){

    //Salvar conversa remetente
    Conversa cRemetente = Conversa();
    cRemetente.idRemetente = widget._idUsuarioLogado;
    cRemetente.idDestinatario = widget._idUsuarioDestinatario;
    cRemetente.mensagem = msg.mensagem;
    cRemetente.nome = widget.contato.nome;
    cRemetente.caminhoFoto = widget.contato.urlImagem;
    cRemetente.tipoMensagem = msg.tipo;
    cRemetente.salvar();

    //Salvar conversa destinatario
    Conversa cDestinatario = Conversa();
    cDestinatario.idRemetente = widget._idUsuarioDestinatario;
    cDestinatario.idDestinatario = widget._idUsuarioLogado;
    cDestinatario.mensagem = msg.mensagem;
    cDestinatario.nome = widget.contato.nome;
    cDestinatario.caminhoFoto = widget.contato.urlImagem;
    cDestinatario.tipoMensagem = msg.tipo;
    cDestinatario.salvar();

  }

  _salvarMensagem(
      String idRemetente, String idDestinatario, Mensagem msg) async {
    await db
        .collection("mensagens")
        .doc(idRemetente)
        .collection(idDestinatario)
        .add(msg.toMap());

    //Limpa texto
    _controllerMensagem.clear();

  }

  _escolhaMenuItem(String itemEscolhido) {
    switch (itemEscolhido) {
      case "Galeria":
        this._enviarFoto('Galeria');
        break;
      case "Câmera":
        this._enviarFoto('Câmera');
        break;
    }
  }

  _enviarFoto(String origemImagem) async {
    File imagemSelecionada;
    switch (origemImagem) {
      case "Câmera":
        print(origemImagem);
        imagemSelecionada =
            await ImagePicker.pickImage(source: ImageSource.camera);
        break;
      case "Galeria":
        imagemSelecionada =
            await ImagePicker.pickImage(source: ImageSource.gallery);
        break;
    }

    _subindoImagem = true;
    String nomeImagem = DateTime.now().millisecondsSinceEpoch.toString();
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference pastaRaiz = storage.ref();
    Reference arquivo = pastaRaiz
        .child("mensagens")
        .child(widget._idUsuarioLogado)
        .child(nomeImagem + ".jpg");

    //Upload da imagem
    UploadTask task = arquivo.putFile(imagemSelecionada);

    //Controlar progresso do upload
    task.snapshotEvents.listen((TaskSnapshot snapshot) {
      print(snapshot);
      if (snapshot.state == TaskState.running) {
        setState(() {
          _subindoImagem = true;
        });
      } else if (snapshot.state == TaskState.success) {
        _recuperarUrlImagem(snapshot).then((value) => setState(() {
              _subindoImagem = false;
            }));
      }
    });

    //Recuperar url da imagem
    task.then((snapshot) {
      _recuperarUrlImagem(snapshot);
    });
  }

  Future _recuperarUrlImagem(snapshot) async {
    String url = await snapshot.ref.getDownloadURL();

    Mensagem mensagem = Mensagem();
    mensagem.idUsuario = widget._idUsuarioLogado;
    mensagem.mensagem = "";
    mensagem.data = Timestamp.now().toString();
    mensagem.urlImagem = url;
    mensagem.tipo = "imagem";

    _salvarMensagem(
        widget._idUsuarioLogado, widget._idUsuarioDestinatario, mensagem);

    _salvarMensagem(
        widget._idUsuarioDestinatario, widget._idUsuarioLogado, mensagem);
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
                  prefixIcon: GestureDetector(
                    child: Icon(Icons.camera),
                    onTap: () {
                      _enviarFoto('Câmera');
                    },
                  ),
                  suffixIcon: GestureDetector(
                    child: Icon(Icons.image),
                    onTap: () {
                      _enviarFoto('Galeria');
                    },
                  ),
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32)),
                ),
              ),
            ),

          ),
          _subindoImagem ? Expanded(child: LinearProgressIndicator()) : Container(),
          FloatingActionButton(
            child: Icon(
              Icons.send,
              color: Colors.white,
            ),
            mini: true,
            onPressed: () {
              _enviarMensagem();
            },
          )
        ],
      ),
    );
  }
}
