import 'package:flutter/material.dart';
import 'package:namaz_app/constants/colors.dart';
import 'package:namaz_app/constants/strings.dart';

class PushPinnedWidget extends StatelessWidget {
  bool isDarkMode = false;
  PushPinnedWidget({@required this.isDarkMode});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, top: 8),
      child: Align(
        alignment: Alignment.topLeft,
        child: Container(
          decoration: BoxDecoration(
            // borderRadius: BorderRadiusDirectional.only(
            //     topEnd: Radius.circular(20)),
            borderRadius: BorderRadius.circular(20),
            color: isDarkMode ? IColors.darkLightPink : IColors.purpleCrimson,
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.push_pin,
                  color: IColors.white85,
                  size: 14,
                ),
                Text(
                  Strings.pushPinned,
                  style: TextStyle(
                    color: IColors.white85,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
