import 'dart:async';

import 'package:flutter/material.dart';

class LogicGame extends ChangeNotifier {
  bool oTurn = true;
  List<String> displayXO = ['', '', '', '', '', '', '', '', ''];
  List<int> matchedIndexes = [];

  int oScore = 0;
  int xScore = 0;
  int filledBoxes = 0;
  String resultDeclaration = '';
  bool winnerFound = false;
  int attempts = 0;

  static const maxSeconds = 30;
  int seconds = 30;
  Timer? timer;

  void tapped(int index) {
    final isRunning = timer == null ? false : timer!.isActive;
    if (isRunning) {
      if (oTurn && displayXO[index] == '') {
        displayXO[index] = 'O';
        filledBoxes++;
      } else if (!oTurn && displayXO[index] == '') {
        displayXO[index] = 'X';
        filledBoxes++;
      }
      oTurn = !oTurn;
      _checkWinner();
    }
    notifyListeners();
  }

  void _checkWinner() {
    // первая строка
    if (displayXO[0] == displayXO[1] &&
        displayXO[0] == displayXO[2] &&
        displayXO[0] != '') {
      resultDeclaration = 'Player ${displayXO[0]} wins!';
      matchedIndexes.addAll([0, 1, 2]);
      _stopTimer();
      _updateScore(displayXO[0]);
    }
    // вторая строка
    if (displayXO[3] == displayXO[4] &&
        displayXO[3] == displayXO[5] &&
        displayXO[3] != '') {
      resultDeclaration = 'Player ${displayXO[3]} wins!';
      matchedIndexes.addAll([3, 4, 5]);
      _stopTimer();
      _updateScore(displayXO[3]);
    }
    // третья строка
    if (displayXO[6] == displayXO[7] &&
        displayXO[6] == displayXO[8] &&
        displayXO[6] != '') {
      resultDeclaration = 'Player ${displayXO[6]} wins!';
      matchedIndexes.addAll([6, 7, 8]);
      _stopTimer();
      _updateScore(displayXO[6]);
    }
    // первая колонка
    if (displayXO[0] == displayXO[3] &&
        displayXO[0] == displayXO[6] &&
        displayXO[0] != '') {
      resultDeclaration = 'Player ${displayXO[0]} wins!';
      matchedIndexes.addAll([0, 3, 6]);
      _stopTimer();
      _updateScore(displayXO[0]);
    }
    // вторая колонка
    if (displayXO[1] == displayXO[4] &&
        displayXO[1] == displayXO[7] &&
        displayXO[1] != '') {
      resultDeclaration = 'Player ${displayXO[1]} wins!';
      matchedIndexes.addAll([1, 4, 7]);
      _stopTimer();
      _updateScore(displayXO[1]);
    }
    // третья колонка
    if (displayXO[2] == displayXO[5] &&
        displayXO[2] == displayXO[8] &&
        displayXO[2] != '') {
      resultDeclaration = 'Player ${displayXO[2]} wins!';
      matchedIndexes.addAll([2, 5, 8]);
      _stopTimer();
      _updateScore(displayXO[2]);
    }
    // диагональ сверху вниз
    if (displayXO[0] == displayXO[4] &&
        displayXO[0] == displayXO[8] &&
        displayXO[0] != '') {
      resultDeclaration = 'Player ${displayXO[0]} wins!';
      matchedIndexes.addAll([0, 4, 8]);
      _stopTimer();
      _updateScore(displayXO[0]);
    }
    // диагональ снизу вверх
    if (displayXO[6] == displayXO[4] &&
        displayXO[6] == displayXO[2] &&
        displayXO[6] != '') {
      resultDeclaration = 'Player ${displayXO[6]} wins!';
      matchedIndexes.addAll([6, 4, 2]);
      _stopTimer();
      _updateScore(displayXO[6]);
    }
    if (!winnerFound && filledBoxes == 9) {
      resultDeclaration = 'Nobody wins!';
      _stopTimer();
      notifyListeners();
    }
  }

  void _updateScore(String winner) {
    if (winner == 'O') {
      oScore++;
    } else if (winner == 'X') {
      xScore++;
    }
    winnerFound = true;
    notifyListeners();
  }

  void clearBoard() {
    for (int i = 0; i < displayXO.length; i++) {
      displayXO[i] = '';
    }
    resultDeclaration = '';
    matchedIndexes.clear();
    filledBoxes = 0;
    winnerFound = false;
    notifyListeners();
  }

  void startTimer() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        if (seconds > 0) {
          seconds--;
          notifyListeners();
        } else {
          _stopTimer();
        }
      },
    );
  }

  void _stopTimer() {
    _resetTimer();
    timer?.cancel();
  }

  void _resetTimer() {
    seconds = maxSeconds;
    notifyListeners();
  }
}
