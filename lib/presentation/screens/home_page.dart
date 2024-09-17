import 'package:flutter/material.dart';
import '../../config/colors.dart';
import '../../config/text_styles.dart';
import '../ui/widgets/RoundedCornnerButton.dart';

class HomePage extends StatelessWidget {
  final List<Map<String, dynamic>> pages;
  final Function(int, BuildContext) navigateToPage;

  HomePage({required this.pages, required this.navigateToPage});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: AppColors.primary,
        body: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(image: AssetImage('assets/tic_tac_toe_anim.png'), width: screenWidth/4,),
                // GameModeWidget(
                //   title: 'Play now',
                //   description: 'Play against similar rated players',
                //   imageUrl: 'assets/favicon.png',
                // ),
                // SizedBox(width: 16),
                // GameModeWidget(
                //   title: 'Play now',
                //   description: 'Play against similar rated players',
                //   imageUrl: 'assets/favicon.png',
                // )
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // GameModeWidget(
                //   title: 'Play now',
                //   description: 'Play against similar rated players',
                //   imageUrl: 'assets/favicon.png',
                // ),
                SizedBox(height: 200),
                Stack(
                  fit: StackFit.loose,
                  alignment: Alignment.center,
                  children: [
                    Container(
                        width: screenWidth/2,
                        child: Column(
                          children: [
                            Text(
                              "Blind-Sight Tic Tac Toe takes the classic game of tic-tac-toe and adds a memory challenge."
                                  " In this simplified version, players take turns placing their marks (X or O) on a 3x3 grid, "
                                  "aiming to line up three in a row to win.",
                              textAlign: TextAlign.center,
                              style: AppTextStyles.bodyTextLarge.copyWith(
                                  color: AppColors.onPrimary),
                              softWrap: true,
                            ),
                            SizedBox(height: 20),
                            Text(
                              "But here's the twist: after each move, the board hides the marks, showing only neutral indicators"
                                  " instead of Xs and Os. Players must rely on memory to track their own and their opponent's moves.",
                              textAlign: TextAlign.center,
                              style: AppTextStyles.bodyTextLarge.copyWith(
                                  color: AppColors.accent),
                              softWrap: true,
                            ),
                            SizedBox(height: 20),
                            Text(
                              "Plan your strategy, remember your placements, and outsmart your opponent to win!",
                              textAlign: TextAlign.center,
                              style: AppTextStyles.bodyTextLarge.copyWith(
                                  color: AppColors.onPrimary),
                              softWrap: true,
                            )
                          ],
                        )),
                  ],
                ),
                // GameModeWidget(
                //   title: 'Play now',
                //   description: 'Play against similar rated players',
                //   imageUrl: 'assets/favicon.png',
                // )
              ],
            ),
            SizedBox(height: 60),
            RoundedCornerButton(
              text: "Compete online!",
              icon: AssetImage("assets/ic_lightning.png"),
              onPressed: () {},
            ),
            SizedBox(height: 30),
            RoundedCornerButton(
              text: "Compete online!",
              icon: AssetImage("assets/ic_play.png"),
              onPressed: () {},
            )
          ],
        ));
  }
}
