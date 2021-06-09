import 'package:flutter/material.dart';
import 'package:namaz_app/constants/colors.dart';
import 'package:namaz_app/constants/strings.dart';

class MyToolBarText extends StatelessWidget {
  const MyToolBarText({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "${Strings.shohadaBozorgan}",
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: IColors.black70,
      ),
    );
  }
}