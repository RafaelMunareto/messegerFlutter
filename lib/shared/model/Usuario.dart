
class Usuario {
  String _uid;
  String _nome;
  String _email;
  String _urlImagem;
  String _senha;

  Usuario();



  Map<String, dynamic> toMap(){

    Map<String, dynamic> map = {
      "uid": this.uid,
      "nome" : this.nome,
      "email" : this.email,
      "urlImagem" : this.urlImagem
    };

    return map;

  }

  String get uid => _uid;

  set uid(String value) {
    _uid = value;
  }

  String get senha => _senha;

  set senha(String value) {
    _senha = value;
  }

  String get urlImagem => _urlImagem;

  set urlImagem(String value) {
    _urlImagem = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get nome => _nome;

  set nome(String value) {
    _nome = value;
  }


}