import 'package:flutter/material.dart';
import 'package:love_bank_messeger/pages/Configuracoes.dart';
import 'package:love_bank_messeger/pages/Home.dart';
import 'package:love_bank_messeger/pages/Mensagens.dart';
import 'package:love_bank_messeger/pages/auth/Login.dart';


class RouteGenerator {

  static const String INITIAL = '/';
  static const String HOME = '/home';
  static const String LOGIN = '/login';
  // static const String CADASTRO = '/cadastro';
  // static const String EMAIL_VERIFY = '/email-verify';
  // static const String FORGET = '/forget';
  // static const String TROCA_SENHA = '/troca-senha';
  static const String CONFIGURACOES = '/configuracoes';
  static const String MENSAGENS = '/mensagens';


  static Route<dynamic> generateRoute(RouteSettings settings){

    final args = settings.arguments;
    
    switch( settings.name ){
      case INITIAL :
        return MaterialPageRoute(
            builder: (_) => Login((_) {})
        );
      case LOGIN:
        return MaterialPageRoute(
            builder: (_) => Login((_) {})
        );
      // case CADASTRO:
      //   return MaterialPageRoute(
      //       builder: (_) => Cadastro((_) {})
      //   );
      case HOME :
        return MaterialPageRoute(
            builder: (_) => Home()
        );
      // case EMAIL_VERIFY:
      //   return MaterialPageRoute(
      //       builder: (_) => Confirmation()
      //   );
      // case FORGET :
      //   return MaterialPageRoute(
      //       builder: (_) => Forget((_) {})
      //   );
      // case TROCA_SENHA :
      //   return MaterialPageRoute(
      //       builder: (_) => TrocaSenha((_) {})
      //   );
      case CONFIGURACOES :
        return MaterialPageRoute(
            builder: (_) => Configuracoes((_) {})
        );
      case MENSAGENS :
        return MaterialPageRoute(
            builder: (_) => Mensagens(args)
        );
      default:
        _erroRota();
    }

  }

  static Route<dynamic> _erroRota(){
    return MaterialPageRoute(
        builder: (_){
          return Scaffold(
            appBar: AppBar(title: Text("Tela não encontrada!"),),
            body: Center(
              child: Text("Tela não encontrada!"),
            ),
          );
        }
    );
  }

}