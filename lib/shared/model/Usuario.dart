class Usuario {
  String nome;
  String email;
  String senha;
  String urlImagem;

  Usuario(this.nome, this.email, this.senha, this.urlImagem);

  Map<String, dynamic> toMap(){
    Map<String, dynamic> map = {
      "nome": this.nome,
      "email": this.email,
      "verificado": false,
      "urlImagem": this.urlImagem
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

  String get getUrlImagem => urlImagem;

  set setUrlImagem(String value) {
    urlImagem = value;
  }
}
