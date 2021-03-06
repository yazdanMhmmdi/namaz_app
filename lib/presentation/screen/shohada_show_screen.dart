import 'dart:async';
import 'dart:ui';

import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:decorated_icon/decorated_icon.dart';
import 'package:feature_discovery/feature_discovery.dart';
import 'package:flare_loading/flare_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:namaz_app/constants/assets.dart';
import 'package:namaz_app/constants/colors.dart';
import 'package:namaz_app/constants/strings.dart';
import 'package:namaz_app/constants/values.dart';
import 'package:namaz_app/logic/bloc/showcase_bloc.dart';
import 'package:namaz_app/logic/bloc/theme_bloc.dart';
import 'package:namaz_app/logic/bloc/shohada_details_bloc.dart';
import 'package:namaz_app/logic/cubit/internet_cubit.dart';
import 'package:namaz_app/networking/api_provider.dart';
import 'package:namaz_app/presentation/widget/global_widget.dart';
import 'package:namaz_app/presentation/widget/loading_bar.dart';
import 'package:namaz_app/presentation/widget/no_network_flare.dart';
import 'package:namaz_app/presentation/widget/server_failure_flare.dart';
import 'package:namaz_app/presentation/widget/showcase_helper_widget.dart';
import 'package:octo_image/octo_image.dart';

class ShohadaShowScreen extends StatefulWidget {
  Map<String, String> args;
  ShohadaShowScreen({this.args});
  @override
  _ShohadaShowScreenState createState() => _ShohadaShowScreenState();
}

