import 'package:flutter/material.dart';
import 'package:namaz_app/constants/assets.dart';

class BackgroundShapes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 10,
          left: 10,
          child: Image.asset(Assets.topLeftShape),
        ),
        Positioned(top: 0, right: 0, child: Image.asset(Assets.topRightShape)),
        Positioned(
          bottom: 0,
          left: 0,
          child: Image.asset(Assets.bottomLeftShape),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Image.asset(Assets.bottomRightShape),
        )
      ],
    );
  }
}
