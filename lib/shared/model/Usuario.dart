class Usuario {
  String nome;
  String email;
  String senha;

  Usuario(this.nome, this.email, this.senha);

  Map<String, dynamic> toMap(){
    Map<String, dynamic> map = {
      "nome": this.nome,
      "email": this.email,
      "verificado": false,
      "foto": ''
    };

    return map;
  }
  String get getSenha => senha;

  set setSEnha(String value) {
    senha = value;
  }

  String get getEmail => email;

  set setEnail(String value) {
    email = value;
  }

  String get getNome => nome;

  set setNome(String value) {
    nome = value;
  }
}
