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
  String searchedText;
  bool isDarkMode = false;
  NarrativesItem(
      {@required this.deleteSlidable,
      @required this.title,
      @required this.subTitle,
      @required this.id,
      @required this.onTap,
      @required this.isDarkMode,
      this.favoriteBloc,
      this.searchedText});

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
                    color: isDarkMode ? IColors.darkBlack07 : Colors.white,
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      splashColor: isDarkMode
                          ? IColors.darkLightPink10
                          : IColors.black15,
                      onTap: onTap,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 8, top: 16, right: 69, bottom: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: searchTitleMatch('${title}'),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            RichText(
                                text: searchSubTitleMatch("${subTitle}"),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3),
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
                          color: isDarkMode
                              ? IColors.darkLightPink25
                              : IColors.purpleCrimson25,
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
                    color: isDarkMode
                        ? IColors.darkLightPink65
                        : IColors.purpleCrimson65,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextSpan searchTitleMatch(
    String match,
  ) {
    TextStyle posTitleRes = TextStyle(
          backgroundColor: IColors.brown,
          fontSize: 16,
          color: isDarkMode ? IColors.darkWhite70 : IColors.black70,
          fontWeight: FontWeight.w700,
          fontFamily: "IranSans",
        ),
        negTitleRes = TextStyle(
          backgroundColor: Colors.transparent,
          fontSize: 16,
          color: isDarkMode ? IColors.darkWhite70 : IColors.black70,
          fontWeight: FontWeight.w700,
          fontFamily: "IranSans",
        );

    if (searchedText == null || searchedText == "")
      return TextSpan(text: match, style: negTitleRes);
    var refinedMatch = match.toLowerCase();
    var refinedSearch = searchedText.toLowerCase();
    if (refinedMatch.contains(refinedSearch)) {
      if (refinedMatch.substring(0, refinedSearch.length) == refinedSearch) {
        return TextSpan(
          style: posTitleRes,
          text: match.substring(0, refinedSearch.length),
          children: [
            searchTitleMatch(
              match.substring(
                refinedSearch.length,
              ),
            ),
          ],
        );
      } else if (refinedMatch.length == refinedSearch.length) {
        return TextSpan(text: match, style: posTitleRes);
      } else {
        return TextSpan(
          style: negTitleRes,
          text: match.substring(
            0,
            refinedMatch.indexOf(refinedSearch),
          ),
          children: [
            searchTitleMatch(
              match.substring(
                refinedMatch.indexOf(refinedSearch),
              ),
            ),
          ],
        );
      }
    } else if (!refinedMatch.contains(refinedSearch)) {
      return TextSpan(text: match, style: negTitleRes);
    }
    return TextSpan(
      text: match.substring(0, refinedMatch.indexOf(refinedSearch)),
      style: negTitleRes,
      children: [
        searchTitleMatch(match.substring(refinedMatch.indexOf(refinedSearch)))
      ],
    );
  }

  TextSpan searchSubTitleMatch(
    String match,
  ) {
    TextStyle posSubTitleRes = TextStyle(
          backgroundColor: IColors.brown,
          fontSize: 14,
          color: isDarkMode ? IColors.darkWhite45 : IColors.black45,
          fontFamily: "IranSans",
        ),
        negSubTitleRes = TextStyle(
          backgroundColor: Colors.transparent,
          fontSize: 14,
          color: isDarkMode ? IColors.darkWhite45 : IColors.black45,
          fontFamily: "IranSans",
        );
    if (searchedText == null || searchedText == "")
      return TextSpan(text: match, style: negSubTitleRes);
    var refinedMatch = match.toLowerCase();
    var refinedSearch = searchedText.toLowerCase();
    if (refinedMatch.contains(refinedSearch)) {
      if (refinedMatch.substring(0, refinedSearch.length) == refinedSearch) {
        return TextSpan(
          style: posSubTitleRes,
          text: match.substring(0, refinedSearch.length),
          children: [
            searchSubTitleMatch(
              match.substring(
                refinedSearch.length,
              ),
            ),
          ],
        );
      } else if (refinedMatch.length == refinedSearch.length) {
        return TextSpan(text: match, style: posSubTitleRes);
      } else {
        return TextSpan(
          style: negSubTitleRes,
          text: match.substring(
            0,
            refinedMatch.indexOf(refinedSearch),
          ),
          children: [
            searchSubTitleMatch(
              match.substring(
                refinedMatch.indexOf(refinedSearch),
              ),
            ),
          ],
        );
      }
    } else if (!refinedMatch.contains(refinedSearch)) {
      return TextSpan(text: match, style: negSubTitleRes);
    }
    return TextSpan(
      text: match.substring(0, refinedMatch.indexOf(refinedSearch)),
      style: negSubTitleRes,
      children: [
        searchSubTitleMatch(
            match.substring(refinedMatch.indexOf(refinedSearch)))
      ],
    );
  }
}
