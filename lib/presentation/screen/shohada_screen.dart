import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:namaz_app/constants/colors.dart';
import 'package:namaz_app/constants/strings.dart';
import 'package:namaz_app/constants/values.dart';
import 'package:namaz_app/logic/bloc/showcase_bloc.dart';
import 'package:namaz_app/logic/bloc/theme_bloc.dart';
import 'package:namaz_app/logic/bloc/shohada_bloc.dart';
import 'package:namaz_app/logic/cubit/internet_cubit.dart';
import 'package:namaz_app/networking/api_provider.dart';
import 'package:namaz_app/presentation/widget/back_button_widget.dart';
import 'package:namaz_app/presentation/widget/loading_bar.dart';
import 'package:namaz_app/presentation/widget/marjae_large_item.dart';
import 'package:namaz_app/presentation/widget/my_tool_bar_text.dart';
import 'package:namaz_app/presentation/widget/no_network_flare.dart';
import 'package:namaz_app/presentation/widget/search_button_widget.dart';
import 'package:namaz_app/presentation/widget/search_field_widget.dart';
import 'package:namaz_app/presentation/widget/server_failure_flare.dart';
import 'package:namaz_app/presentation/widget/shohada_item.dart';
import 'package:namaz_app/presentation/widget/showcase_helper_widget.dart';
import 'package:namaz_app/presentation/widget/videos_item.dart';

class ShohadaScreen extends StatefulWidget {
  @override
  _ShohadaScreenState createState() => _ShohadaScreenState();
}

