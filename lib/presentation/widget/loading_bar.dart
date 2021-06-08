import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:namaz_app/constants/colors.dart';

class LoadingBar extends StatelessWidget {
  const LoadingBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpinKitThreeBounce(
      size: 25,
      color: IColors.purpleCrimson,
    );
  }
}
