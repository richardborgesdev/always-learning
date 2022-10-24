void main() {
  int r1 = soma(7, 3);
  print(r1);

  somaDoFuturo(78, 30)
      .then((value) => print(value))
      .catchError((error) => print(error));
}

int soma(a, b) {
  return a + b;
}

Future<int> somaDoFuturo(int a, int b) {
  return Future(() {
    return a + b;
  });
}
