import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:namaz_app/constants/colors.dart';
import 'package:namaz_app/constants/strings.dart';
import 'package:namaz_app/logic/bloc/favorite_bloc.dart';
import 'package:namaz_app/presentation/widget/ahkam_item.dart';
import 'package:namaz_app/presentation/widget/global_widget.dart';
import 'package:namaz_app/presentation/widget/loading_bar.dart';
import 'package:namaz_app/presentation/widget/marjae_small_item.dart';
import 'package:namaz_app/presentation/widget/narratives_item.dart';
import 'package:namaz_app/presentation/widget/server_failure_flare.dart';
import 'package:namaz_app/presentation/widget/title_selector.dart';
import 'package:namaz_app/presentation/widget/videos_item.dart';

class FavoriteTab extends StatefulWidget {
  bool isDarkMode = false;
  FavoriteTab({@required this.isDarkMode});
  @override
  _FavoriteTabState createState() => _FavoriteTabState();
}

class _FavoriteTabState extends State<FavoriteTab> with WidgetsBindingObserver {
  FavoriteBloc _favoriteBloc;
  bool _isDarkMode;
  @override
  void initState() {
    _favoriteBloc = BlocProvider.of<FavoriteBloc>(context);
    _favoriteBloc.add(GetFavoriteItems(user_id: GlobalWidget.user_id));
    _isDarkMode = widget.isDarkMode;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteBloc, FavoriteState>(
      builder: (context, state) {
        if (state is FavoriteInitial) {
          return Container();
        } else if (state is FavoriteLoading) {
          return LoadingBar();
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
              child: TitleSelector(
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
