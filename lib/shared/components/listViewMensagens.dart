import 'package:flutter/material.dart';

class ListViewMensagens extends StatefulWidget {
  final mensagens;

  ListViewMensagens(this.mensagens);

  @override
  _ListViewMensagensState createState() => _ListViewMensagensState();
}

class _ListViewMensagensState extends State<ListViewMensagens> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: widget.mensagens.length,
          itemBuilder: (context, indice) {
            double larguraContainer = MediaQuery.of(context).size.width * 0.8;

            //larguraContainer -> 100
            //x                -> 80

            //Define cores e alinhamentos
            Alignment alinhamento = Alignment.centerRight;
            Color corUm = Color(0xffe4dcf2);
            Color corDois = Color(0xff8e6bd6);
            if (indice % 2 == 0) {
              //par
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
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  child: Text(
                    widget.mensagens[indice],
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
