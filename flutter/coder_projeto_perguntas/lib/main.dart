import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import './questao.dart';
import './resposta.dart';

main() => runApp(PerguntaApp());

class _PerguntaAppState extends State<PerguntaApp> {
  var _perguntaSelecionada = 0;

  void _responder() {
    setState(() {
      _perguntaSelecionada++;
    });
    print(_perguntaSelecionada);
  }

  void Function() funcaoQueRetornaUmaOutraFuncao() {
    return () {
      print('Pergunta respondida #02!');
    };
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, Object>> perguntas = [
      {
        'texto': 'Qual é a sua cor favorita?',
        'respostas': [
          'Preto',
          'Vermelho',
          'Verde',
          'Branco',
        ]
      },
      {
        'texto': 'Qual é seu animal favorito?',
        'respostas': [
          'Coelho',
          'Cobra',
          'Elefante',
          'Leão',
        ]
      },
      {
        'texto': 'Qual é seu instrutor favorito?',
        'respostas': [
          'Maria',
          'João',
          'Leo',
          'Pedro',
        ]
      }
    ];

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Perguntas'),
        ),
        body: Column(
          children: [
            Questao(perguntas[_perguntaSelecionada]['texto']),
            Resposta('Resposta 1 widget', _responder),
            ElevatedButton(onPressed: _responder, child: Text('Resposta 1')),
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

class PerguntaApp extends StatefulWidget {
  _PerguntaAppState createState() {
    return _PerguntaAppState();
  }
}
