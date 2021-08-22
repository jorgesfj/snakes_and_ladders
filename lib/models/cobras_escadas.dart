import 'package:flutter/material.dart';
import 'package:snakes_and_ladders/enums/player_type.dart';

class CobrasEscadas {
  int positionPlayer1 = 0;
  int positionPlayer2 = 0;
  PlayerType currentPlayer;
  int valueDice1 = 0;
  int valueDice2 = 0;

  CobrasEscadas(this.positionPlayer1, this.positionPlayer2, this.currentPlayer,
      this.valueDice1, this.valueDice2);

  jogar(context) {
    if (currentPlayer == PlayerType.player1) {
      positionPlayer1 += (valueDice1 + valueDice2);
      if (positionPlayer1 > 100) {
        positionPlayer1 = 100 - (positionPlayer1 - 100);
      } else if (positionPlayer1 == 8) {
        positionPlayer1 = 31;
      } else if (positionPlayer1 == 7) {
        positionPlayer1 = 14;
      } else if (positionPlayer1 == 2) {
        positionPlayer1 = 38;
      } else if (positionPlayer1 == 15) {
        positionPlayer1 = 26;
      } else if (positionPlayer1 == 28) {
        positionPlayer1 = 84;
      } else if (positionPlayer1 == 21) {
        positionPlayer1 = 42;
      } else if (positionPlayer1 == 36) {
        positionPlayer1 = 44;
      } else if (positionPlayer1 == 51) {
        positionPlayer1 = 67;
      } else if (positionPlayer1 == 78) {
        positionPlayer1 = 98;
      } else if (positionPlayer1 == 71) {
        positionPlayer1 = 91;
      } else if (positionPlayer1 == 87) {
        positionPlayer1 = 94;
      } else if (positionPlayer1 == 16) {
        positionPlayer1 = 6;
      } else if (positionPlayer1 == 49) {
        positionPlayer1 = 11;
      } else if (positionPlayer1 == 46) {
        positionPlayer1 = 25;
      } else if (positionPlayer1 == 62) {
        positionPlayer1 = 19;
      } else if (positionPlayer1 == 64) {
        positionPlayer1 = 60;
      } else if (positionPlayer1 == 74) {
        positionPlayer1 = 53;
      } else if (positionPlayer1 == 89) {
        positionPlayer1 = 68;
      } else if (positionPlayer1 == 95) {
        positionPlayer1 = 75;
      } else if (positionPlayer1 == 99) {
        positionPlayer1 = 80;
      } else if (positionPlayer1 == 92) {
        positionPlayer1 = 88;
      } else if (positionPlayer1 == 100) {
        _reset();
        _showDialog(PlayerType.player1, context);
      }
      valueDice1 == valueDice2
          ? currentPlayer = PlayerType.player1
          : currentPlayer = PlayerType.player2;
      print("Player 1 = " + positionPlayer1.toString());
    } else {
      positionPlayer2 += (valueDice1 + valueDice2);
      if (positionPlayer2 > 100) {
        positionPlayer2 = 100 - (positionPlayer2 - 100);
      } else if (positionPlayer2 == 8) {
        positionPlayer2 = 31;
      } else if (positionPlayer2 == 7) {
        positionPlayer2 = 14;
      } else if (positionPlayer2 == 2) {
        positionPlayer2 = 38;
      } else if (positionPlayer2 == 15) {
        positionPlayer2 = 26;
      } else if (positionPlayer2 == 28) {
        positionPlayer2 = 84;
      } else if (positionPlayer2 == 21) {
        positionPlayer2 = 42;
      } else if (positionPlayer2 == 36) {
        positionPlayer2 = 44;
      } else if (positionPlayer2 == 51) {
        positionPlayer2 = 67;
      } else if (positionPlayer2 == 78) {
        positionPlayer2 = 98;
      } else if (positionPlayer2 == 71) {
        positionPlayer2 = 91;
      } else if (positionPlayer2 == 87) {
        positionPlayer2 = 94;
      } else if (positionPlayer2 == 16) {
        positionPlayer2 = 6;
      } else if (positionPlayer2 == 49) {
        positionPlayer2 = 11;
      } else if (positionPlayer2 == 46) {
        positionPlayer2 = 25;
      } else if (positionPlayer2 == 62) {
        positionPlayer2 = 19;
      } else if (positionPlayer2 == 64) {
        positionPlayer2 = 60;
      } else if (positionPlayer2 == 74) {
        positionPlayer2 = 53;
      } else if (positionPlayer2 == 89) {
        positionPlayer2 = 68;
      } else if (positionPlayer2 == 95) {
        positionPlayer2 = 75;
      } else if (positionPlayer2 == 99) {
        positionPlayer2 = 80;
      } else if (positionPlayer2 == 92) {
        positionPlayer2 = 88;
      } else if (positionPlayer2 == 100) {
        _reset();
        _showDialog(PlayerType.player2, context);
      }
      valueDice1 == valueDice2
          ? currentPlayer = PlayerType.player2
          : currentPlayer = PlayerType.player1;
      print("Player 2 = " + positionPlayer2.toString());
    }
  }

  _showDialog(player, context) {
    var jogador = player == PlayerType.player1 ? "Jogador 1" : "Jogador 2";
    var cor = player == PlayerType.player1 ? Colors.red : Colors.orange;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // retorna um objeto do tipo Dialog
        return AlertDialog(
          title: new Text("Jogo Acabou"),
          content: new Text("O Jogador: " + jogador + " venceu o jogo",
              style: TextStyle(color: cor)),
          actions: <Widget>[
            // define os botões na base do dialogo
            new IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: Icon(Icons.close))
          ],
        );
      },
    );
  }

  _reset() {
    positionPlayer1 = 0;
    positionPlayer2 = 0;
    currentPlayer = PlayerType.player1;
    valueDice1 = 0;
    valueDice2 = 0;
  }
}
