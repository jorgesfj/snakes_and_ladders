import 'dart:math';

import 'package:flutter/material.dart';
import 'package:snakes_and_ladders/core/constants.dart';
import 'package:snakes_and_ladders/enums/player_type.dart';
import 'package:snakes_and_ladders/models/cobras_escadas.dart';
import 'package:snakes_and_ladders/screens/about_me.dart';

import '../take_points_out_for_snakes_ladders.dart';
import 'line_painter.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  late List<GlobalKey> list;
  late Size size;
  late double width;
  late double height;
  int leftDiceValue = 1;
  int rightDiceValue = 1;
  final _controller = CobrasEscadas(0, 0, PlayerType.player1, 0, 0);

  @override
  void initState() {
    super.initState();
    list = List<GlobalKey>.generate(100, (_) => GlobalKey());
    WidgetsBinding.instance!.addPostFrameCallback((d) {
      setState(() {
        takeOutPoint(list);
      });
      laddersRender();
      snakeRender();
    });
  }

  final ladderChildren = <Widget>[];
  final snakeChildren = <Widget>[];
  laddersRender() {
    for (int i = 0; i < ladderPointsA.length; i++) {
      ladderChildren.add(CustomPaint(
        size: Size(width, height),
        painter: MyPainter(
          point1: ladderPointsA[i],
          point2: ladderPointsB[i],
          pointOrigin: p0,
          px: size.width > 700 ? Offset(0, 0) : px,
        ),
      ));
    }
  }

  snakeRender() {
    for (int i = 0; i < snakePointsA.length; i++) {
      snakeChildren.add(CustomPaint(
        size: Size(width, height),
        painter: SnakePainter(
          point1: snakePointsA[i],
          point2: snakePointsB[i],
          pointOrigin: p0,
          px: size.width > 700 ? Offset(0, 0) : px,
        ),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height > 700 ? 700 : 570;
    width = size.width > 700 ? 700 : 570;

    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(size, height, width, context),
    );
  }

  _buildAppBar() {
    return AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Text('Cobras e Escadas'));
  }

  _buildBody(size, height, width, context) {
    return Container(
      color: Colors.black,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [_buildBoard(size, height, width), _buildUser(context)],
      ),
    );
  }

  _buildUser(context) {
    var jogador = _controller.currentPlayer == PlayerType.player1
        ? "Jogador 1"
        : "Jogador2";
    var cor = _controller.currentPlayer == PlayerType.player1
        ? Colors.red
        : Colors.orange;
    return Expanded(
      flex: 3,
      child: Container(
        child: Flex(
          direction: Axis.vertical,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
                color: Colors.red,
                child: Container(
                  width: 120,
                  height: 50,
                  child: Center(
                    child: Text("Jogador 1"),
                  ),
                )),
            SizedBox(height: size.width > 700 ? 40 : 5),
            Container(
              height: 100,
              width: 100,
              child: Text('DADO'),
            ),
            SizedBox(height: size.width > 700 ? 40 : 5),
            Padding(
                padding: const EdgeInsets.all(4),
                child: Text(
                    "Para iniciar basta clicar no dado. É a vez do: " + jogador,
                    style: TextStyle(
                      color: cor,
                    ),
                    textAlign: TextAlign.center)),
            _buildDice(context),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                "As cobras (LINHAS AMARELAS) te levam abaixo se cair nelas. A escadas (LINHAS AZUIS) te levam acima. O primeiro a atingir a casa 100 ganha",
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              height: 100,
              width: 100,
              child: Text('DADO2'),
            ),
            SizedBox(height: size.width > 700 ? 40 : 5),
            Card(
              color: Color.fromRGBO(247, 220, 111, 1),
              child: Container(
                width: 120,
                height: 50,
                child: Center(
                  child: Text("Jogador 2"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildBoard(size, height, width) {
    return Flex(
      direction: size.width > 700 ? Axis.horizontal : Axis.vertical,
      children: [
        Container(
          margin: EdgeInsets.all(22),
          height: size.width > 700 ? height : 570,
          width: size.height > 700 ? width : 570,
          child: Stack(
            children: [
              GridView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: BOARD_SIZE,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 10,
                    mainAxisSpacing: 0,
                    crossAxisSpacing: 0),
                itemBuilder: _buildTile,
              ),
              ...snakeChildren,
              ...ladderChildren,
            ],
          ),
        )
      ],
    );
  }

  Widget _buildTile(context, index) {
    return Container(
      key: list[index],
      color: (10 <= index && index <= 19) ||
              (30 <= index && index <= 39) ||
              (50 <= index && index <= 59) ||
              (70 <= index && index <= 79) ||
              (90 <= index && index <= 99)
          ? index.isOdd
              ? Color.fromRGBO(193, 144, 96, 1)
              : Color.fromRGBO(33, 45, 60, 1)
          : index.isEven
              ? Color.fromRGBO(193, 144, 96, 1)
              : Color.fromRGBO(33, 45, 60, 1),
      child: Center(
          child: Stack(
        children: [
          (100 - index) == _controller.positionPlayer1
              ? Align(
                  alignment: index == 99 ? Alignment.topLeft : Alignment.center,
                  child: Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: new BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                )
              : SizedBox(),
          (100 - index) == _controller.positionPlayer2
              ? Align(
                  alignment:
                      index == 99 ? Alignment.bottomRight : Alignment.center,
                  child: Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: new BoxDecoration(
                      color: Colors.orange,
                      shape: BoxShape.circle,
                    ),
                  ),
                )
              : SizedBox(),
          Container(
            child: Center(
              child: Text(
                (100 - index).toString(),
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
            ),
          ),
        ],
      )),
    );
  }

  _buildDice(context) {
    return Container(
      child: Center(
        child: Row(
          children: <Widget>[
            Expanded(
              child: TextButton(
                onPressed: () {
                  changeDiceFace(context);
                },
                child: Container(
                  child: Image.asset('images/dice$leftDiceValue.png'),
                  height: 50,
                  width: 50,
                ),
              ),
            ),
            Expanded(
              child: TextButton(
                onPressed: () {
                  changeDiceFace(context);
                },
                child: Container(
                  child: Image.asset('images/dice$rightDiceValue.png'),
                  height: 50,
                  width: 50,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void changeDiceFace(context) {
    setState(() {
      rightDiceValue = Random().nextInt(6) + 1;
      leftDiceValue = Random().nextInt(6) + 1;
    });
    _controller.valueDice1 = leftDiceValue;
    _controller.valueDice2 = rightDiceValue;
    _controller.jogar(context);
  }
}
