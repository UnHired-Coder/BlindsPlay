import 'package:flutter/cupertino.dart';

class CenteredEllipticalGradientTransform extends GradientTransform {
  final double scaleX;
  final double scaleY;

  const CenteredEllipticalGradientTransform(
      {required this.scaleX, required this.scaleY});

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
