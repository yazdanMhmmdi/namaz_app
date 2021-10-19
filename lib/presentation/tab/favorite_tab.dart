import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:namaz_app/constants/colors.dart';
import 'package:namaz_app/constants/strings.dart';
import 'package:namaz_app/constants/values.dart';
import 'package:namaz_app/logic/bloc/favorite_bloc.dart';
import 'package:namaz_app/logic/bloc/showcase_bloc.dart';
import 'package:namaz_app/presentation/widget/ahkam_item.dart';
import 'package:namaz_app/presentation/widget/global_widget.dart';
import 'package:namaz_app/presentation/widget/loading_bar.dart';
import 'package:namaz_app/presentation/widget/marjae_small_item.dart';
import 'package:namaz_app/presentation/widget/narratives_item.dart';
import 'package:namaz_app/presentation/widget/server_failure_flare.dart';
import 'package:namaz_app/presentation/widget/showcase_helper_widget.dart';
import 'package:namaz_app/presentation/widget/title_selector.dart';
import 'package:namaz_app/presentation/widget/videos_item.dart';

class FavoriteTab extends StatefulWidget {
  bool isDarkMode = false;
  double fontSize = 0;
  FavoriteTab({@required this.isDarkMode, @required this.fontSize});
  @override
  _FavoriteTabState createState() => _FavoriteTabState();
}

class _FavoriteTabState extends State<FavoriteTab> with WidgetsBindingObserver {
  FavoriteBloc _favoriteBloc;
  ShowcaseBloc _showcaseBloc;
  bool _isDarkMode;
  double _fontSize = 0;
  GlobalKey _one = GlobalKey();
  @override
  void initState() {
    _favoriteBloc = BlocProvider.of<FavoriteBloc>(context);
    _showcaseBloc = BlocProvider.of<ShowcaseBloc>(context);
    _favoriteBloc.add(GetFavoriteItems(user_id: GlobalWidget.user_id));
    _showcaseBloc.add(ShowcaseFavorite(keys: [_one], buildContext: context));
    _isDarkMode = widget.isDarkMode;
    _fontSize = widget.fontSize;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteBloc, FavoriteState>(
      builder: (context, state) {
        if (state is FavoriteInitial) {
          return Container();
        } else if (state is FavoriteLoading) {
          return LoadingBar(
            color: _isDarkMode ? IColors.darkLightPink : IColors.purpleCrimson,
          );
        } else if (state is FavoriteSuccess) {
          return getFavoriteTabUI(state);
        } else if (state is FavoriteIsEmpty) {
          return getFavoriteTabUI(state);
        } else if (state is FavoriteFailure) {
          return ServerFailureFlare(
            isDarkMode: _isDarkMode,
          );
        }
      },
    );
  }

  Widget getFavoriteTabUI(var state) {
    return SingleChildScrollView(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 16,
            ),
            BlocProvider.value(
              value: _favoriteBloc,
              child: ShowcaseHelperWidget(
                text: Strings.showcaseFavoriteSelectorGuide,
                key: _one,
                duration: Duration(
                    milliseconds: Values.showcaseAnimationTransitionSpeed),
                showcaseBackgroundColor: IColors.white85,
                fontSize: _fontSize,
                child: TitleSelector(
                  fontSize: widget.fontSize,
                  isDarkMode: _isDarkMode,
                  titles: [
                    "ویدئو ها",
                    " احکام مراجع",
                    "آیات و روایات",
                    "شهدا و بزرگان",
                  ],
                  firstTab: GlobalWidget.tabNumber,
                ),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            state.tab,
            SizedBox(
              height: 32,
            ),
          ],
        ),
      ),
    );
  }
}
