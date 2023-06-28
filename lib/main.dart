import 'package:flutter/material.dart';
import 'package:tick_tac_toe_game/ui/screens/game.dart';
import 'package:tick_tac_toe_game/ui/themes/app_theme.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Крестики-нолики',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const GameScreen(),
    );
  }
}
