import 'dart:ui';

import 'package:flutter/material.dart';

class BlurredBackgroundImage extends StatelessWidget {
  final String imageUrl;
  final Widget child;

  const BlurredBackgroundImage(
      {Key? key, required this.imageUrl, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      textDirection: TextDirection.ltr,
      fit: StackFit.expand,
      children: [
        ColorFiltered(
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.6),
              BlendMode.darken,
            ),
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
              ),
            )),
        Column(
          children: [
            Expanded(
              flex: 4,
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.4),
                  BlendMode.darken,
                ),
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.fitWidth,
                    )),
              ),
            ),
            const Expanded(
              flex: 1,
              child: SizedBox(),
            ),
            Expanded(
              flex: 3,
              child: child,
            )
          ],
        )
      ],
    );
  }
}
