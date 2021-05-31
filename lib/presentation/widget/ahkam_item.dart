import 'package:flutter/material.dart';
import 'package:namaz_app/constants/assets.dart';
import 'package:namaz_app/constants/colors.dart';

class AhkamItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Container(
        width: MediaQuery.of(context).size.width - 32,
        height: 46,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.only(right: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Align(
                  alignment: Alignment.centerRight,
                  child: Stack(
                    children: [
                      Image.asset(Assets.smallShamse),
                      Container(
                        width: 30,
                        height: 30,
                        child: Center(
                          child: Text(
                            "13",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: IColors.brown,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Text(
                    'این یک متن موقتی است!!! این یک متن موقتی است!!! این یک متن موقتی است!!!',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      color: IColors.black70,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}