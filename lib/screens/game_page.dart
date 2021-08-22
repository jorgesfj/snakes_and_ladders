import 'dart:math';

import 'package:flutter/material.dart';
import 'package:snakes_and_ladders/core/constants.dart';
import 'package:snakes_and_ladders/enums/player_type.dart';
import 'package:snakes_and_ladders/models/cobras_escadas.dart';
import 'package:snakes_and_ladders/screens/about_me.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  int leftDiceValue = 1;
  int rightDiceValue = 1;
  final _controller = CobrasEscadas(0, 0, PlayerType.player1, 0, 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.indigo,
      title: Text('SNAKES AND LADDERS'),
      actions: [
        IconButton(
            onPressed: () => {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AboutMe()))
                },
            icon: Icon(Icons.person))
      ],
    );
  }

  _buildBody() {
    return Container(
      color: Colors.black,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [_buildBoard(), _buildUser()],
      ),
    );
  }

  _buildUser() {
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
                    child: Text("Player Red"),
                  ),
                )),
            SizedBox(height: 50),
            Container(
              height: 100,
              width: 100,
              child: Text('DADO'),
            ),
            SizedBox(
              height: 40,
            ),
            Padding(
                padding: const EdgeInsets.all(4),
                child: Text(
                    'Rode o dado e tente sua sorte! Vez do ' +
                        _controller.currentPlayer.toString(),
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center)),
            _buildDice(),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                "Game will start for you if you get 1 from the roll initially.",
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              height: 100,
              width: 100,
              child: Text('DADO2'),
            ),
            SizedBox(
              height: 40,
            ),
            Card(
              color: Color.fromRGBO(247, 220, 111, 1),
              child: Container(
                width: 120,
                height: 50,
                child: Center(
                  child: Text("Player Orange"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildBoard() {
    return Flex(
      direction: Axis.vertical,
      children: [
        Container(
          margin: EdgeInsets.all(22),
          height: 570,
          width: 570,
          child: Stack(
            children: [
              GridView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: BOARD_SIZE,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 10,
                    mainAxisSpacing: 1,
                    crossAxisSpacing: 1),
                itemBuilder: _buildTile,
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildTile(context, index) {
    return Container(
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
          child: Text(
        (100 - index).toString(),
        style: TextStyle(color: Colors.white, fontSize: 24),
      )),
    );
  }

  _buildDice() {
    return Container(
      child: Center(
        child: Row(
          children: <Widget>[
            Expanded(
              child: TextButton(
                onPressed: () {
                  changeDiceFace();
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
                  changeDiceFace();
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

  void changeDiceFace() {
    setState(() {
      rightDiceValue = Random().nextInt(6) + 1;
      leftDiceValue = Random().nextInt(6) + 1;
    });
    _controller.valueDice1 = leftDiceValue;
    _controller.valueDice2 = rightDiceValue;
    _controller.jogar();
  }
}
