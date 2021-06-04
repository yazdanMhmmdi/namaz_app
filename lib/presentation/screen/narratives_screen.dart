import 'package:flutter/material.dart';
import 'package:namaz_app/constants/colors.dart';
import 'package:namaz_app/constants/strings.dart';
import 'package:namaz_app/presentation/widget/narratives_item.dart';

class NarrativesScreen extends StatelessWidget {
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
                    "${Strings.narratives}",
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
                  child: ListView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      NarrativesItem(
                        deleteSlidable: false,
                      ),
                      NarrativesItem(
                        deleteSlidable: false,
                      ),
                      NarrativesItem(
                        deleteSlidable: false,
                      ),
                      NarrativesItem(
                        deleteSlidable: false,
                      ),
                      NarrativesItem(
                        deleteSlidable: false,
                      ),
                    ],
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
