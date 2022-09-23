import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tic_tac_toe/widgets/score_board.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  late List<TextStyle> boxTextStyle;
  late List<int> moves;
  List<bool> control = List.filled(16, true);
  bool start = false;
  bool orderPlayers = true;
  int moveCounter = 9;
  //oyuncu 1 = True = x
  //oyuncu 2 = False = O
  int player1Point = 0;
  int player2Point = 0;

  @override
  Widget build(BuildContext context) {
    if (!start) {
      boxTextStyle = List.filled(9, Theme.of(context).textTheme.bodyLarge!);
      moves = List.filled(9, 0);
      start = true;
      moveCounter = 9;
      player1Point = 0;
      player2Point = 0;
    }
    final screenWidth = MediaQuery.of(context).size.width;
    final boxEdge = (screenWidth - 50) / 3;

    Widget _box(int count) {
      return SizedBox(
        height: boxEdge,
        width: boxEdge,
        child: ElevatedButton(
          onPressed: () {
            setState(
              () {
                if (moves[count] == 0) {
                  if (orderPlayers) {
                    moves[count] = 1;
                  } else {
                    moves[count] = 2;
                  }
                  orderPlayers = !orderPlayers;
                  pointsWinner(moves);
                  moveCounter--;
                  if (moveCounter == 0) {
                    _showDialog(context);
                  }
                }
              },
            );
          },
          child: Text(
            _boxtitle(count),
            style: boxTextStyle[count],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Tic Tac Toe"),
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 10),
              child: IconButton(
                onPressed: () {
                  _gameRefresh();
                },
                icon: Icon(Icons.refresh),
                iconSize: 35,
              )),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          ScoreBoard(
            orderPlayers: !orderPlayers,
            transform: true,
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _box(0),
                  _box(1),
                  _box(2),
                ],
              ),
              _boxSpaces(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _box(3),
                  _box(4),
                  _box(5),
                ],
              ),
              _boxSpaces(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _box(6),
                  _box(7),
                  _box(8),
                ],
              ),
            ],
          ),
          ScoreBoard(
            orderPlayers: orderPlayers,
          ),
        ],
      ),
    );
  }

  Container _boxSpaces() {
    return Container(
      height: 5,
    );
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(checkWinner()),
          actions: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  _gameRefresh();
                },
                child: Text("Tekrar Oyna"))
          ],
        );
      },
    );
  }

  void _gameRefresh() {
    setState(() {
      start = false;
    });
  }

  String _boxtitle(int count) {
    if (moves[count] != 0) {
      return moves[count] == 1 ? "X" : "O";
    } else {
      return "";
    }
  }

  pointsWinner(List<int> moves) {
    //row1
    if (moves[0] == 1 && moves[1] == 1 && moves[2] == 1 && control[0]) {
      player1Point++;
      control[0] = false;
      _redLine([0, 1, 2]);
    }
    if (moves[0] == 2 && moves[1] == 2 && moves[2] == 2 && control[1]) {
      player2Point++;
      control[1] = false;
      _redLine([0, 1, 2]);
    }

    //row2
    if (moves[3] == 1 && moves[4] == 1 && moves[5] == 1 && control[2]) {
      player1Point++;
      control[2] = false;
      _redLine([3, 4, 5]);
    }
    if (moves[3] == 2 && moves[4] == 2 && moves[5] == 2 && control[3]) {
      player2Point++;
      control[3] = false;
      _redLine([3, 4, 5]);
    }

    //row3
    if (moves[6] == 1 && moves[7] == 1 && moves[8] == 1 && control[4]) {
      player1Point++;
      control[4] = false;
      _redLine([6, 7, 8]);
    }
    if (moves[6] == 2 && moves[7] == 2 && moves[8] == 2 && control[5]) {
      player1Point++;
      control[5] = false;
      _redLine([6, 7, 8]);
    }

    //col1
    if (moves[0] == 1 && moves[3] == 1 && moves[6] == 1 && control[6]) {
      player1Point++;
      control[6] = false;
      _redLine([0, 3, 6]);
    }
    if (moves[0] == 2 && moves[3] == 2 && moves[6] == 2 && control[7]) {
      player2Point++;
      control[7] = false;
      _redLine([0, 3, 6]);
    }

    //col2
    if (moves[1] == 1 && moves[4] == 1 && moves[7] == 1 && control[8]) {
      player1Point++;
      control[8] = false;
      _redLine([1, 4, 7]);
    }
    if (moves[1] == 2 && moves[4] == 2 && moves[7] == 2 && control[9]) {
      player2Point++;
      control[9] = false;
      _redLine([1, 4, 7]);
    }

    //col3
    if (moves[2] == 1 && moves[5] == 1 && moves[8] == 1 && control[10]) {
      player1Point++;
      control[10] = false;
      _redLine([2, 5, 8]);
    }
    if (moves[2] == 2 && moves[5] == 2 && moves[8] == 2 && control[11]) {
      player2Point++;
      control[11] = false;
      _redLine([2, 5, 8]);
    }

    //diagonal1

    if (moves[0] == 1 && moves[4] == 1 && moves[8] == 1 && control[12]) {
      player1Point++;
      control[12] = false;
      _redLine([0, 4, 8]);
    }
    if (moves[0] == 2 && moves[4] == 2 && moves[8] == 2 && control[13]) {
      player2Point++;
      control[13] = false;
      _redLine([0, 4, 8]);
    }

    //diagonal2
    if (moves[2] == 1 && moves[4] == 1 && moves[6] == 1 && control[14]) {
      player1Point++;
      control[14] = false;
      _redLine([2, 4, 6]);
    }
    if (moves[2] == 2 && moves[4] == 2 && moves[6] == 2 && control[15]) {
      player2Point++;
      control[15] = false;
      _redLine([2, 4, 6]);
    }
  }

  String checkWinner() {
    if (player1Point == player2Point) {
      return "Berabere";
    } else if (player1Point > player2Point) {
      return "Player 1 Kazandı -- X";
    } else {
      return "Player 2 Kazandı -- O";
    }
  }

  void _redLine(List<int> boxNumber) {
    final redStyle = Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.deepOrange);

    boxNumber.forEach((element) {
      boxTextStyle[element] = redStyle!;
    });
  }
}
