import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      transformAlignment: Alignment.center,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: ExactAssetImage("imagens/body_section.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: CircularProgressIndicator(color: Colors.white,),
      ),
    );
  }
}
