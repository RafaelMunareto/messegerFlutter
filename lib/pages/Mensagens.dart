import 'package:flutter/material.dart';
import 'package:love_bank_messeger/pages/auth/recuperaDadosUsuario.dart';
import 'package:love_bank_messeger/shared/components/caixaMensagens.dart';
import 'package:love_bank_messeger/shared/components/listViewMensagens.dart';
import 'package:love_bank_messeger/shared/model/Usuario.dart';

class Mensagens extends StatefulWidget {
  Usuario contato;

  Mensagens(this.contato);

  @override
  _MensagensState createState() => _MensagensState();
}

class _MensagensState extends State<Mensagens> {

  String _idUsuarioLogado;
  String _idUsuarioDestinatario;

  List<String> listaMensagens = [
    "Olá meu amigo, tudo bem?",
    "Tudo ótimo!!! e contigo?",
    "Estou muito bem!! queria ver uma coisa contigo, você vai na corrida de sábado?",
    "Não sei ainda :(",
    "Pq se você fosse, queria ver se posso ir com você...",
    "Posso te confirma no sábado? vou ver isso",
    "Opa! tranquilo",
    "Excelente!!",
    "Estou animado para essa corrida, não vejo a hora de chegar! ;) ",
    "Vai estar bem legal!! muita gente",
    "vai sim!",
    "Lembra do carro que tinha te falado",
    "Que legal!!"
  ];

  @override
  void initState() {
    super.initState();
    RecuperaDadosUsuario().dadosUsuario().then((value) {
      setState(() {
        _idUsuarioLogado = value['uid'];
        _idUsuarioDestinatario = widget.contato.uid;
        print( widget.contato);
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
                image: AssetImage("imagens/imagem_fundo.jpg"),
                fit: BoxFit.cover
            )
        ),
        child: SafeArea(
            child: Container(
              padding: EdgeInsets.all(8),
              child: Column(
                children: <Widget>[
                  ListViewMensagens(this.listaMensagens),
                  CaixaMensagens(_idUsuarioLogado, _idUsuarioDestinatario),
                ],
              ),
            )
        ),
      ),
    );
  }
}