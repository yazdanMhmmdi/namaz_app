import 'dart:async';
import 'dart:ui';

import 'package:animate_do/animate_do.dart';
import 'package:decorated_icon/decorated_icon.dart';
import 'package:feature_discovery/feature_discovery.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:namaz_app/constants/assets.dart';
import 'package:namaz_app/constants/colors.dart';
import 'package:namaz_app/constants/strings.dart';
import 'package:namaz_app/constants/values.dart';
import 'package:namaz_app/logic/bloc/showcase_bloc.dart';
import 'package:namaz_app/logic/bloc/theme_bloc.dart';
import 'package:namaz_app/logic/bloc/narratives_details_bloc.dart';
import 'package:namaz_app/logic/cubit/internet_cubit.dart';
import 'package:namaz_app/presentation/widget/back_button_widget.dart';
import 'package:namaz_app/presentation/widget/global_widget.dart';
import 'package:namaz_app/presentation/widget/loading_bar.dart';
import 'package:namaz_app/presentation/widget/no_network_flare.dart';
import 'package:namaz_app/presentation/widget/server_failure_flare.dart';
import 'package:namaz_app/presentation/widget/showcase_helper_widget.dart';
import 'package:showcaseview/showcaseview.dart';

class NarrativesShowScreen extends StatefulWidget {
  Map<String, String> args;

  NarrativesShowScreen({this.args});

  @override
  _NarrativesShowScreenState createState() => _NarrativesShowScreenState();
}

class _NarrativesShowScreenState extends State<NarrativesShowScreen>
    with SingleTickerProviderStateMixin {
  Map<String, String> arguments;

  String narratives_id;

  NarrativesDetailsBloc _narrativesDetailsBloc;
  ThemeBloc _themeBloc;

  final maxBorderRadius = 50.0;

  var borderRadius;

  AnimationController _animationController;
  Color backgroundColor = IColors.purpleCrimson;
  IconData iconState = Icons.favorite_border;
  bool _isDarkMode = false;
  double _fontSize = 0;
  GlobalKey _one = GlobalKey();
  ShowcaseBloc _showcaseBloc = new ShowcaseBloc();

  @override
  void initState() {
    arguments = widget.args;
    _getArguments();
    borderRadius = maxBorderRadius;

    _narrativesDetailsBloc = BlocProvider.of<NarrativesDetailsBloc>(context);
    _themeBloc = BlocProvider.of<ThemeBloc>(context);

    _narrativesDetailsBloc
        .add(GetNarrativesDetails(narratives_id: narratives_id));
    _themeBloc.add(GetThemeStatus());
    _showcaseBloc.add(ShowcaseDetail(keys: [_one], buildContext: context));
    print(narratives_id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<NarrativesDetailsBloc, NarrativesDetailsState>(
          listener: (context, state) {
            if (state is NarrativesDetailsFailure) {
              setState(() {
                backgroundColor =
                    _isDarkMode ? IColors.darkBackgroundColor : Colors.white;
              });
            } else if (state is NarrativesDetailsSuccess) {
              if (state.featureDiscovery) {}
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
              return BlocBuilder<NarrativesDetailsBloc, NarrativesDetailsState>(
                builder: (context, state) {
                  if (state is NarrativesDetailsInitial) {
                    return Container();
                  } else if (state is NarrativesDetailsLoading) {
                    return LoadingBar(
                      color: _isDarkMode
                          ? IColors.darkLightPink
                          : IColors.lightBrown,
                    );
                  } else if (state is NarrativesDetailsSuccess) {
                    return getNarrativesShowUI(state);
                  } else if (state is LikeNarrativesSuccess) {
                    return getNarrativesShowUI(state);
                  } else if (state is NarrativesDetailsFailure) {
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
        ),
      ),
    );
  }

  void _getArguments() {
    narratives_id = arguments['narratives_id'];
  }

  void likeIconState() {
    if (iconState == Icons.favorite_border) {
      _narrativesDetailsBloc.add(LikeNarratives(
          user_id: GlobalWidget.user_id, narratives_id: narratives_id));
      setState(() {
        iconState = Icons.favorite;
      });
    } else {
      _narrativesDetailsBloc.add(DisLikeNarratives(
          user_id: GlobalWidget.user_id, narratives_id: narratives_id));
      setState(() {
        iconState = Icons.favorite_border;
      });
    }
  }

  Widget getNarrativesShowUI(var state) {
    ScreenUtil.init(
      BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width,
          maxHeight: MediaQuery.of(context).size.height),
      designSize: Size(360, 669),
    );
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: ScreenUtil().setHeight(250),
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fitWidth,
              image: AssetImage(
                Assets.narrativesBackground,
              ),
            ),
          ),
          child: new BackdropFilter(
            filter: new ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
            child: new Container(
              decoration:
                  new BoxDecoration(color: Colors.white.withOpacity(0.05)),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 38),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ShowcaseHelperWidget(
                text: Strings.showcaseAhkamGuide,
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
                      likeOpration();

                      // FeatureDiscovery.dismissAll(context);
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
                            top: 38, right: 16, left: 16, bottom: 16),
                        children: [
                          Row(
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    child: Center(
                                      child: Text(
                                          '${state.narrativesDetailsModel.data.id}',
                                          style: TextStyle(
                                              fontSize: 14 + _fontSize,
                                              color: IColors.brown,
                                              fontWeight: FontWeight.w700)),
                                    ),
                                  ),
                                  Image.asset(
                                    Assets.largeShamse,
                                    width: 50,
                                    height: 50,
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Flexible(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        "${state.narrativesDetailsModel.data.quotee}",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontFamily: "nabi",
                                            fontSize: 16 + _fontSize,
                                            fontWeight: FontWeight.w700,
                                            wordSpacing: 2,
                                            color: _isDarkMode
                                                ? IColors.darkWhite70
                                                : IColors.black70),
                                      ),
                                    ),
                                    Flexible(
                                      child: Text(
                                        "${state.narrativesDetailsModel.data.quoteeTranslation}",
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
                              )
                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "${state.narrativesDetailsModel.data.quote}",
                            // overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontFamily: "nabi",
                                fontSize: 16 + _fontSize,
                                fontWeight: FontWeight.w700,
                                wordSpacing: 2,
                                color: _isDarkMode
                                    ? IColors.darkWhite70
                                    : IColors.black45),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Text(
                            "${state.narrativesDetailsModel.data.quoteTranslation}",
                            // overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 16 + _fontSize,
                                fontWeight: FontWeight.normal,
                                color: _isDarkMode
                                    ? IColors.darkWhite45
                                    : IColors.black45),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Container(
                            color: Colors.transparent,
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Flexible(
                                  child: Text(
                                    "${Strings.narrativesSource} ${state.narrativesDetailsModel.data.source}",
                                    style: TextStyle(
                                        fontSize: 14 + _fontSize,
                                        fontWeight: FontWeight.w700,
                                        height: 1.2,
                                        color: _isDarkMode
                                            ? IColors.darkWhite70
                                            : IColors.black70),
                                  ),
                                ),
                              ],
                            ),
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

  @override
  void dispose() {
    _animationController.dispose();
    _showcaseBloc.close();
    super.dispose();
  }

  void likeOpration() {
    _animationController.reset();
    _animationController.forward();
    likeIconState();
  }
}
