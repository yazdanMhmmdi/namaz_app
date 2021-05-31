import 'package:flutter/material.dart';
import 'package:namaz_app/constants/colors.dart';
import 'package:namaz_app/constants/strings.dart';
import 'package:namaz_app/presentation/widget/marjae_large_item.dart';
import 'package:namaz_app/presentation/widget/shohada_item.dart';
import 'package:namaz_app/presentation/widget/videos_item.dart';

class ShohadaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: IColors.lightBrown,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Column(
              children: [
                SizedBox(
                  height: 16,
                ),
                Center(
                  child: Text(
                    "${Strings.shohadaBozorgan}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: IColors.black70,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.end,
                      textDirection: TextDirection.rtl,
                      children: [
                        ShohadaItem(),
                        ShohadaItem(),
                        ShohadaItem(),
                        ShohadaItem(),
                      ],
                    ),
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
