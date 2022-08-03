class Carro {
  int _velocidade = 0;

  int acelerar() {
    _velocidade += 5;
    return _velocidade;
  }

  int frear() {
    _velocidade -= 5;
    return _velocidade;
  }
}

class Ferrari extends Carro with Esportivo, Luxo {
  @override
  int acelerar() {
    if (_turboLigado) {
      super.acelerar();
    }
    return super.acelerar();
  }
}

class Gol extends Carro {}

mixin Esportivo {
  bool _turboLigado = false;

  ligarTurbo() {
    _turboLigado = true;
  }

  desligarTurbo() {
    _turboLigado = false;
  }
}

mixin Luxo {
  bool _arLigado = false;

  ligarAr() {
    _arLigado = true;
  }

  desligarAr() {
    _arLigado = false;
  }
}

void mixinExample() {
  var c1 = Ferrari();

  print(c1.acelerar());
  c1.ligarTurbo();
  print(c1.acelerar());
  print(c1.acelerar());

  print(c1.frear());
  print(c1.frear());
  print(c1.frear());
}
