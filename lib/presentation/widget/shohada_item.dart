import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:namaz_app/constants/colors.dart';
import 'package:namaz_app/logic/bloc/favorite_bloc.dart';
import 'package:namaz_app/networking/api_provider.dart';
import 'package:namaz_app/presentation/widget/global_widget.dart';
import 'package:namaz_app/presentation/widget/my_slide_action.dart';
import 'package:octo_image/octo_image.dart';

class ShohadaItem extends StatelessWidget {
  // bool delete = false;
  // ShohadaItem({@required this.delete});
  String title;
  String largePicture;
  Function onTap;
  bool deleteSlidable = false;
  FavoriteBloc favoriteBloc;
  String shohada_id;
  String searchedText;
  String hash;
  bool isDarkMode = false;

  ShohadaItem({
    @required this.title,
    @required this.largePicture,
    @required this.onTap,
    @required this.deleteSlidable,
    @required this.hash,
    this.favoriteBloc,
    @required this.shohada_id,
    @required this.isDarkMode,
    this.searchedText,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 14, top: 14),
      child: Container(
        width: 150,
        height: 170,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: IColors.brown,
            boxShadow: [
              BoxShadow(
                offset: Offset(4, 6),
                blurRadius: 10,
                color: isDarkMode
                    ? IColors.darkLightPink25
                    : IColors.purpleCrimson25,
              )
            ]),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: OctoImage(
                image: CachedNetworkImageProvider(
                  ApiProvider.IMAGE_PROVIDER + largePicture,
                ),
                placeholderBuilder: OctoPlaceholder.blurHash(
                    // 'LEHV6nWB2yk8pyo0adR*.7kCMdnj',
                    hash),
                errorBuilder: OctoError.icon(color: Colors.red),
                fit: BoxFit.cover,
              ),
            ),
            Container(
                decoration: BoxDecoration(
              color: isDarkMode
                  ? IColors.darkLightPink65
                  : IColors.purpleCrimson65,
              borderRadius: BorderRadius.circular(20),
            )),
            Material(
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
                            user_id: GlobalWidget.user_id,
                            shohada_id: shohada_id));
                        favoriteBloc.add(
                            GetFavoriteItems(user_id: GlobalWidget.user_id));
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
                          padding: const EdgeInsets.only(
                              bottom: 16, left: 8, right: 8),
                          child: RichText(
                            text: searchMatch("${title}"),
                            overflow: TextOverflow.ellipsis,
                          ),
                        )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextSpan searchMatch(String match) {
    TextStyle posRes = TextStyle(
          backgroundColor: IColors.brown,
          color: isDarkMode ? IColors.darkBlack85 : IColors.white85,
          fontSize: 14,
          fontWeight: FontWeight.w700,
          fontFamily: "IranSans",
        ),
        negRes = TextStyle(
          backgroundColor: Colors.transparent,
          color: IColors.white85,
          fontSize: 14,
          fontWeight: FontWeight.w700,
          fontFamily: "IranSans",
        );
    if (searchedText == null || searchedText == "")
      return TextSpan(text: match, style: negRes);
    var refinedMatch = match.toLowerCase();
    var refinedSearch = searchedText.toLowerCase();
    if (refinedMatch.contains(refinedSearch)) {
      if (refinedMatch.substring(0, refinedSearch.length) == refinedSearch) {
        return TextSpan(
          style: posRes,
          text: match.substring(0, refinedSearch.length),
          children: [
            searchMatch(
              match.substring(
                refinedSearch.length,
              ),
            ),
          ],
        );
      } else if (refinedMatch.length == refinedSearch.length) {
        return TextSpan(text: match, style: posRes);
      } else {
        return TextSpan(
          style: negRes,
          text: match.substring(
            0,
            refinedMatch.indexOf(refinedSearch),
          ),
          children: [
            searchMatch(
              match.substring(
                refinedMatch.indexOf(refinedSearch),
              ),
            ),
          ],
        );
      }
    } else if (!refinedMatch.contains(refinedSearch)) {
      return TextSpan(text: match, style: negRes);
    }
    return TextSpan(
      text: match.substring(0, refinedMatch.indexOf(refinedSearch)),
      style: negRes,
      children: [
        searchMatch(match.substring(refinedMatch.indexOf(refinedSearch)))
      ],
    );
  }
}
