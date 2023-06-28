import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tick_tac_toe_game/ui/themes/app_colors.dart';
import 'package:tick_tac_toe_game/logic/logic_game.dart';

import '../themes/app_paddings.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ChangeNotifierProvider(
            create: (_) => LogicGame(),
            child: Column(
              children: const [
                SizedBox(height: AppPaddings.low),
                _ScoreWidget(),
                SizedBox(height: AppPaddings.low),
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

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Игрок о',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Text(
                context.watch<LogicGame>().oScore.toString(),
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Игрок х',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Text(
                context.watch<LogicGame>().xScore.toString(),
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
        ),
      ],
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
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.secondaryColor),
                color: context.watch<LogicGame>().matchedIndexes.contains(index)
                    ? AppColors.secondaryColor
                    : AppColors.primaryColor,
              ),
              child: Center(
                child: Text(
                  context.watch<LogicGame>().displayXO[index],
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        fontSize: 64,
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

  Widget _buildTimer(BuildContext context) {
    final isRunning = context.watch<LogicGame>().timer == null
        ? false
        : context.watch<LogicGame>().timer!.isActive;

    return isRunning
        ? SizedBox(
            width: 75,
            height: 75,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CircularProgressIndicator(
                  value: 1 -
                      context.watch<LogicGame>().seconds / LogicGame.maxSeconds,
                  valueColor: const AlwaysStoppedAnimation(Colors.white),
                  strokeWidth: 8,
                  backgroundColor: AppColors.primaryColor,
                ),
                Center(
                  child: Text(
                    context.watch<LogicGame>().seconds.toString(),
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                          fontSize: 28,
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
                horizontal: AppPaddings.low * 4,
                vertical: AppPaddings.low * 2,
              ),
            ),
            child: Text(
              'Начать',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: AppColors.black,
                  ),
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              context.watch<LogicGame>().resultDeclaration,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: AppPaddings.low),
            _buildTimer(context),
          ],
        ),
      ),
    );
  }
}
