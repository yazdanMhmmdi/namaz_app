import 'dart:async';
import 'dart:ui';

import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:feature_discovery/feature_discovery.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:namaz_app/constants/assets.dart';
import 'package:namaz_app/constants/colors.dart';
import 'package:namaz_app/constants/strings.dart';
import 'package:namaz_app/logic/bloc/ahkam_details_bloc.dart';
import 'package:namaz_app/logic/bloc/theme_bloc.dart';
import 'package:namaz_app/logic/cubit/internet_cubit.dart';
import 'package:namaz_app/networking/api_provider.dart';
import 'package:namaz_app/presentation/widget/global_widget.dart';
import 'package:namaz_app/presentation/widget/loading_bar.dart';
import 'package:namaz_app/presentation/widget/no_network_flare.dart';
import 'package:namaz_app/presentation/widget/server_failure_flare.dart';
import 'package:octo_image/octo_image.dart';
import 'package:simple_html_css/simple_html_css.dart';

class AhkamShowScreen extends StatefulWidget {
  Map<String, String> args;
  AhkamShowScreen({this.args});
  @override
  _AhkamShowScreenState createState() => _AhkamShowScreenState();
}

class _AhkamShowScreenState extends State<AhkamShowScreen> {
  Map<String, String> arguments;
  String ahkam_id;
  AhkamDetailsBloc _ahkamDetailsBloc;
  ThemeBloc _themeBloc;
  final maxBorderRadius = 50.0;
  var borderRadius;
  AnimationController _animationController;
  String prevScreen;
  Color backgroundColor = IColors.purpleCrimson;
  Icon iconState =
      Icon(Icons.favorite_border, size: 30, color: IColors.white85);
  bool _isDarkMode = false;
  double _fontSize = 0;
  @override
  void initState() {
    arguments = widget.args;
    _getArguments();
    borderRadius = maxBorderRadius;

    _ahkamDetailsBloc = BlocProvider.of<AhkamDetailsBloc>(context);
    _themeBloc = BlocProvider.of<ThemeBloc>(context);
    _ahkamDetailsBloc.add(
        GetAhkamDetails(ahkam_id: ahkam_id, user_id: GlobalWidget.user_id));
    _themeBloc.add(GetThemeStatus());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AhkamDetailsBloc, AhkamDetailsState>(
            listener: (context, state) {
          if (state is AhkamDetailsFailure) {
            setState(() {
              backgroundColor = Colors.white;
            });
          } else if (state is AhkamDetailsSuccess) {
            if (state.featureDiscovery) {
              Timer(Duration(seconds: 2), () {
                FeatureDiscovery.discoverFeatures(
                  context,
                  <String>{
                    // Feature ids for every feature that you want to showcase in order.
                    Strings.discoverFeatureAhkam,
                  },
                );
              });
            }
          }
        }),
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
                return BlocBuilder<AhkamDetailsBloc, AhkamDetailsState>(
                  builder: (context, state) {
                    if (state is AhkamDetailsInitial) {
                      return Container();
                    } else if (state is AhkamDetailsLoading) {
                      return LoadingBar(
                          color: _isDarkMode
                              ? IColors.darkLightPink
                              : IColors.lightBrown);
                    } else if (state is AhkamDetailsSuccess) {
                      return getAhkamShowUI(state);
                    } else if (state is LikeAhkamSuccess) {
                      return getAhkamShowUI(state);
                    } else if (state is AhkamDetailsFailure) {
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

  void _getArguments() {
    ahkam_id = arguments['ahkam_id'];
    prevScreen = arguments['prevScreen'];
  }

  void likeIconState() {
    if (iconState.icon == Icons.favorite_border) {
      _ahkamDetailsBloc
          .add(LikeAhkam(user_id: GlobalWidget.user_id, ahkam_id: ahkam_id));
      setState(() {
        iconState = Icon(Icons.favorite, size: 30, color: IColors.white85);
      });
    } else {
      _ahkamDetailsBloc
          .add(DisLikeAhkam(user_id: GlobalWidget.user_id, ahkam_id: ahkam_id));
      setState(() {
        iconState =
            Icon(Icons.favorite_border, size: 30, color: IColors.white85);
      });
    }
  }

  void likeIt() {
    iconState = Icon(Icons.favorite, size: 30, color: IColors.white85);
  }

  void disLikeIt() {
    iconState = Icon(Icons.favorite_border, size: 30, color: IColors.white85);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Widget getAhkamShowUI(var state) {
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
                image: NetworkImage(
                  ApiProvider.IMAGE_PROVIDER +
                      state.ahkamDetailsModel.data.pictureSizeXLarge,
                ),
              ),
            ),
            child: Stack(
              children: [
                OctoImage(
                  image: CachedNetworkImageProvider(
                    ApiProvider.IMAGE_PROVIDER +
                        state.ahkamDetailsModel.data.pictureSizeXLarge
                            .toString()
                            .trim(),
                  ),
                  placeholderBuilder: OctoPlaceholder.blurHash(
                    // 'LEHV6nWB2yk8pyo0adR*.7kCMdnj',
                    state.ahkamDetailsModel.data.blurhash,
                  ),
                  errorBuilder: OctoError.icon(color: Colors.red),
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                ),
                new BackdropFilter(
                  filter: new ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
                  child: new Container(
                    decoration: new BoxDecoration(
                        color: Colors.white.withOpacity(0.05)),
                  ),
                ),
              ],
            )),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 32),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElasticIn(
                manualTrigger: true,
                animate: true,
                controller: (controller) {
                  _animationController = controller;
                },
                child: DescribedFeatureOverlay(
                  featureId:
                      '${Strings.discoverFeatureAhkam}', // Unique id that identifies this overlay.
                  tapTarget: Icon(Icons
                      .favorite_border), // The widget that will be displayed as the tap target.
                  title: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'مورد علاقه ها',
                    ),
                  ),
                  description: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'برای اضافه کردن این احکام به عنوان مورد علاقه از این دکمه استفاده کنید.',
                      textAlign: TextAlign.right,
                    ),
                  ),
                  backgroundColor: IColors.brown,
                  targetColor: Colors.white,
                  textColor: Colors.white,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      _animationController.reset();
                      _animationController.forward();
                      likeIconState();
                    },
                    icon: state.liked == "true"
                        ? iconState = Icon(Icons.favorite,
                            size: 30, color: IColors.white85)
                        : iconState = Icon(Icons.favorite_border,
                            size: 30, color: IColors.white85),
                  ),
                ),
              ),
              IconButton(
                padding: EdgeInsets.zero,
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.arrow_back,
                  textDirection: TextDirection.rtl,
                  color: IColors.white85,
                  size: 30,
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
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30, bottom: 16),
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: ListView(
                          controller: scroll,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
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
                                            '${state.ahkamDetailsModel.data.ahkamNumber}',
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
                                    "${state.ahkamDetailsModel.data.title}",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 16 + _fontSize,
                                        fontWeight: FontWeight.bold,
                                        color: _isDarkMode
                                            ? IColors.darkWhite70
                                            : IColors.black70),
                                  ),
                                )
                              ],
                            ),
                            HtmlWidget(
                              // the first parameter (`html`) is required
                              '''
  ${state.ahkamDetailsModel.data.titleText}
  ''',

                              // all other parameters are optional, a few notable params:

                              // specify custom styling for an element
                              // see supported inline styling below
                              customStylesBuilder: (element) {
                                if (element.outerHtml.contains('*')) {
                                  return {
                                    'line-height': '1.6',
                                  };
                                }

                                if (element.classes.contains('foo')) {
                                  return {
                                    'color': 'red',
                                    'line-height': '2.6',
                                  };
                                }

                                return null;
                              },

                              // render a custom widget
                              customWidgetBuilder: (element) {
                                if (element.attributes['foo'] == 'bar') {
                                  return Container();
                                }
                                if (element.outerHtml.contains("h3")) {
                                  return Text(
                                    element.firstChild.text,
                                    style: TextStyle(
                                      fontSize: 16 + _fontSize,
                                      color: _isDarkMode
                                          ? IColors.darkWhite70
                                          : IColors.black70,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: Assets.nabiFont,
                                      letterSpacing: 4.0,
                                    ),
                                  );
                                }

                                return null;
                              },

                              // this callback will be triggered when user taps a link
                              onTapUrl: (url) => print('tapped $url'),

                              // set the default styling for text
                              textStyle: TextStyle(
                                  fontSize: 16 + _fontSize,
                                  color: _isDarkMode
                                      ? IColors.darkWhite70
                                      : IColors.black70),
                            ),
                            // state.ahkamDetailsModel.data.titleText
                            // style: {
                            //   "*": Style(
                            //     lineHeight: LineHeight.number(1),
                            //     direction: TextDirection.rtl,
                            //   ),
                            //   "h3": Style(
                            //     fontSize: FontSize(18),
                            //     color: IColors.black70,
                            //   ),
                            //   "h4": Style(
                            //     fontSize: FontSize(16),
                            //     color: IColors.black70,
                            //   ),
                            //   "h5": Style(
                            //     fontSize: FontSize(16),
                            //     color: IColors.black70,
                            //     fontWeight: FontWeight.bold,
                            //   ),
                            //   "div": Style(
                            //     fontSize: FontSize(14),
                            //     padding: EdgeInsets.only(right: 20),
                            //   ),
                            //   "div p": Style(
                            //     color: IColors.black45,
                            //     fontSize: FontSize(14),
                            //   ),
                            //   "p": Style(
                            //     color: IColors.black45,
                            //     fontSize: FontSize(14),
                            //   ),
                            //   "h4 strong span": Style(
                            //     color: IColors.black70,
                            //   ),
                            //   "br": Style(
                            //     display: Display.INLINE_BLOCK,
                            //     markerContent: "",
                            //     margin: EdgeInsets.symmetric(vertical: 1),
                            //   )
                            // },
                          ],
                        ),
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
}
