
import 'package:flare_loading/flare_loading.dart';
import 'package:flutter/material.dart';
import 'package:namaz_app/constants/assets.dart';

class NoNetworkFlare extends StatelessWidget {
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
          '! اتصال به شبکه قطع شد',
          style: TextStyle(
              fontFamily: "IranSans",
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.black87),
        ),
        Text(
          'لطفا اتصال به اینترنت خود را بررسی کنید',
          style: TextStyle(
              fontFamily: "IranSans", fontSize: 18, color: Colors.black87),
        ),
      ],
    );
  }
}
