import 'package:flutter/material.dart';
import 'package:namaz_app/constants/colors.dart';

class MarjaeItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, bottom: 16, top: 8),
      child: Container(
        width: 104,
        height: 104,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: IColors.brown,
            boxShadow: [
              BoxShadow(
                  blurRadius: 10,
                  offset: Offset(4, 6),
                  color: IColors.purpleCrimson25)
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                bottom: 8,
              ),
              child: Container(
                width: 88,
                child: Text(
                  "ایس آیت الله خامنه ای",
                  overflow: TextOverflow.ellipsis,
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    fontSize: 14,
                    color: IColors.white85,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
