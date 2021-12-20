import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

main() => runApp(PerguntaApp());

class PerguntaAppState extends State<PerguntaApp> {
  var perguntaSelecionada = 0;

  void responder() {
    setState(() {
      perguntaSelecionada++;
    });
    print(perguntaSelecionada);
  }

  void Function() funcaoQueRetornaUmaOutraFuncao() {
    return () {
      print('Pergunta respondida #02!');
    };
  }

  @override
  Widget build(BuildContext context) {
    final perguntas = [
      'Qual é a sua cor favorita?',
      'Qual é seu animal cor favorito?',
    ];

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

class PerguntaApp extends StatefulWidget {
  PerguntaAppState createState() {
    return PerguntaAppState();
  }
}
