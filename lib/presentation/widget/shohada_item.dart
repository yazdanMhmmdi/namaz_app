import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:namaz_app/constants/colors.dart';
import 'package:namaz_app/logic/bloc/favorite_bloc.dart';
import 'package:namaz_app/networking/api_provider.dart';
import 'package:namaz_app/presentation/widget/global_widget.dart';
import 'package:namaz_app/presentation/widget/my_slide_action.dart';

class ShohadaItem extends StatelessWidget {
  // bool delete = false;
  // ShohadaItem({@required this.delete});
  String title;
  String largePicture;
  Function onTap;
  bool deleteSlidable = false;
  FavoriteBloc favoriteBloc;
  String shohada_id;
  ShohadaItem({
    @required this.title,
    @required this.largePicture,
    @required this.onTap,
    @required this.deleteSlidable,
    this.favoriteBloc,
    @required this.shohada_id,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 14, top: 14),
      child: Container(
        width: 150,
        height: 170,
        decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(ApiProvider.IMAGE_PROVIDER + largePicture),
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
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: Colors.white12,
            onTap: onTap,
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    favoriteBloc.add(DeleteShohadaItem(
                        user_id: GlobalWidget.user_id, shohada_id: shohada_id));
                    favoriteBloc
                        .add(GetFavoriteItems(user_id: GlobalWidget.user_id));
                  },
                  child: deleteSlidable
                      ? Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.delete,
                              color: IColors.white85,
                            ),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(8),
                              topRight: Radius.circular(8),
                            ),
                            color: Colors.red,
                          ),
                        )
                      : Container(),
                ),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(bottom: 16, left: 8, right: 8),
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
        ),
      ),
    );
  }
}
