import 'package:flutter/material.dart';
import 'package:namaz_app/constants/colors.dart';

class ShohadaItem extends StatelessWidget {
  // bool delete = false;
  // ShohadaItem({@required this.delete});
  String title;
  String largePicture;
  ShohadaItem({@required this.title, @required this.largePicture});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 14, top: 14),
      child: Container(
        width: 150,
        height: 170,
        decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(largePicture),
              colorFilter:
                  ColorFilter.mode(IColors.purpleCrimson65, BlendMode.srcOver),
            ),
            borderRadius: BorderRadius.circular(20),
            color: IColors.brown,
            boxShadow: [
              BoxShadow(
                offset: Offset(4, 6),
                blurRadius: 10,
                color: IColors.purpleCrimson25,
              )
            ]),
        child: Stack(
          children: [
            Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16, left: 8, right: 8),
                  child: Text(
                    "${title}",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: IColors.white85,
                      fontSize: 14,
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
