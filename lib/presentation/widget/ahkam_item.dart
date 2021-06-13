import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:namaz_app/constants/assets.dart';
import 'package:namaz_app/constants/colors.dart';
import 'package:namaz_app/presentation/widget/my_slide_action.dart';

class AhkamItem extends StatelessWidget {
  bool deleteSlidable = false;
  String title,id;
  AhkamItem({@required this.deleteSlidable, @required this.title, @required this.id});
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
                              "${id}",
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
                      '${title}',
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
      ),
    );
  }
}
