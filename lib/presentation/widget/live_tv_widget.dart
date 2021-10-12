import 'package:flutter/material.dart';
import 'package:namaz_app/constants/colors.dart';

class LiveTvWidget extends StatelessWidget {
  bool isDarkMode = false;
  LiveTvWidget({@required this.isDarkMode});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: isDarkMode ? IColors.darkLightPink : IColors.purpleCrimson),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.live_tv,
              color: IColors.white85,
              size: 20,
            ),
            SizedBox(
              width: 4,
            ),
            Container(
              color: Colors.transparent,
              child: Text(
                "زنده",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: IColors.white85,
                ),
              ),
            ),

            // Container(
            //   width: 8,
            //   height: 8,
            //   decoration: BoxDecoration(
            //     shape: BoxShape.circle,
            //     color: IColors.white85,
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
