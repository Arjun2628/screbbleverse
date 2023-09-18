import 'package:animated_size_and_fade/animated_size_and_fade.dart';
import 'package:flutter/material.dart';

class ShakingWidget extends StatefulWidget {
  final Widget child;

  const ShakingWidget({super.key, required this.child});

  @override
  // ignore: library_private_types_in_public_api
  _ShakingWidgetState createState() => _ShakingWidgetState();
}

class _ShakingWidgetState extends State<ShakingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
          milliseconds:
              300), // Adjust the duration for the desired shaking speed
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startShakeAnimation() {
    _controller.forward(from: 0.0); // Start the animation from the beginning
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSizeAndFade(
      // vsync: this,
      fadeDuration:
          const Duration(milliseconds: 150), // Adjust the fade duration
      child: GestureDetector(
        onTap: _startShakeAnimation,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(_controller.value * 10.0,
                  0), // Adjust the shaking intensity (10.0 here)
              child: child,
            );
          },
          child: widget.child,
        ),
      ),
    );
  }
}
