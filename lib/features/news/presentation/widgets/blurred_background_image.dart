import 'dart:ui';
import 'package:flutter/material.dart';

class BlurredBackground extends StatelessWidget {
  final String imageUrl;
  final Widget child;
  final double sigma;
  final double opacity;

  const BlurredBackground({
    Key? key,
    required this.imageUrl,
    required this.child,
    this.sigma = 10,
    this.opacity = 0.6,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        ColorFiltered(
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(opacity),
            BlendMode.darken,
          ),
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: sigma, sigmaY: sigma),
            child: Image.network(imageUrl, fit: BoxFit.cover),
          ),
        ),
        child,
      ],
    );
  }
}
