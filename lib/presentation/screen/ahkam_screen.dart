import 'dart:async';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:namaz_app/constants/assets.dart';
import 'package:namaz_app/constants/colors.dart';
import 'package:namaz_app/constants/strings.dart';
import 'package:namaz_app/constants/values.dart';
import 'package:namaz_app/logic/bloc/ahkam_bloc.dart';
import 'package:namaz_app/logic/bloc/showcase_bloc.dart';
import 'package:namaz_app/logic/bloc/theme_bloc.dart';
import 'package:namaz_app/logic/cubit/internet_cubit.dart';
import 'package:namaz_app/networking/api_provider.dart';
import 'package:namaz_app/presentation/widget/ahkam_item.dart';
import 'package:namaz_app/presentation/widget/back_button_widget.dart';
import 'package:namaz_app/presentation/widget/loading_bar.dart';
import 'package:namaz_app/presentation/widget/marjae_large_item.dart';
import 'package:namaz_app/presentation/widget/no_network_flare.dart';
import 'package:namaz_app/presentation/widget/search_button_widget.dart';
import 'package:namaz_app/presentation/widget/search_field_widget.dart';
import 'package:namaz_app/presentation/widget/server_failure_flare.dart';
import 'package:namaz_app/presentation/widget/shohada_item.dart';
import 'package:namaz_app/presentation/widget/showcase_helper_widget.dart';
import 'package:namaz_app/presentation/widget/videos_item.dart';
import 'package:octo_image/octo_image.dart';

class AhkamScreen extends StatefulWidget {
  Map<String, String> args;
  AhkamScreen({this.args});

  @override
  _AhkamScreenState createState() => _AhkamScreenState();
}

