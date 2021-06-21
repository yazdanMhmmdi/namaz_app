import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:namaz_app/constants/colors.dart';
import 'package:namaz_app/presentation/widget/my_slide_action.dart';

class VideosItem extends StatelessWidget {
  bool deleteSlidable = false;
  String title;
  String thumbnail;
  Function onTap;
  VideosItem({
    @required this.deleteSlidable,
    @required this.title,
    @required this.thumbnail,
    @required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      enabled: deleteSlidable,
      secondaryActions: <Widget>[
        MyIconSlideAction(
          caption: 'حذف',
          color: Colors.red,
          icon: Icons.delete,
          actionBorderRadius: 8,
          onTap: () {},
        )
      ],
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Container(
          height: 94,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.circular(20),
              color: IColors.white85,
              boxShadow: [
                BoxShadow(
                  offset: Offset(4, 6),
                  blurRadius: 10,
                  color: IColors.purpleCrimson25,
                )
              ]),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              splashColor: IColors.black15,
              onTap: onTap,
              child: Stack(
                children: [
                  Container(
                    width: 94,
                    height: 94,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: IColors.purpleCrimson,
                    ),
                    child: Center(
                      child: Container(
                        width: 26,
                        height: 26,
                        decoration: BoxDecoration(
                          color: Colors.white54,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.play_arrow_rounded,
                          color: IColors.purpleCrimson,
                          size: 25,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 102),
                          child: Container(
                            child: Text(
                              "${title}",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: IColors.black70,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/*
Positioned(
                bottom: 16,
                right: 16,
                child: Text(
                  "آموزش وضو گرفتن",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: IColors.white85,
                  ),
                ),
              ),
              Positioned(
                bottom: 16,
                left: 16,
                child: Container(
                  width: 26,
                  height: 26,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 6,
                            offset: Offset(0, 6),
                            color: IColors.black25)
                      ]),
                  child: Icon(
                    Icons.play_arrow_rounded,
                    color: IColors.purpleCrimson,
                    size: 25,
                  ),
                ),
              ),


*/
