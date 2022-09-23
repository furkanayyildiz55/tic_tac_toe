import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tic_tac_toe/product/game_theme.dart';

class ScoreBoard extends StatefulWidget {
  ScoreBoard({Key? key, required this.orderPlayers, this.transform = false}) : super(key: key);
  bool orderPlayers;
  bool transform;
  //oyuncu 1 = True = x
  //oyuncu 2 = False = O

  @override
  State<ScoreBoard> createState() => _ScoreBoardState();
}

class _ScoreBoardState extends State<ScoreBoard> with GameTheme {
  @override
  Widget build(BuildContext context) {
    TextStyle? scoreBoardStyleSmall = widget.orderPlayers
        ? Theme.of(context).textTheme.bodySmall?.copyWith(color: GameTheme().activePlayerColor)
        : Theme.of(context).textTheme.bodySmall;

    TextStyle? scoreBoardStyleMedium = widget.orderPlayers
        ? Theme.of(context).textTheme.bodyMedium?.copyWith(color: GameTheme().activePlayerColor)
        : Theme.of(context).textTheme.bodyMedium;

    if (!widget.transform) {
      //x
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("X", style: scoreBoardStyleMedium),
              Text(
                "  Player 1  ",
                style: scoreBoardStyleSmall,
              ),
              Text(
                "X",
                style: scoreBoardStyleMedium,
              )
            ],
          )
        ],
      );
    } else {
      return Transform(
        transform: Matrix4.rotationZ(pi),
        alignment: Alignment.center,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("O", style: scoreBoardStyleMedium),
                Text(
                  "  Player 2  ",
                  style: scoreBoardStyleSmall,
                ),
                Text(
                  "O",
                  style: scoreBoardStyleMedium,
                )
              ],
            )
          ],
        ),
      );
    }
  }
}
