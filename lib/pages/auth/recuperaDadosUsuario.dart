import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RecuperaDadosUsuario {

  Future dadosUsuario() async {
    String uid;
    String nome;
    String email;
    String urlImagem;

    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore db = FirebaseFirestore.instance;

    if(auth.currentUser != null){
      uid = auth.currentUser.uid;

      DocumentSnapshot snapshot =
      await db.collection("usuarios").doc(auth.currentUser.uid).get();

      Map<String, dynamic> dados = snapshot.data() as Map<String, dynamic>;
      nome = dados['nome'];
      email = dados['email'];

      if (dados["urlImagem"] != null) {
         urlImagem = dados["urlImagem"];
      }
      Map<String, dynamic> map = {
        "uid" : uid,
        "nome" : nome,
        "email" : email,
        "urlImagem": urlImagem
      };

      return map;
    }


  }
}