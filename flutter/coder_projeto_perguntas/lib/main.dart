import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

main() => runApp(PerguntaApp());

class PerguntaApp extends StatelessWidget {
  var perguntaSelecionada = 0; // jeito errado

  void responder() {
    perguntaSelecionada++;
    print(perguntaSelecionada);
  }

  void Function() funcaoQueRetornaUmaOutraFuncao() {
    return () {
      print('Pergunta respondida #02!');
    };
  }

  final perguntas = [
    'Qual é a sua cor favorita?',
    'Qual é seu animal cor favorito?',
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Perguntas'),
        ),
        body: Column(
          children: [
            Text(perguntas[perguntaSelecionada]),
            ElevatedButton(onPressed: responder, child: Text('Resposta 1')),
            ElevatedButton(
                onPressed: () {
                  print('responder 2');
                },
                child: Text('Resposta 2')),
            ElevatedButton(
                onPressed: funcaoQueRetornaUmaOutraFuncao(),
                child: Text('Resposta 3')),
            ElevatedButton(
                onPressed: () => print('responder 4'),
                child: Text('Resposta 4')),
          ],
        ),
      ),
    );
  }
}
