import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

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
