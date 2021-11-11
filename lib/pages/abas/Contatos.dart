import 'package:flutter/material.dart';
import 'package:love_bank_messeger/pages/abas/Mensagens.dart';
import 'package:love_bank_messeger/shared/model/Conversa.dart';


class Contatos extends StatefulWidget {
  const Contatos({Key? key}) : super(key: key);

  @override
  _ContatosState createState() => _ContatosState();
}

class _ContatosState extends State<Contatos> {

  List<Conversa> listaConversas = [
    Conversa(
        "Ana Clara",
        "Olá tudo bem?",
        "https://firebasestorage.googleapis.com/v0/b/lovebankmesseger.appspot.com/o/perfil%2Fperfil1.jpg?alt=media&token=a2a24553-58c3-461b-8b4a-46f9c168f166"
    ),
    Conversa(
        "Pedro Silva",
        "Me manda o nome daquela série que falamos!",
        "https://firebasestorage.googleapis.com/v0/b/lovebankmesseger.appspot.com/o/perfil%2Fperfil2.jpg?alt=media&token=ec21aad8-bc1f-4875-8993-7dea336e7aea"
    ),
    Conversa(
        "Marcela Almeida",
        "Vamos sair hoje?",
        "https://firebasestorage.googleapis.com/v0/b/lovebankmesseger.appspot.com/o/perfil%2Fperfil3.jpg?alt=media&token=efd515b4-8b85-45c7-b8d5-2fba8a71025c"
    ),
    Conversa(
        "José Renato",
        "Não vai acreditar no que tenho para te contar...",
        "https://firebasestorage.googleapis.com/v0/b/lovebankmesseger.appspot.com/o/perfil%2Fperfil4.jpg?alt=media&token=9e262a11-161b-4eae-84d8-bcd8e8bfed54"
    ),
    Conversa(
        "Jamilton Damasceno",
        "Curso novo!! depois dá uma olhada!!",
        "https://firebasestorage.googleapis.com/v0/b/lovebankmesseger.appspot.com/o/perfil%2Fperfil5.jpg?alt=media&token=ff2158bf-1f55-4da0-97e2-a6cbc0ef798b"
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: listaConversas.length,
        itemBuilder: (context, indice){

          Conversa conversa = listaConversas[indice];

          return ListTile(
            contentPadding: EdgeInsets.fromLTRB(16, 8, 16, 8),
            leading: CircleAvatar(
              maxRadius: 30,
              backgroundColor: Colors.grey,
              backgroundImage: NetworkImage( conversa.caminhoFoto ),
            ),
            title: Text(
              conversa.nome,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16
              ),
            ),
          );

        }
    );
  }
}
