import 'package:flutter/material.dart';
import 'package:namaz_app/constants/colors.dart';

class BackButtonWidget extends StatelessWidget {
  Function onTap;
  BackButtonWidget({@required this.onTap});
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: IColors.brown,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            Icons.arrow_back,
            color: IColors.white85,
            size: 16,
          ),
        ),
      ),
    );
  }
}
