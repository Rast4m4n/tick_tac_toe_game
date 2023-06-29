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
    final List<List<int>> winCondition = [
      [0, 1, 2], // первая строка
      [3, 4, 5], // вторая строка
      [6, 7, 8], // третья строка
      [0, 3, 6], // первая колонка
      [1, 4, 7], // вторая колонка
      [2, 5, 8], // третья колонка
      [0, 4, 8], // диагональ сверху вниз
      [6, 4, 2], // диагональ снизу вверх
    ];

    for (var condition in winCondition) {
      var elementCondition = condition[0];
      if (displayXO[condition[0]] != '' &&
          displayXO[condition[0]] == displayXO[condition[1]] &&
          displayXO[condition[0]] == displayXO[condition[2]]) {
        resultDeclaration = 'Игрок ${displayXO[elementCondition]} выиграл';
        matchedIndexes.addAll(condition);
        _stopTimer();
        _updateScore(displayXO[elementCondition]);
        return;
      }
    }

    if (!winnerFound && filledBoxes == 9) {
      resultDeclaration = 'Ничья';
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
