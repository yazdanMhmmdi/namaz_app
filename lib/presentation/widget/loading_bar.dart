import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:namaz_app/constants/colors.dart';

class LoadingBar extends StatelessWidget {
  Color color = IColors.purpleCrimson;
  LoadingBar({this.color});

  @override
  Widget build(BuildContext context) {
    return SpinKitThreeBounce(
        size: 25,
        color: color == null ? IColors.purpleCrimson : color);
  }
}