class _AhkamScreenState extends State<AhkamScreen>
    with SingleTickerProviderStateMixin {
  ScrollController _controller = ScrollController();

  Map<String, String> arguments;
  String marjae_id;
  String marjae_name = "", blurhash = "", picture_size_small = "";
  AhkamBloc _ahkamBloc;
  ThemeBloc _themeBloc;
  bool lazyLoading = true;
  bool searchVisibility = true;
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
    arguments = widget.args;
    _getArguments();
    _ahkamBloc = BlocProvider.of<AhkamBloc>(context);
    _themeBloc = BlocProvider.of<ThemeBloc>(context);
    _ahkamBloc.add(GetAhkamItems(marjae_id: marjae_id, search: ""));
    _themeBloc.add(GetThemeStatus());
    _showcaseBloc.add(ShowcaseSearch(keys: [_one], buildContext: context));

    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        print('end of page ${searchTextController.text}');
        _ahkamBloc.add(GetAhkamItems(
            marjae_id: marjae_id, search: searchTextController.text));
      }
    });
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    return BlocListener<ThemeBloc, ThemeState>(
      listener: (context, state) {
        darkModeStateFunction(state);
      },
      child: Scaffold(
        backgroundColor:
            _isDarkMode ? IColors.darkBackgroundColor : IColors.lightBrown,
        body: SafeArea(
            child: BlocConsumer<InternetCubit, InternetState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is InternetConnected) {
              return BlocBuilder<AhkamBloc, AhkamState>(
                builder: (context, state) {
                  if (state is AhkamInitial) {
                    return Container();
                  } else if (state is AhkamLoading) {
                    emptyList = false;
                    return LoadingBar(
                      color: _isDarkMode
                          ? IColors.darkLightPink
                          : IColors.purpleCrimson,
                    );
                  } else if (state is AhkamSuccess) {
                    emptyList = false;
                    searchLoading = false;
                    // lazyLoading = false; // new added
                    return getAhkamUI(state);
                  } else if (state is AhkamLazyLoading) {
                    lazyLoading = true;
                    return getAhkamUI(state);
                  } else if (state is AhkamListCompleted) {
                    lazyLoading = false;
                    return getAhkamUI(state);
                  } else if (state is AhkamSearchEmpty) {
                    lazyLoading = false;
                    searchLoading = false;
                    emptyList = true;
                    return getAhkamUI(state);
                  } else if (state is AhkamSearchLoading) {
                    searchLoading = true;
                    emptyList = false;
                    lazyLoading = false;
                    return getAhkamUI(state);
                  } else if (state is AhkamFailure) {
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

  void _getArguments() {
    marjae_id = arguments['marjae_id'];
    marjae_name = arguments['marjae_name'];
    picture_size_small = arguments['picture_size_small'];
    blurhash = arguments['blurhash'];
  }

  Widget getAhkamUI(var state) {
    return SingleChildScrollView(
      controller: _controller,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 214,
                        height: 96,
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 84),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: IColors.brown,
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(20),
                                        topLeft: Radius.circular(20)),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        right: 16, left: 8, top: 8, bottom: 8),
                                    child: Text(
                                      "${marjae_name}",
                                      style: TextStyle(
                                        fontSize: 16 + _fontSize,
                                        fontWeight: FontWeight.w800,
                                        color: IColors.white85,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              right: 0,
                              child: Container(
                                decoration: BoxDecoration(),
                                child: Container(
                                  width: 96,
                                  height: 96,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: IColors.brown, width: 5),
                                      color: IColors.brown),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: _isDarkMode
                                            ? IColors.purpleCrimson
                                            : IColors.brown),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: OctoImage(
                                        image: CachedNetworkImageProvider(
                                            ApiProvider.IMAGE_PROVIDER +
                                                picture_size_small),
                                        placeholderBuilder:
                                            OctoPlaceholder.blurHash(
                                          blurhash,
                                        ),
                                        errorBuilder:
                                            OctoError.icon(color: Colors.red),
                                        imageBuilder:
                                            OctoImageTransformer.circleAvatar(),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
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
                    _ahkamBloc.add(
                        SearchAhkamItems(marjae_id: marjae_id, search: text));
                  },
                ),
                SizedBox(height: 16),
                !emptyList
                    ? searchLoading
                        ? Container(
                            height: MediaQuery.of(context).size.height - 180,
                            child: LoadingBar(
                              color: _isDarkMode
                                  ? IColors.darkLightPink
                                  : IColors.purpleCrimson,
                            ))
                        : Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Align(
                              alignment: Alignment.topRight,
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: state.ahkamModel.ahkam.length,
                                itemBuilder: (context, index) {
                                  return AhkamItem(
                                    title: state.ahkamModel.ahkam[index].title,
                                    id: state.ahkamModel.ahkam[index].id,
                                    ahkamNumber: state
                                        .ahkamModel.ahkam[index].ahkamNumber,
                                    deleteSlidable: false,
                                    isDarkMode: _isDarkMode,
                                    fontSize: _fontSize,
                                    itemIndex: index,
                                    needShowcase: false,
                                    searchedText:
                                        "${searchTextController.text}",
                                    onTap: () => Navigator.pushNamed(
                                        context, '/ahkam_show',
                                        arguments: <String, String>{
                                          'ahkam_id':
                                              state.ahkamModel.ahkam[index].id,
                                        }),
                                  );
                                },
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
                SizedBox(
                  height: 8,
                ),
                lazyLoading
                    ? LoadingBar(
                        color: _isDarkMode
                            ? IColors.darkLightPink
                            : IColors.purpleCrimson,
                      )
                    : Container(),
                SizedBox(
                  height: 16,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16, right: 16, left: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BackButtonWidget(onTap: () => Navigator.pop(context)),

                  ShowcaseHelperWidget(
                    text: Strings.showcaseAhkamSearchGuide,
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
                                      _ahkamBloc.add(SearchAhkamItems(
                                          marjae_id: marjae_id,
                                          search: searchTextController.text));
                                    });
                                  }
                                });
                              }),
                  ),

                  // Container(
                  //   width: 25,
                  //   height: 25,
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
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
