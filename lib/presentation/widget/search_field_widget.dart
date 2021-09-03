import 'package:flutter/material.dart';
import 'package:namaz_app/constants/assets.dart';
import 'package:namaz_app/constants/colors.dart';
import 'package:namaz_app/constants/strings.dart';

class SearchFieldWidget extends StatelessWidget {
  bool isForward;
  Animation<double> animation;
  TextEditingController searchTextController;
  Function(String) onChanged;
  bool isDarkMode = false;
  SearchFieldWidget({
    @required this.isForward,
    @required this.animation,
    @required this.searchTextController,
    @required this.onChanged,
    @required this.isDarkMode,
  });
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isForward,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Container(
          width: animation.value,
          height: 45,
          decoration: BoxDecoration(
            color: isDarkMode ? IColors.darkWhite15 : IColors.black15,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.only(right: 16.0, bottom: 2),
            child: TextField(
              keyboardType: TextInputType.text,
              controller: searchTextController,
              onChanged: onChanged,
              style: TextStyle(
                  fontSize: 14,
                  fontFamily: Assets.basicFont,
                  color: isDarkMode ? IColors.darkWhite70 : IColors.black70),
              textDirection: TextDirection.rtl,
              maxLines: 1,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintStyle: TextStyle(
                    color: isDarkMode ? IColors.darkWhite70 : IColors.black70),
                hintText: '${Strings.searchHint}',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
