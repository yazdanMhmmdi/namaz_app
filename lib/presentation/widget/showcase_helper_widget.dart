import 'package:flutter/material.dart';
import 'package:namaz_app/constants/colors.dart';
import 'package:showcaseview/showcaseview.dart';

class ShowcaseHelperWidget extends StatelessWidget {
  String text;
  GlobalKey key;
  Duration duration;
  Color showcaseBackgroundColor = IColors.white85;
  double fontSize = 0;
  Widget child;
  ShowcaseHelperWidget({
    @required this.text,
    @required this.key,
    @required this.duration,
    this.showcaseBackgroundColor,
    @required this.fontSize,
    @required this.child,
  });
  @override
  Widget build(BuildContext context) {
    return Showcase(
        description: text,
        key: key,
        animationDuration: duration,
        showcaseBackgroundColor: IColors.white85,
        descTextStyle:
            TextStyle(fontSize: 16 + fontSize, color: IColors.black70),
        child: child);
  }
}
