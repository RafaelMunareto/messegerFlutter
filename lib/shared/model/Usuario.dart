class Usuario {
  String nome;
  String email;
  String senha;

  Usuario(this.nome, this.email, this.senha);

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
