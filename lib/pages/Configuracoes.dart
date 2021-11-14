import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:love_bank_messeger/pages/auth/recuperaDadosUsuario.dart';
import 'package:love_bank_messeger/pages/auth/usuarioLogado.dart';
import 'dart:io';

import 'package:love_bank_messeger/shared/components/button.dart';
import 'package:love_bank_messeger/shared/components/input.dart';
import 'package:love_bank_messeger/shared/components/snackbarCustom.dart';
import 'package:love_bank_messeger/shared/functions/errorPtBr.dart';
import 'package:validadores/Validador.dart';

class Configuracoes extends StatefulWidget {
  const Configuracoes(this.onSubmit);
  final ValueChanged<String> onSubmit;
  @override
  _ConfiguracoesState createState() => _ConfiguracoesState();
}

class _ConfiguracoesState extends State<Configuracoes> {
  TextEditingController _controllerNome = TextEditingController();
  bool _loading = false;
  bool _loadingChange = false;
  File _imagem;
  String _idUsuarioLogado;
  String _urlImagemRecuperada;
  String _name = '';
  bool _submitted = false;
  final _formKey = GlobalKey<FormState>();

  Future _recuperarImagem(String origemImagem) async {
    File imagemSelecionada;
    switch (origemImagem) {
      case "camera":
        imagemSelecionada =
            await ImagePicker.pickImage(source: ImageSource.camera);
        break;
      case "galeria":
        imagemSelecionada =
            await ImagePicker.pickImage(source: ImageSource.gallery);
        break;
    }

    setState(() {
      _imagem = imagemSelecionada;
      if (_imagem != null) {
        _loading = true;
        _uploadImagem();
      }
    });
  }

  void _submit() {
    setState(() => _submitted = true);
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      _atualizarNomeFirestore();
      FocusScope.of(context).requestFocus(new FocusNode());

    }
  }

  Future _uploadImagem() async {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference pastaRaiz = storage.ref();
    Reference arquivo =
        pastaRaiz.child("perfil").child(_idUsuarioLogado + ".jpg");

    UploadTask task = arquivo.putFile(_imagem);

    task.snapshotEvents.listen((TaskSnapshot snapshot) {
      print(snapshot);
      if (snapshot.state == TaskState.running) {
        setState(() {
          _loading = true;
        });
      } else if (snapshot.state == TaskState.success) {
        _recuperarUrlImagem(snapshot).then((value) => setState(() {
          _loading = false;
        }));
      }
    });

  }

  @override
  void initState() {
    super.initState();
    UsuarioLogado().deslogado(context);
    setState(() {
      _loading = true;
    });
    RecuperaDadosUsuario().dadosUsuario().then((value) {
      setState(() {
        _idUsuarioLogado = value['uid'];
        _controllerNome.text = value['nome'];
        _urlImagemRecuperada = value['urlImagem'];
        _loading = false;
      });
    });
  }

  Future _recuperarUrlImagem(TaskSnapshot snapshot) async {
    String url = await snapshot.ref.getDownloadURL();
    _atualizarUrlImagemFirestore(url);

    setState(() {
      _urlImagemRecuperada = url;
    });
  }

  _atualizarNomeFirestore() {
    setState(() {
      _loadingChange = true;
    });
    String nome = _controllerNome.text;
    FirebaseFirestore db = FirebaseFirestore.instance;

    Map<String, dynamic> dadosAtualizar = {"nome": nome};

    db
        .collection("usuarios")
        .doc(_idUsuarioLogado)
        .update(dadosAtualizar)
        .then((value) => SnackbarCustom().createSnackBar("Alterado com sucesso", Colors.green, context))
        .catchError((error) {
      SnackbarCustom().createSnackBarErrorFirebase('auth/' + error.code, Colors.red, context);
      print(ErrorPtBr().verificaCodeErro('auth/' + error.code));
    }).whenComplete(() {
      setState(() {
        _loadingChange = false;
      });
    });
  }

  _atualizarUrlImagemFirestore(String url) {
    FirebaseFirestore db = FirebaseFirestore.instance;

    Map<String, dynamic> dadosAtualizar = {"urlImagem": url};

    db.collection("usuarios").doc(_idUsuarioLogado).update(dadosAtualizar);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Configurações"),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  _loading
                      ? Padding(
                    padding: const EdgeInsets.all(84.0),
                    child: CircularProgressIndicator(),
                  )
                      : CircleAvatar(
                      radius: 100,
                      backgroundColor: Colors.grey,
                      backgroundImage: _urlImagemRecuperada != null
                          ? NetworkImage(_urlImagemRecuperada)
                          : null),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.all(8),
                          child: GestureDetector(
                              child: Icon(Icons.camera_alt,
                                  color: Colors.deepPurple, size: 48),
                              onTap: () {
                                _recuperarImagem("camera");
                              })),
                      Padding(
                          padding: EdgeInsets.all(8),
                          child: GestureDetector(
                              child: Icon(Icons.image,
                                  color: Colors.deepPurple, size: 48),
                              onTap: () {
                                _recuperarImagem("galeria");
                              })),
                    ],
                  ),
                  Input(
                    controller: _controllerNome,
                    icon: Icons.person,
                    validator: (text) {
                      return Validador()
                          .add(Validar.OBRIGATORIO)
                          .minLength(6, msg: 'Min de 3 caracteres')
                          .maxLength(50, msg: 'Max de 50 caracteres')
                          .valido(text);
                    },
                  ),
                  _loadingChange
                      ? CircularProgressIndicator()
                      : Button(
                    label: 'Salvar',
                    tap: _name.isEmpty ? _submit : null,
                  ),
                ],
              ),
            )
          ),
        ),
      ),
    );
  }
}
