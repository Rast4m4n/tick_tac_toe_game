import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tick_tac_toe_game/constants/app_colors.dart';
import 'package:tick_tac_toe_game/screens/logic_game.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  static var customFontWhite = GoogleFonts.coiny(
    textStyle: const TextStyle(
      color: Colors.white,
      letterSpacing: 3,
      fontSize: 28,
    ),
  );

  final logic = LogicGame();

  Widget _buildTimer() {
    final isRunning = logic.timer == null ? false : logic.timer!.isActive;

    return isRunning
        ? SizedBox(
            width: 100,
            height: 100,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CircularProgressIndicator(
                  value: 1 - logic.seconds / LogicGame.maxSeconds,
                  valueColor: const AlwaysStoppedAnimation(Colors.white),
                  strokeWidth: 8,
                  backgroundColor: AppColors.accentColor,
                ),
                Center(
                  child: Text(
                    logic.seconds.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 50,
                    ),
                  ),
                ),
              ],
            ),
          )
        : ElevatedButton(
            onPressed: () {
              logic.startTimer();
              logic.clearBoard();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: 32,
                vertical: 16,
              ),
            ),
            child: Text(
              logic.attempts == 0 ? 'Начать!' : 'Играть заново!',
              style: const TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
            ),
          );
  }

  @override
  void initState() {
    logic.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Player o',
                          style: customFontWhite,
                        ),
                        Text(
                          logic.oScore.toString(),
                          style: customFontWhite,
                        ),
                      ],
                    ),
                    const SizedBox(width: 18),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Player x',
                          style: customFontWhite,
                        ),
                        Text(
                          logic.xScore.toString(),
                          style: customFontWhite,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: GridView.builder(
                  itemCount: 9,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        logic.tapped(index);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            width: 5,
                            color: AppColors.primaryColor,
                          ),
                          color: logic.matchedIndexes.contains(index)
                              ? Colors.blue
                              : AppColors.secondaryColor,
                        ),
                        child: Center(
                          child: Text(
                            logic.displayXO[index],
                            style: GoogleFonts.coiny(
                              textStyle: const TextStyle(
                                fontSize: 64,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                flex: 1,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        logic.resultDeclaration,
                        style: customFontWhite,
                      ),
                      const SizedBox(height: 10),
                      _buildTimer(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
