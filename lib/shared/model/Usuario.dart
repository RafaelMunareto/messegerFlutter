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
      "foto": 'https://firebasestorage.googleapis.com/v0/b/lovebankmesseger.appspot.com/o/perfil%2Fdefault.png?alt=media&token=3887c241-51fc-4628-a6ba-5b95bb385ae4'
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
