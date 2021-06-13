import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:namaz_app/constants/colors.dart';
import 'package:namaz_app/constants/strings.dart';
import 'package:namaz_app/logic/bloc/home_bloc.dart';
import 'package:namaz_app/networking/api_provider.dart';
import 'package:namaz_app/presentation/widget/loading_bar.dart';
import 'package:namaz_app/presentation/widget/marjae_small_item.dart';
import 'package:namaz_app/presentation/widget/narratives_item.dart';
import 'package:namaz_app/presentation/widget/video_item.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> with TickerProviderStateMixin {
  HomeBloc _homeBloc;
  bool loading = true;
  @override
  void initState() {
    _homeBloc = BlocProvider.of<HomeBloc>(context);
    _homeBloc.add(GetHomeItemsEvent());
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
                  Text(
                    "${Strings.homeVideos}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: IColors.black70,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  BlocBuilder<HomeBloc, HomeState>(
                    builder: (context, state) {
                      if (state is HomeLoading) {
                        return Container();
                      } else if (state is HomeSuccess) {
                        return VideoItem(
                          state: state,
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
                        "${Strings.homeMaraje}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: IColors.black70,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(context, '/marjae'),
                        child: Text(
                          "${Strings.homeMore}",
                          style: TextStyle(
                            fontSize: 16,
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
                                thumbPicture: ApiProvider.IMAGE_PROVIDER +
                                    state.homeModel.marjae[index]
                                        .pictureSizeSmall,
                                delete: false,
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
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${Strings.homeNarratives}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: IColors.black70,
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
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: state.homeModel.narratives.length,
                          itemBuilder: (context, index) {
                            return NarrativesItem(
                              deleteSlidable: false,
                              title: state.homeModel.narratives[index]
                                  .quoteeTranslation,
                              subTitle: state
                                  .homeModel.narratives[index].quoteTranslation,
                            );
                          },
                        );
                      } else if (state is HomeFailure) {
                        return Container();
                      } else if (state is HomeInitial) {
                        return Container();
                      }
                    },
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, '/narratives'),
                    child: Center(
                      child: Text(
                        "${Strings.homeMore}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: IColors.brown,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${Strings.homeShohadaBozorgan}",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: IColors.black70,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(context, '/shohada'),
                        child: Text(
                          "${Strings.homeMore}",
                          style: TextStyle(
                            fontSize: 16,
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
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: state.homeModel.shohadaBozorgan.length,
                            itemBuilder: (context, index) {
                              return MarjaeSmallItem(
                                delete: false,
                                title:
                                    state.homeModel.shohadaBozorgan[index].name,
                                thumbPicture: ApiProvider.IMAGE_PROVIDER +
                                    state.homeModel.shohadaBozorgan[index]
                                        .pictureSizeSmall,
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
                ],
              ),
            ),
          ),
        );
      } else if (state is HomeLoading) {
        return LoadingBar();
      } else {
        return Container();
      }
    });
  }
}
