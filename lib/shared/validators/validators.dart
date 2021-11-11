
class Validators {
  validacao(tipo, value) {
    switch (tipo) {
      case 'Nome':
        return min3(value);
      case 'Email':
        return email(value);
      case 'Senha':
        return passoword(value);
    }
  }

  campoObrigatorio(value) {
    if (value.isEmpty) {
      return "Campo obrigatório";
    } else {
      return null;
    }
  }

  min3(value) {
    if (value.length < 3) {
      return "Campo menor que 3 carecteres";
    } else {
      return null;
    }
  }

  email(value) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(p);
    return regExp.hasMatch(value);
  }

  passoword(value) {
    if (value < 6) {
      return "Senha deve conter no mínimo 6 caracteres";
    } else {
      return null;
    }
  }

  senhaConfirma(password, ConfirmaPassword) {
    if (password != ConfirmaPassword) {
      return 'As senhas devem ser iguais';
    } else {
      return null;
    }
  }
}
