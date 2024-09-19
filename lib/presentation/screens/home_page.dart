import 'package:flutter/material.dart';
import '../../config/colors.dart';
import '../../config/text_styles.dart';
import '../ui/widgets/RoundedCornerButton.dart';
import 'game_page.dart';

class HomePage extends StatelessWidget {
  final List<Map<String, dynamic>> pages;
  final Function(int, BuildContext) navigateToPage;

  HomePage({required this.pages, required this.navigateToPage});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: AppColors.primary,
        body: Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [Colors.black.withOpacity(0.3), AppColors.primary.withOpacity(0.5), AppColors.primary],
                stops: const [0.3, 0.7, 1.0],
                center: Alignment.center,
                radius: 1,
                // Applying GradientTransform to create an elliptical gradient
                transform: CenteredEllipticalGradientTransform(scaleX: 1.2, scaleY: 0.4)
                , // Stretch horizontally and shrink vertically
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      image: AssetImage('assets/tic_tac_toe_anim.png'),
                      width: screenWidth / 4,
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        width: screenWidth / 2,
                        child: Column(
                          children: [
                            Text(
                              "Played classic tic-tac-toe?",
                              textAlign: TextAlign.center,
                              style: AppTextStyles.bodyTextLarge
                                  .copyWith(color: AppColors.onPrimary),
                              softWrap: true,
                            ),
                            SizedBox(height: 20),
                            Text(
                              "Get ready for a new challenge!, after each move, the board hides the marks, showing only neutral indicators"
                              " instead of Xs and Os. Players must rely on memory to track their own and their opponent's moves.",
                              textAlign: TextAlign.center,
                              style: AppTextStyles.bodyTextLarge
                                  .copyWith(color: AppColors.accent),
                              softWrap: true,
                            ),
                            SizedBox(height: 20),
                            Text(
                              "Plan your strategy, remember your placements, and outsmart your opponent to win!",
                              textAlign: TextAlign.center,
                              style: AppTextStyles.bodyTextLarge
                                  .copyWith(color: AppColors.onPrimary),
                              softWrap: true,
                            )
                          ],
                        )),
                  ],
                ),
                SizedBox(height: 60),
                RoundedCornerButton(
                  text: "Compete online!",
                  icon: AssetImage("assets/ic_lightning.png"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GamePage(boardSize: 3) as Widget,
                      ),
                    );
                  },
                ),
                SizedBox(height: 30),
                RoundedCornerButton(
                  text: "Play now!",
                  icon: AssetImage("assets/ic_play.png"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GamePage(boardSize: 3) as Widget,
                      ),
                    );
                  },
                )
              ],
            )));
  }
}


// Custom Gradient Transform class for centered elliptical scaling with dynamic scale factors
class CenteredEllipticalGradientTransform extends GradientTransform {
  final double scaleX;
  final double scaleY;

  CenteredEllipticalGradientTransform({required this.scaleX, required this.scaleY});

  @override
  Matrix4 transform(Rect bounds, {TextDirection? textDirection}) {
    // Create a custom transformation matrix
    final matrix = Matrix4.identity();

    // Calculate the center of the bounds
    final centerX = bounds.width / 2;
    final centerY = bounds.height / 2;

    // Step 1: Translate the gradient to the origin (center)
    matrix.translate(centerX - 50, centerY + 150);

    // Step 2: Apply dynamic scaling
    matrix.scale(scaleX, scaleY);

    // Step 3: Translate back to the original position
    matrix.translate(-centerX, -centerY);

    return matrix;
  }
}