class _ShohadaShowScreenState extends State<ShohadaShowScreen>
    with SingleTickerProviderStateMixin {
  Map<String, String> arguments;
  String shohada_id;
  ShohadaDetailsBloc _shohadaDetailsBloc;
  ThemeBloc _themeBloc;
  final maxBorderRadius = 50.0;
  var borderRadius;
  bool elc = false;
  AnimationController _animationController;
  IconData iconState = Icons.favorite_border;
  // Icon(Icons.favorite_border, size: 30, color: IColors.white85);
  Color backgroundColor = IColors.purpleCrimson;
  bool _isDarkMode = false;
  double _fontSize = 0;
  GlobalKey _one = GlobalKey();
  ShowcaseBloc _showcaseBloc = new ShowcaseBloc();

  @override
  void initState() {
    arguments = widget.args;
    _getArguments();
    borderRadius = maxBorderRadius;

    print("Shohada_id=${shohada_id}");
    _shohadaDetailsBloc = BlocProvider.of<ShohadaDetailsBloc>(context);
    _themeBloc = BlocProvider.of<ThemeBloc>(context);
    _shohadaDetailsBloc.add(GetShohadaDetails(shohada_id: shohada_id));
    _themeBloc.add(GetThemeStatus());
    _showcaseBloc.add(ShowcaseDetail(keys: [_one], buildContext: context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ShohadaDetailsBloc, ShohadaDetailsState>(
          listener: (context, state) {
            if (state is ShohadaDetailsFailure) {
              setState(() {
                backgroundColor =
                    _isDarkMode ? IColors.darkBackgroundColor : Colors.white;
              });
            } else if (state is ShohadaDetailsSuccess) {}
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
              _isDarkMode ? IColors.darkBackgroundColor : backgroundColor,
          body: BlocConsumer<InternetCubit, InternetState>(
            listener: (context, state) {
              if (state is InternetConnected) {
                setState(() {
                  backgroundColor = _isDarkMode
                      ? IColors.darkBackgroundColor
                      : IColors.purpleCrimson;
                });
              } else if (state is InternetDisconnected) {
                setState(() {
                  backgroundColor =
                      _isDarkMode ? IColors.darkBackgroundColor : Colors.white;
                });
              }
            },
            builder: (context, state) {
              if (state is InternetConnected) {
                return BlocBuilder<ShohadaDetailsBloc, ShohadaDetailsState>(
                  builder: (context, state) {
                    if (state is ShohadaDetailsInitial) {
                      return Container();
                    } else if (state is ShohadaDetailsLoading) {
                      return LoadingBar(
                        color:
                            _isDarkMode ? IColors.darkLightPink : Colors.white,
                      );
                    } else if (state is ShohadaDetailsSuccess) {
                      return getShohadaUI(state);
                    } else if (state is LikeShohadaSuccess) {
                      return getShohadaUI(state);
                    } else if (state is ShohadaDetailsFailure) {
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
    );
  }

  Widget getShohadaUI(var state) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: ScreenUtil().setHeight(250),
          // decoration: BoxDecoration(
          //   image: DecorationImage(
          //     fit: BoxFit.fitWidth,
          //     // image:
          //     // NetworkImage(ApiProvider.IMAGE_PROVIDER +
          //     //     state.shohadaDetailsModel.data.pictureSizeXLarge),
          //   ),
          // ),
          child: Stack(
            children: [
              OctoImage(
                image: CachedNetworkImageProvider(
                  ApiProvider.IMAGE_PROVIDER +
                      state.shohadaDetailsModel.data.pictureSizeXLarge
                          .toString()
                          .trim(),
                ),
                placeholderBuilder: OctoPlaceholder.blurHash(
                  // 'LEHV6nWB2yk8pyo0adR*.7kCMdnj',
                  state.shohadaDetailsModel.data.blurhash,
                ),
                errorBuilder: OctoError.icon(color: Colors.red),
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
              ),
              new BackdropFilter(
                filter: new ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
                child: new Container(
                  decoration:
                      new BoxDecoration(color: Colors.white.withOpacity(0.05)),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 38),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ShowcaseHelperWidget(
                text: Strings.showcaseShohadaDetailGuide,
                key: _one,
                duration: Duration(
                    milliseconds: Values.showcaseAnimationTransitionSpeed),
                showcaseBackgroundColor: IColors.white85,
                fontSize: _fontSize,
                child: ElasticIn(
                  manualTrigger: true,
                  animate: true,
                  controller: (controller) {
                    _animationController = controller;
                  },
                  child: InkResponse(
                    onTap: () {
                      _animationController.reset();
                      _animationController.forward();
                      likeIconState();
                    },
                    child: DecoratedIcon(
                      state.liked == "true"
                          ? iconState = Icons.favorite
                          : iconState = Icons.favorite_border,
                      size: 30,
                      color: IColors.white85,
                      shadows: [
                        BoxShadow(
                          blurRadius: 12.0,
                          color: Colors.black54,
                        ),
                      ],
                      // padding: EdgeInsets.zero,
                      // onPressed: () {
                      //   _animationController.reset();
                      //   _animationController.forward();
                      //   likeIconState();
                      // },
                      // icon: state.liked == "true"
                      //     ? iconState = Icon(Icons.favorite,
                      //         size: 30, color: IColors.white85)
                      //     : iconState = Icon(Icons.favorite_border,
                      //         size: 30, color: IColors.white85),
                    ),
                  ),
                ),
              ),
              InkResponse(
                onTap: () => Navigator.pop(context),
                child: DecoratedIcon(
                  Icons.arrow_back,
                  textDirection: TextDirection.rtl,
                  color: IColors.white85,
                  size: 30,
                  shadows: [
                    BoxShadow(
                      blurRadius: 12.0,
                      color: Colors.black54,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        NotificationListener<DraggableScrollableNotification>(
          onNotification: (notification) {
            borderRadius =
                notification.maxExtent <= (notification.extent + 0.08)
                    ? 0.0
                    : maxBorderRadius;
          },
          child: DraggableScrollableSheet(
              initialChildSize: 0.7,
              minChildSize: 0.7,
              builder: (context, scroll) {
                return ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(
                          double.parse(borderRadius.toString())),
                      topRight: Radius.circular(
                          double.parse(borderRadius.toString()))),
                  child: Container(
                    color: _isDarkMode ? IColors.darkBlack07 : Colors.white,
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: ListView(
                        controller: scroll,
                        padding: const EdgeInsets.only(
                            top: 30, right: 16, left: 16, bottom: 16),
                        children: [
                          Row(
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    width: 35,
                                    height: 35,
                                    child: Center(
                                      child: Text(
                                          '${state.shohadaDetailsModel.data.id}',
                                          style: TextStyle(
                                              fontSize: 14 + _fontSize,
                                              color: IColors.brown,
                                              fontWeight: FontWeight.w700)),
                                    ),
                                  ),
                                  Image.asset(Assets.largeShamse),
                                ],
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Flexible(
                                child: Text(
                                  "${state.shohadaDetailsModel.data.name}",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 16 + _fontSize,
                                      fontWeight: FontWeight.w700,
                                      color: _isDarkMode
                                          ? IColors.darkWhite70
                                          : IColors.black70),
                                ),
                              )
                            ],
                          ),
                          Text(
                            "${state.shohadaDetailsModel.data.titleText}",
                            // overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 16 + _fontSize,
                                fontWeight: FontWeight.normal,
                                color: _isDarkMode
                                    ? IColors.darkWhite45
                                    : IColors.black45),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _showcaseBloc.close();
    super.dispose();
  }

  void _getArguments() {
    shohada_id = arguments['shohada_id'];
  }

  void likeIconState() {
    if (iconState == Icons.favorite_border) {
      _shohadaDetailsBloc.add(
          LikeShohada(user_id: GlobalWidget.user_id, shohada_id: shohada_id));
      setState(() {
        iconState = Icons.favorite;
      });
    } else {
      _shohadaDetailsBloc.add(DisLikeShohada(
          user_id: GlobalWidget.user_id, shohada_id: shohada_id));
      setState(() {
        iconState = Icons.favorite_border;
      });
    }
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