class _ShohadaScreenState extends State<ShohadaScreen>
    with SingleTickerProviderStateMixin {
  ShohadaBloc _shohadaBloc;
  ThemeBloc _themeBloc;
  ScrollController _controller = ScrollController();
  bool lazyLoading = true;
  Animation<double> animation;
  AnimationController animationController;
  bool isForward = false;
  bool _clickProtectorSearch =
      true; // clickProtectors prevent user from click multiple times and distrupt animation
  TextEditingController searchTextController = new TextEditingController();
  bool searchLoading = true;
  bool emptyList = false;
  bool _isDarkMode = false;
  double _fontSize = 0;
  GlobalKey _one = GlobalKey();
  ShowcaseBloc _showcaseBloc = new ShowcaseBloc();
  @override
  void initState() {
    _shohadaBloc = BlocProvider.of<ShohadaBloc>(context);
    _themeBloc = BlocProvider.of<ThemeBloc>(context);
    _shohadaBloc.add(GetShohadaList(search: ""));
    _themeBloc.add(GetThemeStatus());
    _showcaseBloc.add(ShowcaseSearch(keys: [_one], buildContext: context));

    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        print('end of page');
        _shohadaBloc.add(GetShohadaList(search: searchTextController.text));
      }
    });
    super.initState();
    searchFieldAnimation();
  }

  Color backgroundColor = IColors.lightBrown;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ShohadaBloc, ShohadaState>(
          listener: (context, state) {
            if (state is ShohadaLazyLoading) {
              lazyLoading = true;
            } else if (state is ShohadaSuccess) {
              lazyLoading = false;
            }
          },
        ),
        BlocListener<ThemeBloc, ThemeState>(
          listener: (context, state) {
            darkModeStateFunction(state);
          },
        ),
      ],
      child: Scaffold(
        backgroundColor:
            _isDarkMode ? IColors.darkBackgroundColor : backgroundColor,
        body: SafeArea(
            child: BlocConsumer<InternetCubit, InternetState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is InternetConnected) {
              return BlocBuilder<ShohadaBloc, ShohadaState>(
                builder: (context, state) {
                  if (state is ShohadaLoading) {
                    emptyList = false;
                    return LoadingBar(
                      color: _isDarkMode
                          ? IColors.darkLightPink
                          : IColors.purpleCrimson,
                    );
                  } else if (state is ShohadaSuccess) {
                    emptyList = false;
                    searchLoading = false;
                    return shohadaUI(state);
                  } else if (state is ShohadaListCompleted) {
                    lazyLoading = false;
                    return shohadaUI(state);
                  } else if (state is ShohadaSearchEmpty) {
                    lazyLoading = false;
                    searchLoading = false;
                    emptyList = true;
                    return shohadaUI(state);
                  } else if (state is ShohadaSearchLoading) {
                    searchLoading = true;
                    emptyList = false;
                    lazyLoading = false;
                    return shohadaUI(state);
                  } else if (state is ShohadaLazyLoading) {
                    return shohadaUI(state);
                  } else if (state is ShohadaFailure) {
                    return ServerFailureFlare(
                      isDarkMode: _isDarkMode,
                    );
                  } else if (state is ShohadaInitial) {
                    return Container();
                  }
                },
              );
            } else if (state is InternetDisconnected) {
              return NoNetworkFlare(
                isDarkMode: _isDarkMode,
              );
            } else {
              return Container();
            }
          },
        )),
      ),
    );
  }

  Widget shohadaUI(var state) {
    List<Widget> list = new List<Widget>();
    if (!emptyList && !searchLoading) {
      for (int i = 0; i < state.shohadaModel.shohadaBozorgan.length; i++) {
        list.add(ShohadaItem(
          shohada_id: state.shohadaModel.shohadaBozorgan[i].id,
          deleteSlidable: false,
          isDarkMode: _isDarkMode,
          fontSize: _fontSize,
          hash: state.shohadaModel.shohadaBozorgan[i].blurhash,
          searchedText: searchTextController.text,
          onTap: () => Navigator.pushNamed(context, '/shohada_details',
              arguments: <String, String>{
                "shohada_id": state.shohadaModel.shohadaBozorgan[i].id,
              }),
          title: state.shohadaModel.shohadaBozorgan[i].name,
          largePicture: state.shohadaModel.shohadaBozorgan[i].pictureSizeLarge,
        ));
      }
    }
    return SingleChildScrollView(
      controller: _controller,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16, right: 16, left: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BackButtonWidget(onTap: () => Navigator.pop(context)),
                  Text(
                    "${Strings.shohadaBozorgan}",
                    style: TextStyle(
                      fontSize: 18 + _fontSize,
                      fontWeight: FontWeight.w700,
                      color:
                          _isDarkMode ? IColors.darkWhite70 : IColors.black70,
                    ),
                  ),
                  ShowcaseHelperWidget(
                    text: Strings.showcaseShohadaSearchGuide,
                    key: _one,
                    duration: Duration(
                        milliseconds: Values.showcaseAnimationTransitionSpeed),
                    showcaseBackgroundColor: IColors.white85,
                    fontSize: _fontSize,
                    child: SearchButtonWidget(
                        isSearching: isForward,
                        onTap: !_clickProtectorSearch
                            ? null
                            : () {
                                _clickProtectorSearch = false;
                                Timer(Duration(milliseconds: 1000), () {
                                  _clickProtectorSearch = true;
                                });
                                setState(() {
                                  if (!isForward) {
                                    animationController.forward();
                                    isForward = true;
                                  } else {
                                    animationController.reverse();
                                    Timer(Duration(milliseconds: 1000), () {
                                      isForward = false;
                                      searchTextController.text = "";
                                      _shohadaBloc.add(SearchShohadaItems(
                                          search: searchTextController.text));
                                    });
                                  }
                                });
                              }),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 8,
            ),
            SearchFieldWidget(
                isForward: isForward,
                animation: animation,
                searchTextController: searchTextController,
                isDarkMode: _isDarkMode,
                onChanged: (text) {
                  print("searched text: ${text}");
                  _shohadaBloc.add(SearchShohadaItems(search: text));
                }),
            SizedBox(
              height: 16,
            ),
            !emptyList
                ? searchLoading
                    ? Container(
                        height: MediaQuery.of(context).size.height - 180,
                        child: LoadingBar(
                            color: _isDarkMode
                                ? IColors.darkLightPink
                                : IColors.purpleCrimson))
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.end,
                            textDirection: TextDirection.rtl,
                            children: list,
                          ),
                        ),
                      )
                : Container(
                    height: MediaQuery.of(context).size.height - 180,
                    child: Center(
                        child: Text(
                      Strings.noResultFound,
                      style: TextStyle(
                          color: _isDarkMode
                              ? IColors.darkWhite45
                              : IColors.black45),
                    ))),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: lazyLoading
                  ? LoadingBar(
                      color: _isDarkMode
                          ? IColors.darkLightPink
                          : IColors.purpleCrimson)
                  : Container(),
            ),
          ],
        ),
      ),
    );
  }

  void searchFieldAnimation() {
    animationController = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);
    final curvedAnimation =
        CurvedAnimation(parent: animationController, curve: Curves.easeOutExpo);

    animation = Tween<double>(
            begin: 0, end: window.physicalSize.width / window.devicePixelRatio)
        .animate(curvedAnimation)
          ..addListener(() {
            setState(() {});
          });
  }

  void darkModeStateFunction(ThemeState state) {
    if (state is ThemeInitial) {
      setState(() {
        _isDarkMode = state.isDark;
        _fontSize = state.fontSize;
      });
    }
    if (state is DarkModeEnable) {
      setState(() {
        _isDarkMode = state.isDark;
        _fontSize = state.fontSize;
      });
    } else if (state is DarkModeDisable) {
      setState(() {
        _isDarkMode = state.isDark;
        _fontSize = state.fontSize;
      });
    }
  }
}
