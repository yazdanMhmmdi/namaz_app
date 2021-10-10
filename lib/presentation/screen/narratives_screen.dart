import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:namaz_app/constants/colors.dart';
import 'package:namaz_app/constants/strings.dart';
import 'package:namaz_app/constants/values.dart';
import 'package:namaz_app/logic/bloc/showcase_bloc.dart';
import 'package:namaz_app/logic/bloc/theme_bloc.dart';
import 'package:namaz_app/logic/bloc/narratives_bloc.dart';
import 'package:namaz_app/logic/cubit/internet_cubit.dart';
import 'package:namaz_app/presentation/widget/back_button_widget.dart';
import 'package:namaz_app/presentation/widget/loading_bar.dart';
import 'package:namaz_app/presentation/widget/narratives_item.dart';
import 'package:namaz_app/presentation/widget/no_network_flare.dart';
import 'package:namaz_app/presentation/widget/search_button_widget.dart';
import 'package:namaz_app/presentation/widget/search_field_widget.dart';
import 'package:namaz_app/presentation/widget/server_failure_flare.dart';
import 'package:namaz_app/presentation/widget/showcase_helper_widget.dart';

class NarrativesScreen extends StatefulWidget {
  @override
  _NarrativesScreenState createState() => _NarrativesScreenState();
}

class _NarrativesScreenState extends State<NarrativesScreen>
    with SingleTickerProviderStateMixin {
  NarrativesBloc _narrativesBloc;
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
    _narrativesBloc = BlocProvider.of<NarrativesBloc>(context);
    _themeBloc = BlocProvider.of<ThemeBloc>(context);
    _narrativesBloc.add(GetNarrativesList(search: ""));
    _themeBloc.add(GetThemeStatus());
    _showcaseBloc
        .add(ShowcaseNarrativesSearch(keys: [_one], buildContext: context));
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        print('end of page');
        _narrativesBloc
            .add(GetNarrativesList(search: searchTextController.text));
      }
    });
    super.initState();
    searchFieldAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<NarrativesBloc, NarrativesState>(
          listener: (context, state) {
            if (state is NarrativesLazyLoading) {
              lazyLoading = true;
            } else if (state is NarrativesSuccess) {
              lazyLoading = false;
            }
          },
        ),
        BlocListener<ThemeBloc, ThemeState>(
          listener: (context, state) {
            darkModeStateFunction(state);
          },
        )
      ],
      child: Scaffold(
        backgroundColor:
            _isDarkMode ? IColors.darkBackgroundColor : IColors.lightBrown,
        body: SafeArea(
            child: BlocConsumer<InternetCubit, InternetState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is InternetConnected) {
              return BlocBuilder<NarrativesBloc, NarrativesState>(
                builder: (context, state) {
                  if (state is NarrativesInitial) {
                    return Container();
                  } else if (state is NarrativesLoading) {
                    emptyList = false;
                    return LoadingBar(
                        color: _isDarkMode
                            ? IColors.darkLightPink
                            : IColors.purpleCrimson);
                  } else if (state is NarrativesLazyLoading) {
                    return narrativesUI(state);
                  } else if (state is NarrativesSuccess) {
                    emptyList = false;
                    searchLoading = false;
                    return narrativesUI(state);
                  } else if (state is NarrativesListCompleted) {
                    lazyLoading = false;
                    return narrativesUI(state);
                  } else if (state is NarrativesSearchEmpty) {
                    lazyLoading = false;
                    searchLoading = false;
                    emptyList = true;
                    return narrativesUI(state);
                  } else if (state is NarrativesSearchLoading) {
                    searchLoading = true;
                    emptyList = false;
                    lazyLoading = false;
                    return narrativesUI(state);
                  } else if (state is NarrativesFailure) {
                    return ServerFailureFlare(
                      isDarkMode: _isDarkMode,
                    );
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

  Widget narrativesUI(var state) {
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
                    "${Strings.narratives}",
                    style: TextStyle(
                      fontSize: 18 + _fontSize,
                      fontWeight: FontWeight.w700,
                      color:
                          _isDarkMode ? IColors.darkWhite70 : IColors.black70,
                    ),
                  ),
                  ShowcaseHelperWidget(
                    text: Strings.showcaseNarrtivesSearchGuide,
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
                                      _narrativesBloc.add(SearchNarrativesItems(
                                          search: searchTextController.text));
                                    });
                                  }
                                });
                              }),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8),
            SearchFieldWidget(
                isForward: isForward,
                animation: animation,
                searchTextController: searchTextController,
                isDarkMode: _isDarkMode,
                onChanged: (text) {
                  print("searched text: ${text}");
                  _narrativesBloc.add(SearchNarrativesItems(search: text));
                }),
            SizedBox(height: 16),
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
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: state.narrativesModel.narratives.length,
                          itemBuilder: (context, index) {
                            return NarrativesItem(
                              id: state.narrativesModel.narratives[index].id,
                              searchedText: searchTextController.text,
                              onTap: () => Navigator.pushNamed(
                                  context, '/narratives_show',
                                  arguments: <String, String>{
                                    "narratives_id": state
                                        .narrativesModel.narratives[index].id,
                                  }),
                              deleteSlidable: false,
                              needShowcase: false,
                              isDarkMode: _isDarkMode,
                              fontSize: _fontSize,
                              title: state.narrativesModel.narratives[index]
                                  .quoteeTranslation,
                              subTitle: state.narrativesModel.narratives[index]
                                  .quoteTranslation,
                              itemIndex: index,
                            );
                          },
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
            SizedBox(
              height: 8,
            ),
            lazyLoading
                ? LoadingBar(
                    color: _isDarkMode
                        ? IColors.darkLightPink
                        : IColors.purpleCrimson)
                : Container(),
            SizedBox(
              height: 8,
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
