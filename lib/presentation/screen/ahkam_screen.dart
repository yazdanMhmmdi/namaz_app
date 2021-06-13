import 'package:flutter/material.dart';
import 'package:namaz_app/constants/assets.dart';
import 'package:namaz_app/constants/colors.dart';
import 'package:namaz_app/constants/strings.dart';
import 'package:namaz_app/presentation/widget/ahkam_item.dart';
import 'package:namaz_app/presentation/widget/marjae_large_item.dart';
import 'package:namaz_app/presentation/widget/shohada_item.dart';
import 'package:namaz_app/presentation/widget/videos_item.dart';

class AhkamScreen extends StatelessWidget {
  Map<String, String> arguments;
  Map<String, String> args;
  String marjae_id;

  AhkamScreen({this.args});
  @override
  Widget build(BuildContext context) {
    arguments = args;
    _getArguments();
    print(marjae_id);
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
                    "این یک متن موقتی است",
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
                    child: ListView(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        AhkamItem(
                          deleteSlidable: false,
                        ),
                        AhkamItem(
                          deleteSlidable: false,
                        ),
                        AhkamItem(
                          deleteSlidable: false,
                        ),
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

  void _getArguments() {
    marjae_id = arguments['marjae_id'];
  }
}
