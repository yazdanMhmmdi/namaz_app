import 'package:flutter/material.dart';
import 'package:namaz_app/constants/colors.dart';

class FontSizeIndicatorWidget extends StatelessWidget {
  bool isDarkMode = false;
  String text;
  FontSizeIndicatorWidget({@required this.isDarkMode, @required this.text});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        width: 35,
        color: Colors.transparent,
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: isDarkMode ? IColors.darkWhite70 : IColors.black70),
          ),
        ),
      ),
    );
  }
}
