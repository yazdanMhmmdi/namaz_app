import 'dart:async';

import 'package:feature_discovery/feature_discovery.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:namaz_app/constants/assets.dart';
import 'package:namaz_app/constants/colors.dart';
import 'package:namaz_app/constants/strings.dart';
import 'package:namaz_app/constants/values.dart';
import 'package:namaz_app/logic/bloc/theme_bloc.dart';
import 'package:namaz_app/logic/bloc/home_bloc.dart';
import 'package:namaz_app/networking/api_provider.dart';
import 'package:namaz_app/presentation/widget/live_tv_item.dart';
import 'package:namaz_app/presentation/widget/live_tv_widget.dart';
import 'package:namaz_app/presentation/widget/loading_bar.dart';
import 'package:namaz_app/presentation/widget/marjae_small_item.dart';
import 'package:namaz_app/presentation/widget/narratives_item.dart';
import 'package:namaz_app/presentation/widget/showcase_helper_widget.dart';
import 'package:namaz_app/presentation/widget/video_item.dart';
import 'package:showcaseview/showcaseview.dart';

class HomeTab extends StatefulWidget {
  bool isDarkMode = false;
  double fontSize = 0;
  HomeTab({@required this.isDarkMode, @required this.fontSize});
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> with TickerProviderStateMixin {
  HomeBloc _homeBloc;
  bool loading = true;
  GlobalKey _one = GlobalKey();
  GlobalKey _two = GlobalKey();
  GlobalKey _three = GlobalKey();
  GlobalKey _four = GlobalKey();

  @override
  void initState() {
    _homeBloc = BlocProvider.of<HomeBloc>(context);
    _homeBloc.add(GetHomeItemsEvent());

    // WidgetsBinding.instance
    //     .addPostFrameCallback((_) => ShowCaseWidget.of(context).startShowCase([
    //           _one,
    //           _two,
    //           _three,
    //           _four,
    //         ]));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      if (state is HomeSuccess) {
        return SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.only(right: 16, left: 16, top: 16, bottom: 32),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 8,
                  ),
                  BlocBuilder<HomeBloc, HomeState>(
                    builder: (context, state) {
                      if (state is HomeLoading) {
                        return Container();
                      } else if (state is HomeSuccess) {
                        return ShowcaseHelperWidget(
                          fontSize: widget.fontSize,
                          duration: Duration(
                            milliseconds:
                                Values.showcaseAnimationTransitionSpeed,
                          ),
                          key: _one,
                          text: "simple",
                          child: Container(
                            height: 132,
                            child: Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 70, bottom: 9),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      width: double.infinity,
                                      height: 90,
                                      decoration: BoxDecoration(
                                        color: widget.isDarkMode
                                            ? IColors.darkLightPink
                                            : IColors.purpleCrimson,
                                        borderRadius: BorderRadius.circular(30),
                                        boxShadow: [
                                          BoxShadow(
                                            offset: Offset(4, 6),
                                            color: widget.isDarkMode
                                                ? IColors.darkLightPink25
                                                : IColors.purpleCrimson25,
                                            blurRadius: 10,
                                          ),
                                        ],
                                      ),
                                      child: Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          splashColor: Colors.white10,
                                          onTap: () => Navigator.pushNamed(
                                              context, '/videos'),
                                          child: Row(
                                            children: [
                                              Center(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 70),
                                                  child: Text(
                                                    "${Strings.homeVideos}",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      fontSize:
                                                          16 + widget.fontSize,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: widget.isDarkMode
                                                          ? IColors.darkBlack70
                                                          : IColors.white85,
                                                    ),
                                                  ),
                                                ),
                                              ),
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
                                    child: Image.asset(widget.isDarkMode
                                        ? Assets.prayerODark
                                        : Assets.prayerO),
                                  ),
                                ),
                                Positioned(
                                  left: 16,
                                  bottom: 0,
                                  top: 0,
                                  child: Container(
                                    width: 26,
                                    height: 26,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.play_arrow_rounded,
                                      color: widget.isDarkMode
                                          ? IColors.darkLightPink
                                          : IColors.purpleCrimson,
                                      size: 25,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      } else if (state is HomeFailure) {
                        return Container();
                      } else if (state is HomeInitial) {
                        return Container();
                      }
                    },
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${Strings.homeMaraje}",
                        style: TextStyle(
                          fontSize: 16 + widget.fontSize,
                          fontWeight: FontWeight.w700,
                          color: widget.isDarkMode
                              ? IColors.darkWhite70
                              : IColors.black70,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(context, '/marjae'),
                        child: Text(
                          "${Strings.homeMore}",
                          style: TextStyle(
                            fontSize: 16 + widget.fontSize,
                            fontWeight: FontWeight.w700,
                            color: IColors.brown,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  BlocBuilder<HomeBloc, HomeState>(
                    builder: (context, state) {
                      if (state is HomeLoading) {
                        return Container();
                      } else if (state is HomeSuccess) {
                        return Container(
                          height: 128,
                          child: ShowcaseHelperWidget(
                            text: 'test',
                            key: _two,
                            duration: Duration(
                                milliseconds:
                                    Values.showcaseAnimationTransitionSpeed),
                            fontSize: widget.fontSize,
                            showcaseBackgroundColor: IColors.white85,
                            child: ListView.builder(
                              itemCount: state.homeModel.marjae.length,
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return MarjaeSmallItem(
                                  onTap: () => Navigator.pushNamed(
                                      context, '/ahkam',
                                      arguments: <String, String>{
                                        'marjae_id':
                                            state.homeModel.marjae[index].id,
                                      }),
                                  title: state.homeModel.marjae[index].name,
                                  thumbPicture: state
                                      .homeModel.marjae[index].pictureSizeSmall,
                                  hash: state.homeModel.marjae[index].blurhash,
                                  delete: false,
                                  isDarkMode: widget.isDarkMode,
                                  fontSize: widget.fontSize,
                                );
                              },
                            ),
                          ),
                        );
                      } else if (state is HomeFailure) {
                        return Container();
                      } else if (state is HomeInitial) {
                        return Container();
                      }
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${Strings.homeNarratives}",
                        style: TextStyle(
                          fontSize: 16 + widget.fontSize,
                          fontWeight: FontWeight.w700,
                          color: widget.isDarkMode
                              ? IColors.darkWhite70
                              : IColors.black70,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  BlocBuilder<HomeBloc, HomeState>(
                    builder: (context, state) {
                      if (state is HomeLoading) {
                        return Container();
                      } else if (state is HomeSuccess) {
                        return ShowcaseHelperWidget(
                          text: 'test',
                          key: _three,
                          duration: Duration(
                              milliseconds:
                                  Values.showcaseAnimationTransitionSpeed),
                          fontSize: widget.fontSize,
                          showcaseBackgroundColor: IColors.white85,
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: state.homeModel.narratives.length,
                            itemBuilder: (context, index) {
                              return NarrativesItem(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, '/narratives_show',
                                      arguments: <String, String>{
                                        "narratives_id": state
                                            .homeModel.narratives[index].id,
                                      });
                                },
                                deleteSlidable: false,
                                needShowcase: false,
                                title: state.homeModel.narratives[index]
                                    .quoteeTranslation,
                                subTitle: state.homeModel.narratives[index]
                                    .quoteTranslation,
                                id: state.homeModel.narratives[index].id,
                                isDarkMode: widget.isDarkMode,
                                fontSize: widget.fontSize,
                                itemIndex: index,
                              );
                            },
                          ),
                        );
                      } else if (state is HomeFailure) {
                        return Container();
                      } else if (state is HomeInitial) {
                        return Container();
                      }
                    },
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, '/narratives'),
                    child: Center(
                      child: Text(
                        "${Strings.homeMore}",
                        style: TextStyle(
                          fontSize: 16 + widget.fontSize,
                          fontWeight: FontWeight.w700,
                          color: IColors.brown,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${Strings.homeShohadaBozorgan}",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 16 + widget.fontSize,
                          fontWeight: FontWeight.w700,
                          color: widget.isDarkMode
                              ? IColors.darkWhite70
                              : IColors.black70,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(context, '/shohada'),
                        child: Text(
                          "${Strings.homeMore}",
                          style: TextStyle(
                            fontSize: 16 + widget.fontSize,
                            fontWeight: FontWeight.w700,
                            color: IColors.brown,
                          ),
                        ),
                      ),
                    ],
                  ),
                  BlocBuilder<HomeBloc, HomeState>(
                    builder: (context, state) {
                      if (state is HomeLoading) {
                        return Container();
                      } else if (state is HomeSuccess) {
                        return Container(
                          height: 128,
                          child: ShowcaseHelperWidget(
                            text: 'test',
                            key: _four,
                            duration: Duration(
                                milliseconds:
                                    Values.showcaseAnimationTransitionSpeed),
                            fontSize: widget.fontSize,
                            showcaseBackgroundColor: IColors.white85,
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: state.homeModel.shohadaBozorgan.length,
                              itemBuilder: (context, index) {
                                return MarjaeSmallItem(
                                  onTap: () => Navigator.pushNamed(
                                      context, '/shohada_details',
                                      arguments: <String, String>{
                                        "shohada_id": state.homeModel
                                            .shohadaBozorgan[index].id,
                                      }),
                                  delete: false,
                                  hash: state.homeModel.shohadaBozorgan[index]
                                      .blurhash,
                                  title: state
                                      .homeModel.shohadaBozorgan[index].name,
                                  thumbPicture: state.homeModel
                                      .shohadaBozorgan[index].pictureSizeSmall,
                                  isDarkMode: widget.isDarkMode,
                                  fontSize: widget.fontSize,
                                );
                              },
                            ),
                          ),
                        );
                      } else if (state is HomeFailure) {
                        return Container();
                      } else if (state is HomeInitial) {
                        return Container();
                      }
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${Strings.homeOnlineTv}",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 16 + widget.fontSize,
                          fontWeight: FontWeight.w700,
                          color: widget.isDarkMode
                              ? IColors.darkWhite70
                              : IColors.black70,
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      LiveTvWidget(isDarkMode: widget.isDarkMode)
                    ],
                  ),
                  BlocBuilder<HomeBloc, HomeState>(
                    builder: (context, state) {
                      if (state is HomeLoading) {
                        return Container();
                      } else if (state is HomeSuccess) {
                        return Container(
                          height: 128,
                          child: ListView.builder(
                              itemCount: state.homeModel.liveTv.length,
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return LiveTvItem(
                                  delete: false,
                                  title: state.homeModel.liveTv[index].name,
                                  thumbPicture: state
                                      .homeModel.liveTv[index].thumbPicture,
                                  onTap: () => Navigator.pushNamed(
                                      context, '/live_tv_details',
                                      arguments: <String, String>{
                                        "live_tv_id":
                                            state.homeModel.liveTv[index].id,
                                      }),
                                  hash: state.homeModel.liveTv[index].blurhash,
                                  isDarkMode: widget.isDarkMode,
                                  fontSize: widget.fontSize,
                                );
                              }),
                        );
                      } else if (state is HomeFailure) {
                        return Container();
                      } else if (state is HomeInitial) {
                        return Container();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      } else if (state is HomeLoading) {
        return LoadingBar(
            color: widget.isDarkMode
                ? IColors.darkLightPink
                : IColors.purpleCrimson);
      } else {
        return Container();
      }
    });
  }
}
