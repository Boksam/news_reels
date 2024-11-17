import 'package:flutter/material.dart';

class SwipeDetector extends StatelessWidget {
  final Widget child;
  final VoidCallback? onSwipeLeft;
  final VoidCallback? onSwipeRight;

  const SwipeDetector({
    Key? key,
    required this.child,
    this.onSwipeLeft,
    this.onSwipeRight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity! > 0 && onSwipeRight != null) {
          onSwipeRight!();
        } else if (details.primaryVelocity! < 0 && onSwipeLeft != null) {
          onSwipeLeft!();
        }
      },
      child: child,
    );
  }
}
