import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:love_bank_messeger/RouteGenerator.dart';
import 'package:love_bank_messeger/pages/auth/recuperaDadosUsuario.dart';
import 'package:love_bank_messeger/shared/model/Usuario.dart';

class AbaContatos extends StatefulWidget {
  @override
  _AbaContatosState createState() => _AbaContatosState();
}

class _AbaContatosState extends State<AbaContatos> {
  String _idUsuarioLogado;
  String _emailUsuarioLogado;

  Future<List<Usuario>> _recuperarContatos() async {
    FirebaseFirestore db = FirebaseFirestore.instance;

    QuerySnapshot querySnapshot = await db.collection("usuarios").get();

    List<Usuario> listaUsuarios = [];
    querySnapshot.docs.forEach((doc) {
      if (doc["email"] != _emailUsuarioLogado) {
        Usuario usuario = Usuario();
        usuario.uid = doc.reference.id;
        usuario.nome = doc['nome'];
        usuario.nome = doc['nome'];
        usuario.email = doc['email'];
        usuario.urlImagem = doc['urlImagem'];
        listaUsuarios.add(usuario);
      }
    });

    return listaUsuarios;
  }

  @override
  void initState() {
    RecuperaDadosUsuario().dadosUsuario().then((value) {
      _idUsuarioLogado = value['uid'];
      _emailUsuarioLogado = value['email'];
    }).then((value) => _recuperarContatos());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Usuario>>(
      future: _recuperarContatos(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Center(
              child: Column(
                children: <Widget>[
                  Text("Carregando contatos"),
                  CircularProgressIndicator()
                ],
              ),
            );
            break;
          case ConnectionState.active:
          case ConnectionState.done:
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (_, indice) {
                  List<Usuario> listaItens = snapshot.data;
                  Usuario usuario = listaItens[indice];

                  return ListTile(
                    onTap: () {
                      Navigator.pushNamed(context, RouteGenerator.MENSAGENS,
                          arguments: usuario);
                    },
                    contentPadding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                    leading: CircleAvatar(
                        maxRadius: 30,
                        backgroundColor: Colors.grey,
                        backgroundImage: usuario.urlImagem != null
                            ? NetworkImage(usuario.urlImagem)
                            : null),
                    title: Text(
                      usuario.nome,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  );
                });
            break;
        }
      },
    );
  }
}
