import 'package:flare_loading/flare_loading.dart';
import 'package:flutter/material.dart';
import 'package:namaz_app/constants/assets.dart';
import 'package:namaz_app/constants/colors.dart';
import 'package:namaz_app/constants/strings.dart';

class NoNetworkFlare extends StatelessWidget {
  NoNetworkFlare({@required this.isDarkMode});
  bool isDarkMode = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: FlareLoading(
              width: 306,
              height: 265,
              name: Assets.noNetworkFlare,
              startAnimation: 'no_netwrok',
              loopAnimation: 'no_netwrok',
              onSuccess: (data) {},
              onError: (a, b) {}),
        ),
        Text(
          Strings.noNetworkTitle,
          style: TextStyle(
              fontFamily: "IranSans",
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: isDarkMode ? IColors.darkWhite70 : Colors.black87),
        ),
        Text(
          Strings.noNetworkCause,
          style: TextStyle(
              fontFamily: "IranSans",
              fontSize: 18,
              color: isDarkMode ? IColors.darkWhite70 : Colors.black87),
        ),
      ],
    );
  }
}
