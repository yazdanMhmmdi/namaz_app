import 'package:flutter/material.dart';
import 'package:namaz_app/constants/colors.dart';

class FontSizeButtonWidget extends StatelessWidget {
  bool isDarkMode = false;
  Widget icon;
  Function onTap;
  FontSizeButtonWidget(
      {@required this.isDarkMode, @required this.icon, @required this.onTap});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 25,
      height: 25,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: isDarkMode ? IColors.darkLightPink : IColors.purpleCrimson,
      ),
      child: Material(
        child: InkWell(
          splashColor: isDarkMode ? IColors.darkWhite25 : IColors.black15,
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: icon,
        ),
      ),
    );
  }
}
