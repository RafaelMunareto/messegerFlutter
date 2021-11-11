class Credentials {
  String email;
  String senha;

  Credentials(this.email, this.senha);

  String get getSenha => senha;

  set setSEnha(String value) {
    senha = value;
  }

  String get getEmail => email;

  set setEnail(String value) {
    email = value;
  }

}
