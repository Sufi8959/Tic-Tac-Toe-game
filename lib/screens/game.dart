import 'dart:async';
import 'package:flutter/material.dart';

import 'package:tic_tac_toe_game/screens/constants/custom_fonts.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final List<String> showXO = ['', '', '', '', '', '', '', '', ''];
  bool oTurn = true;
  String winner = '';
  int oScore = 0;
  int xScore = 0;
  int filledBoxex = 0;
  bool winnerFound = false;
  Timer? timer;
  static const maxSeconds = 30;
  int seconds = maxSeconds;
  int attempts = 0;
  List<int> matchedBoxes = [];

  void disPlayXO(int index) {
    final isRunning = timer == null ? false : timer?.isActive;
    if (isRunning!) {
      setState(
        () {
          if (oTurn && showXO[index] == '') {
            showXO[index] = '0';
            filledBoxex++;
          } else {
            showXO[index] = 'X';
            filledBoxex++;
          }

          oTurn = !oTurn;
          checkWinner();
        },
      );
    }
  }

  void checkWinner() {
    // 1st row
    if (showXO[0] == showXO[1] && showXO[0] == showXO[2] && showXO[0] != '') {
      setState(() {
        winner = "Player ${showXO[0]} wins";
        matchedBoxes.addAll([0, 1, 2]);
        stopTimer();
        updateScore(showXO[0]);
      });
    }
    // 2nd row
    if (showXO[3] == showXO[4] && showXO[3] == showXO[5] && showXO[3] != '') {
      setState(() {
        winner = "Player ${showXO[3]} wins";
        matchedBoxes.addAll([3, 4, 5]);
        stopTimer();
        updateScore(showXO[3]);
      });
    }
    // 3rd row
    if (showXO[6] == showXO[7] && showXO[6] == showXO[8] && showXO[6] != '') {
      setState(() {
        winner = "Player ${showXO[6]} wins";
        matchedBoxes.addAll([6, 7, 8]);
        stopTimer();
        updateScore(showXO[6]);
      });
    }
    //1st column
    if (showXO[0] == showXO[3] && showXO[0] == showXO[6] && showXO[0] != '') {
      setState(() {
        winner = "Player ${showXO[0]} wins";
        matchedBoxes.addAll([0, 3, 6]);
        stopTimer();
        updateScore(showXO[0]);
      });
    }
    // 2nd column
    if (showXO[1] == showXO[4] && showXO[1] == showXO[7] && showXO[1] != '') {
      setState(() {
        winner = "Player ${showXO[1]} wins";
        matchedBoxes.addAll([1, 4, 7]);
        stopTimer();
        updateScore(showXO[1]);
      });
    }
    // 3rd column
    if (showXO[2] == showXO[5] && showXO[2] == showXO[8] && showXO[2] != '') {
      setState(() {
        winner = "Player ${showXO[2]} wins";
        matchedBoxes.addAll([2, 5, 8]);
        stopTimer();
        updateScore(showXO[2]);
      });
    }
    // 1st diagonal column
    if (showXO[0] == showXO[4] && showXO[0] == showXO[8] && showXO[0] != '') {
      setState(() {
        winner = "Player ${showXO[0]} wins";
        matchedBoxes.addAll([0, 4, 8]);
        stopTimer();
        updateScore(showXO[0]);
      });
    }
    // 2nd diagonal column
    if (showXO[2] == showXO[4] && showXO[2] == showXO[6] && showXO[2] != '') {
      setState(() {
        winner = "Player ${showXO[2]} wins";
        matchedBoxes.addAll([2, 4, 6]);
        stopTimer();
        updateScore(showXO[2]);
      });
    }
    if (!winnerFound && filledBoxex == 9) {
      setState(() {
        stopTimer();
        winner = 'Draw!';
      });
    }
  }

  void updateScore(String winner) {
    if (winner == '0') {
      oScore++;
    } else if (winner == "X") {
      xScore++;
    }
    winnerFound = true;
  }

  void clearBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        showXO[i] = '';
      }
      winner = '';
    });
    filledBoxex = 0;
    oScore = 0;
    xScore = 0;
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (seconds > 0) {
          seconds--;
        } else {
          stopTimer();
        }
      });
    });
  }

  void stopTimer() {
    resetTImer();
    timer?.cancel();
  }

  Widget showTimer() {
    final isRunning = timer == null ? false : timer?.isActive;

    return isRunning!
        ? SizedBox(
            width: 70,
            height: 70,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CircularProgressIndicator(
                  value: 1 - seconds / maxSeconds,
                  valueColor: const AlwaysStoppedAnimation(Colors.white),
                  strokeWidth: 10,
                  backgroundColor: Colors.grey.shade800,
                ),
                Center(
                  child: Text('$seconds', style: customFontsWhite),
                )
              ],
            ),
          )
        : ElevatedButton(
            onPressed: () {
              matchedBoxes = [];
              startTimer();
              clearBoard();
              attempts++;
            },
            child: Text(attempts == 0 ? 'Start' : 'Play Again!',
                style: customFontsBlack),
          );
  }

  void resetTImer() => seconds = maxSeconds;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Column(
                    children: [
                      Text(
                        'Player O',
                        style: customFontsWhite,
                      ),
                      Text(oScore.toString(), style: customFontsWhite),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Center(
                  child: Column(
                    children: [
                      Text('Player X', style: customFontsWhite),
                      Text(xScore.toString(), style: customFontsWhite),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Expanded(
              child: GridView.builder(
                itemCount: 9,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      disPlayXO(index);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: matchedBoxes.contains(index)
                              ? Colors.black26
                              : Colors.grey.shade700,
                          borderRadius: BorderRadius.circular(5),
                          border:
                              Border.all(width: 3, color: Colors.grey.shade600),
                        ),
                        child: Center(
                          child: Text(showXO[index], style: customFontsWhite),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Text(winner, style: customFontsWhite),
            const SizedBox(
              height: 10,
            ),
            showTimer()
          ],
        ),
      ),
    );
  }
}
