import 'package:flutter/material.dart';
import 'package:namaz_app/constants/colors.dart';

class NarrativesItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Container(
        height: 123,
        child: Stack(
          children: [
            Positioned(
              right: 33,
              child: Container(
                width: MediaQuery.of(context).size.width - 65,
                height: 123,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 8, top: 16, right: 69, bottom: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "امام کاظم (ع):",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 16,
                          color: IColors.black70,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text("سشییش سیشی شیشسی شس یشسیسشی شس امام کاظم (ع):",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          style: TextStyle(
                            fontSize: 14,
                            color: IColors.black45,
                          )),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: 94,
                height: 94,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: IColors.brown,
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(4, 6),
                        blurRadius: 10,
                        color: IColors.purpleCrimson25,
                      )
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
