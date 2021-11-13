import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:love_bank_messeger/RouteGenerator.dart';

class UsuarioLogado {

  Future logado(context) async {

    FirebaseAuth auth = FirebaseAuth.instance;
    User usuarioLogado = await auth.currentUser;

    if( usuarioLogado != null ){
      Navigator.pushReplacementNamed(context, RouteGenerator.HOME);
    }

  }

  Future deslogado(context) async {

    FirebaseAuth auth = FirebaseAuth.instance;
    User usuarioLogado = await auth.currentUser;

    if( usuarioLogado == null ){
      Navigator.pushReplacementNamed(context, RouteGenerator.LOGIN);
    }

  }

  deslogar(context)
  {
    FirebaseAuth auth = FirebaseAuth.instance;
    auth.signOut().then((value) =>  Navigator.pushReplacementNamed(context, RouteGenerator.LOGIN));
  }
}