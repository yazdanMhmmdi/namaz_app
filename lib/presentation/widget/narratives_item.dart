import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:namaz_app/constants/assets.dart';
import 'package:namaz_app/constants/colors.dart';
import 'package:namaz_app/logic/bloc/favorite_bloc.dart';
import 'package:namaz_app/presentation/widget/global_widget.dart';
import 'package:namaz_app/presentation/widget/my_slide_action.dart';

class NarrativesItem extends StatelessWidget {
  bool deleteSlidable = false;
  String title, subTitle;
  String thumbPicture;
  String id;
  Function onTap;
  FavoriteBloc favoriteBloc;
  NarrativesItem({
    @required this.deleteSlidable,
    @required this.title,
    @required this.subTitle,
    @required this.id,
    @required this.onTap,
    this.favoriteBloc,
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
          onTap: () {
            favoriteBloc.add(DeleteNarrativesItem(
                narratives_id: id, user_id: GlobalWidget.user_id));
            favoriteBloc.add(GetFavoriteItems(user_id: GlobalWidget.user_id));
          },
        )
      ],
      child: Padding(
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
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      splashColor: IColors.black15,
                      onTap: onTap,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 8, top: 16, right: 69, bottom: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${title}",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 16,
                                color: IColors.black70,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text("${subTitle}",
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
                      image: DecorationImage(
                        image: AssetImage(Assets.quran),
                      ),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(4, 6),
                          blurRadius: 10,
                          color: IColors.purpleCrimson25,
                        )
                      ]),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  width: 94,
                  height: 94,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: IColors.purpleCrimson65,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
