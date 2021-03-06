import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:namaz_app/constants/colors.dart';
import 'package:namaz_app/constants/strings.dart';
import 'package:namaz_app/constants/values.dart';
import 'package:namaz_app/logic/bloc/favorite_bloc.dart';
import 'package:namaz_app/logic/bloc/showcase_bloc.dart';
import 'package:namaz_app/networking/api_provider.dart';
import 'package:namaz_app/presentation/widget/global_widget.dart';
import 'package:namaz_app/presentation/widget/my_slide_action.dart';
import 'package:namaz_app/presentation/widget/push_pinned_widget.dart';
import 'package:namaz_app/presentation/widget/showcase_helper_widget.dart';
import 'package:octo_image/octo_image.dart';

class VideosItem extends StatelessWidget {
  bool deleteSlidable = false;
  String title;
  String thumbnail;
  Function onTap;
  FavoriteBloc favoriteBloc;
  String video_id;
  String searchedText;
  String blurhash;
  bool isPinned;
  bool isDarkMode = false;
  double fontSize = 0;
  int itemIndex = 0;
  GlobalKey _one = GlobalKey();
  ShowcaseBloc _showcaseBloc = ShowcaseBloc();
  bool needShowcase = false;

  VideosItem({
    @required this.video_id,
    @required this.deleteSlidable,
    @required this.title,
    @required this.thumbnail,
    @required this.onTap,
    @required this.blurhash,
    @required this.isPinned,
    @required this.isDarkMode,
    @required this.fontSize,
    @required this.itemIndex,
    @required this.needShowcase,
    this.favoriteBloc,
    this.searchedText,
  });
  @override
  Widget build(BuildContext context) {
    return itemIndex == 0 && needShowcase
        ? ShowcaseHelperWidget(
            text: Strings.showcaseFavoriteItemGuide,
            key: _one,
            duration:
                Duration(milliseconds: Values.showcaseAnimationTransitionSpeed),
            showcaseBackgroundColor: IColors.white85,
            fontSize: fontSize,
            child: getVideoItem(context))
        : getVideoItem(context);
  }

  Widget getVideoItem(BuildContext context) {
    if (itemIndex == 0 && needShowcase)
      _showcaseBloc
          .add(ShowcaseFavoriteItem(keys: [_one], buildContext: context));

    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      enabled: deleteSlidable,
      secondaryActions: <Widget>[
        MyIconSlideAction(
          caption: '??????',
          color: Colors.red,
          icon: Icons.delete,
          actionBorderRadius: 8,
          onTap: () {
            favoriteBloc.add(DeleteVideoItem(
                user_id: GlobalWidget.user_id, video_id: video_id));
            favoriteBloc.add(GetFavoriteItems(user_id: GlobalWidget.user_id));
          },
        )
      ],
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            height: 94,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.circular(20),
                color: isDarkMode ? IColors.darkBlack07 : IColors.white85,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(4, 6),
                    blurRadius: 10,
                    color: isDarkMode
                        ? Colors.transparent
                        : IColors.purpleCrimson25,
                  )
                ]),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                splashColor:
                    isDarkMode ? IColors.darkLightPink10 : IColors.black15,
                onTap: onTap,
                child: Stack(
                  children: [
                    isPinned
                        ? PushPinnedWidget(
                            isDarkMode: isDarkMode,
                          )
                        : Container(),
                    Row(
                      children: [
                        Container(
                          width: 94,
                          height: 94,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: IColors.purpleCrimson,
                          ),
                          child: Container(
                            width: 94,
                            height: 94,
                            child: Stack(
                              children: [
                                Container(
                                  width: 94,
                                  height: 94,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: OctoImage(
                                      image: CachedNetworkImageProvider(
                                        ApiProvider.IMAGE_PROVIDER + thumbnail,
                                      ),
                                      placeholderBuilder:
                                          OctoPlaceholder.blurHash(
                                        blurhash,
                                      ),
                                      errorBuilder:
                                          OctoError.icon(color: Colors.red),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 94,
                                  height: 94,
                                  decoration: BoxDecoration(
                                    color: isDarkMode
                                        ? IColors.darkLightPink65
                                        : IColors.purpleCrimson65,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                Center(
                                  child: Container(
                                    width: 26,
                                    height: 26,
                                    decoration: BoxDecoration(
                                      color: Colors.white54,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.play_arrow_rounded,
                                      color: isDarkMode
                                          ? IColors.darkLightPink
                                          : IColors.purpleCrimson,
                                      size: 25,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width - 134,
                                  child: RichText(
                                    text: searchMatch("${title}"),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextSpan searchMatch(String match) {
    TextStyle posRes = TextStyle(
          backgroundColor: IColors.brown,
          fontSize: 14 + fontSize,
          fontWeight: FontWeight.w700,
          color: isDarkMode ? IColors.darkWhite70 : IColors.black70,
          fontFamily: "IranSans",
        ),
        negRes = TextStyle(
          backgroundColor: Colors.transparent,
          fontSize: 14 + fontSize,
          fontWeight: FontWeight.w700,
          color: isDarkMode ? IColors.darkWhite70 : IColors.black70,
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

/*
Positioned(
                bottom: 16,
                right: 16,
                child: Text(
                  "?????????? ?????? ??????????",
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
