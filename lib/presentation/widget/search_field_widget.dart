import 'package:flutter/material.dart';
import 'package:namaz_app/constants/assets.dart';
import 'package:namaz_app/constants/colors.dart';
import 'package:namaz_app/constants/strings.dart';

class SearchFieldWidget extends StatelessWidget {
  bool isForward;
  Animation<double> animation;
  TextEditingController searchTextController;
  Function(String) onChanged;
  SearchFieldWidget({
    @required this.isForward,
    @required this.animation,
    @required this.searchTextController,
    @required this.onChanged,
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
            color: IColors.black15,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              keyboardType: TextInputType.text,
              controller: searchTextController,
              onChanged: onChanged,
              style: TextStyle(
                fontSize: 14,
                fontFamily: Assets.basicFont,
              ),
              textDirection: TextDirection.rtl,
              maxLines: 1,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: '${Strings.searchHint}',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
