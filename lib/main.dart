import 'dart:math';
import 'package:flutter/material.dart';

class PPT extends StatefulWidget {
  const PPT({Key? key}) : super(key: key);

  @override
  State<PPT> createState() => _PPTState();
}

// Definição ícones dos jogadores
class _PPTState extends State<PPT> {
  String imgJogoUser = "imagens/indefinido.png";
  String imgJogoApp = "imagens/indefinido.png";

  // Pontuação inicial
  int userPontos = 0;
  int appPontos = 0;
  int empate = 0;

  //Bordas:
  Color corBordaUser = Colors.transparent;
  Color corBordaApp = Colors.transparent;

  // Opções de escolha do User
  String _obtemEscolhaApp() {
    var opcoes = ['pedra', 'papel', 'tesoura'];

    String vlrEscolhido = opcoes[Random().nextInt(3)];

    return vlrEscolhido;
  }
  
  // Função para a lógica da jogada
  void _terminaJogada(String escolhaUser, String escolhaApp) {
    var resultado = "indefinido";

    switch (escolhaUser) {
      case "pedra":
        if (escolhaApp == "papel") {
          resultado = "app";
        } else if (escolhaApp == "tesoura") {
          resultado = "user";
        } else {
          resultado = "empate";
        }
        break;
      case "papel":
        if (escolhaApp == "pedra") {
          resultado = "user";
        } else if (escolhaApp == "tesoura") {
          resultado = "app";
        } else {
          resultado = "empate";
        }
        break;
      case "tesoura":
        if (escolhaApp == "papel") {
          resultado = "user";
        } else if (escolhaApp == "pedra") {
          resultado = "app";
        } else {
          resultado = "empate";
        }
        break;
    }
   
  // Requisito de coloração de acordo com o resultado das jogadas
    setState(() {
      if (resultado == "user") {
        userPontos++;
        corBordaUser = Colors.green;
        corBordaApp = Colors.transparent;
      } else if (resultado == "app") {
        appPontos++;
        corBordaApp = Colors.green;
        corBordaUser = Colors.transparent;
      } else {
        empate++;
        corBordaUser = Colors.orange;
        corBordaApp = Colors.orange;
      }
    });
  }

  // Função de start no jogo
  void _iniciaJogada(String opcao) {
    //Configura a opção escolhida pelo usuário:
    setState(() {
      imgJogoUser = "imagens/$opcao.png";
    });

    String escolhaApp = _obtemEscolhaApp();
    setState(() {
      imgJogoApp = "imagens/$escolhaApp.png";
    });

    _terminaJogada(opcao, escolhaApp);
  }

  // Configuração layout
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.green),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("APP - Pedra Papel Tesoura"),
        ),
        body: Column(children: [
          const Padding(
            padding: EdgeInsets.only(top: 10, bottom: 20),
            child: Text(
              'Disputa',
              style: TextStyle(fontSize: 26),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Badge(corBorda: corBordaUser, imgJogo: imgJogoUser),
              const Text('VS'),
              Badge(corBorda: corBordaApp, imgJogo: imgJogoApp),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(top: 10, bottom: 20),
            child: Text(
              'Placar',
              style: TextStyle(fontSize: 18),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Placar(playerName: 'Você', playerPoints: userPontos),
              Placar(playerName: 'Empate', playerPoints: empate),
              Placar(playerName: 'App', playerPoints: appPontos),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(top: 10, bottom: 20),
            child: Text(
              'Opções',
              style: TextStyle(fontSize: 16),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () => _iniciaJogada("pedra"),
                child: Image.asset(
                  'imagens/pedra.png',
                  height: 90,
                ),
              ),
              GestureDetector(
                onTap: () => _iniciaJogada("papel"),
                child: Image.asset(
                  'imagens/papel.png',
                  height: 90,
                ),
              ),
              GestureDetector(
                onTap: () => _iniciaJogada("tesoura"),
                child: Image.asset(
                  'imagens/tesoura.png',
                  height: 90,
                ),
              ),
            ],
          )
        ]),
      ),
    );
  }
}

class Placar extends StatelessWidget {
  const Placar({
    Key? key,
    required String playerName,
    required int playerPoints,
  })  : _playerPoints = playerPoints,
        _playerName = playerName,
        super(key: key);

  final int _playerPoints;
  final String _playerName;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(_playerName),
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black45, width: 2),
              borderRadius: const BorderRadius.all(Radius.circular(7))),
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(35),
          child: Text('$_playerPoints', style: TextStyle(fontSize: 26)),
        )
      ],
    );
  }
}

class Badge extends StatelessWidget {
  const Badge({
    Key? key,
    required Color corBorda,
    required String imgJogo,
  })  : borderColor = corBorda,
        imgPlayer = imgJogo,
        super(key: key);

  final Color borderColor;
  final String imgPlayer;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: borderColor, width: 4),
          borderRadius: const BorderRadius.all(Radius.circular(100))),
      child: Image.asset(
        imgPlayer,
        height: 120,
      ),
    );
  }
}

void main() {
  runApp(const PPT());
}