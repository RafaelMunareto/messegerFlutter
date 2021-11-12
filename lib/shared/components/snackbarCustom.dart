import 'package:flutter/material.dart';
import 'package:love_bank_messeger/shared/functions/errorPtBr.dart';

class SnackbarCustom  {
     createSnackBar(message, cor, context) {
      final snackBar =
      new SnackBar(content: new Text(message), backgroundColor: cor);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

     createSnackBarErrorFirebase(message, cor, context) {
       final snackBar =
       new SnackBar(content: new Text(ErrorPtBr().verificaCodeErro(message)), backgroundColor: cor);
       ScaffoldMessenger.of(context).showSnackBar(snackBar);
     }


}
