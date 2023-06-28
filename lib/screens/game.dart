import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tick_tac_toe_game/constants/app_colors.dart';
import 'package:tick_tac_toe_game/screens/logic_game.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ChangeNotifierProvider.value(
            value: LogicGame(),
            child: Column(
              children: const [
                _ScoreWidget(),
                PlayingFieldWidget(),
                _StartGameWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ScoreWidget extends StatelessWidget {
  const _ScoreWidget();
  static var customFontWhite = GoogleFonts.coiny(
    textStyle: const TextStyle(
      color: Colors.white,
      letterSpacing: 3,
      fontSize: 28,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
                context.watch<LogicGame>().oScore.toString(),
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
                context.watch<LogicGame>().xScore.toString(),
                style: customFontWhite,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PlayingFieldWidget extends StatelessWidget {
  const PlayingFieldWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: GridView.builder(
        itemCount: 9,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              context.read<LogicGame>().tapped(index);
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  width: 5,
                  color: AppColors.primaryColor,
                ),
                color: context.watch<LogicGame>().matchedIndexes.contains(index)
                    ? Colors.blue
                    : AppColors.secondaryColor,
              ),
              child: Center(
                child: Text(
                  context.watch<LogicGame>().displayXO[index],
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
    );
  }
}

class _StartGameWidget extends StatelessWidget {
  const _StartGameWidget();

  static var customFontWhite = GoogleFonts.coiny(
    textStyle: const TextStyle(
      color: Colors.white,
      letterSpacing: 3,
      fontSize: 28,
    ),
  );

  Widget _buildTimer(BuildContext context) {
    final isRunning = context.watch<LogicGame>().timer == null
        ? false
        : context.watch<LogicGame>().timer!.isActive;

    return isRunning
        ? SizedBox(
            width: 100,
            height: 100,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CircularProgressIndicator(
                  value: 1 -
                      context.watch<LogicGame>().seconds / LogicGame.maxSeconds,
                  valueColor: const AlwaysStoppedAnimation(Colors.white),
                  strokeWidth: 8,
                  backgroundColor: AppColors.accentColor,
                ),
                Center(
                  child: Text(
                    context.watch<LogicGame>().seconds.toString(),
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
              context.read<LogicGame>().startTimer();
              context.read<LogicGame>().clearBoard();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: 32,
                vertical: 16,
              ),
            ),
            child: Text(
              context.watch<LogicGame>().attempts == 0
                  ? 'Начать!'
                  : 'Играть заново!',
              style: const TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              context.watch<LogicGame>().resultDeclaration,
              style: customFontWhite,
            ),
            const SizedBox(height: 8),
            _buildTimer(context),
          ],
        ),
      ),
    );
  }
}
