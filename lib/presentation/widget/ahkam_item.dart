import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:namaz_app/constants/assets.dart';
import 'package:namaz_app/constants/colors.dart';
import 'package:namaz_app/constants/strings.dart';
import 'package:namaz_app/constants/values.dart';
import 'package:namaz_app/logic/bloc/favorite_bloc.dart';
import 'package:namaz_app/logic/bloc/showcase_bloc.dart';
import 'package:namaz_app/presentation/widget/global_widget.dart';
import 'package:namaz_app/presentation/widget/my_slide_action.dart';
import 'package:namaz_app/presentation/widget/showcase_helper_widget.dart';

class AhkamItem extends StatelessWidget {
  bool deleteSlidable = false;
  String title, id;
  Function onTap;
  FavoriteBloc favoriteBloc;
  String searchedText;
  String ahkamNumber;
  String marjae_name = "";
  bool isDarkMode = false;
  double fontSize = 0;
  int itemIndex = 0;
  GlobalKey _one = GlobalKey();
  ShowcaseBloc _showcaseBloc = ShowcaseBloc();
  bool needShowcase = false;
  AhkamItem({
    @required this.deleteSlidable,
    @required this.title,
    @required this.id,
    @required this.onTap,
    @required this.ahkamNumber,
    @required this.isDarkMode,
    @required this.fontSize,
    @required this.itemIndex,
    @required this.needShowcase,
    this.marjae_name,
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
            child: getAhkamItem(context))
        : getAhkamItem(context);
  }

  Widget getAhkamItem(BuildContext context) {
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
            favoriteBloc.add(
                DeleteAhkamItem(ahkam_id: id, user_id: GlobalWidget.user_id));
            favoriteBloc.add(GetFavoriteItems(user_id: GlobalWidget.user_id));
          },
        )
      ],
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Container(
          width: MediaQuery.of(context).size.width - 32,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: isDarkMode ? IColors.darkBlack07 : Colors.white),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              splashColor: isDarkMode
                  ? IColors.darkLightPink10
                  : IColors.purpleCrimson25,
              borderRadius: BorderRadius.circular(20),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
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
                                      "${ahkamNumber}",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 14 + fontSize,
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
                            child: RichText(
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              text: searchMatch('${title}'),
                            ),
                          ),
                        )
                      ],
                    ),
                    marjae_name == "" || marjae_name == null
                        ? Container()
                        : Padding(
                            padding: const EdgeInsets.only(right: 38),
                            child: Text("${marjae_name}",
                                style: TextStyle(
                                    fontSize: 14 + fontSize,
                                    fontWeight: FontWeight.bold,
                                    color: isDarkMode
                                        ? IColors.brown
                                        : IColors.purpleCrimson)),
                          )
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
          fontSize: 16 + fontSize,
          color: isDarkMode ? IColors.darkWhite70 : IColors.black70,
          fontWeight: FontWeight.normal,
          fontFamily: "IranSans",
        ),
        negRes = TextStyle(
          backgroundColor: Colors.transparent,
          fontSize: 16 + fontSize,
          color: isDarkMode ? IColors.darkWhite70 : IColors.black70,
          fontWeight: FontWeight.normal,
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
