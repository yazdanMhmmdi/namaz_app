import 'package:flutter/material.dart';
import 'package:namaz_app/constants/colors.dart';
import 'package:namaz_app/constants/strings.dart';

class EmptyWidget extends StatelessWidget {
  bool isDarkMode = false;
  EmptyWidget({@required this.isDarkMode});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height - 200,
      child: Center(
          child: Text("${Strings.emptyNote}",
              style: TextStyle(
                  color: isDarkMode ? IColors.darkWhite45 : IColors.black45))),
    );
  }
}
