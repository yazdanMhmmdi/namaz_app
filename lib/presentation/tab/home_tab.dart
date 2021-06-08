import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:namaz_app/constants/colors.dart';
import 'package:namaz_app/constants/strings.dart';
import 'package:namaz_app/logic/bloc/home_bloc.dart';
import 'package:namaz_app/networking/api_provider.dart';
import 'package:namaz_app/presentation/widget/marjae_small_item.dart';
import 'package:namaz_app/presentation/widget/narratives_item.dart';

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
                        return Container(
                          width: double.infinity,
                          height: 142,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  colorFilter: ColorFilter.mode(
                                      IColors.purpleCrimson65,
                                      BlendMode.srcOver),
                                  fit: BoxFit.cover,
                                  alignment: Alignment.topCenter,
                                  image: NetworkImage(
                                    ApiProvider.IMAGE_PROVIDER +
                                        state.homeModel.video.thumbnail,
                                  )),
                              color: IColors.brown,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(4, 6),
                                  blurRadius: 10,
                                  color: IColors.purpleCrimson25,
                                )
                              ]),
                          child: Stack(
                            children: [
                              Positioned(
                                bottom: 16,
                                left: 16,
                                child: Container(
                                  width: 26,
                                  height: 26,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                            blurRadius: 6,
                                            offset: Offset(0, 6),
                                            color: IColors.black25)
                                      ]),
                                  child: Icon(
                                    Icons.play_arrow_rounded,
                                    color: IColors.purpleCrimson,
                                    size: 25,
                                  ),
                                ),
                              ),
                            ],
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
                        "${Strings.homeMaraje}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: IColors.black70,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
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
                      GestureDetector(
                        onTap: () {},
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
                    onTap: () {},
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
                        onTap: () {},
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
        return SpinKitThreeBounce(
          size: 25,
          color: IColors.purpleCrimson,
        );
      } else {
        return Container();
      }
    });
  }
}
