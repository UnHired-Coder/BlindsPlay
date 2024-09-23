import 'package:flutter/cupertino.dart';

class FadeInWidget extends StatefulWidget {
  final Widget child; // The widget that will be passed as a child

  const FadeInWidget({Key? key, required this.child}) : super(key: key);

  @override
  _FadeInWidgetState createState() => _FadeInWidgetState();
}

class _FadeInWidgetState extends State<FadeInWidget> {
  double _opacity = 0.0; // Initially invisible

  @override
  void initState() {
    super.initState();

    // Trigger the opacity change after a delay to make it visible
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _opacity = 1.0; // Set to fully visible
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _opacity,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeIn, // Optional: Add a curve for the animation
      child: widget.child, // Use the child passed to FadeInWidget
    );
  }
}
