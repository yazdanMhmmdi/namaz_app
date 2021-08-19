import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:namaz_app/constants/colors.dart';
import 'package:namaz_app/constants/strings.dart';
import 'package:namaz_app/logic/bloc/video_bloc.dart';
import 'package:namaz_app/logic/cubit/internet_cubit.dart';
import 'package:namaz_app/presentation/widget/back_button_widget.dart';
import 'package:namaz_app/presentation/widget/loading_bar.dart';
import 'package:namaz_app/presentation/widget/narratives_item.dart';
import 'package:namaz_app/presentation/widget/no_network_flare.dart';
import 'package:namaz_app/presentation/widget/search_button_widget.dart';
import 'package:namaz_app/presentation/widget/search_field_widget.dart';
import 'package:namaz_app/presentation/widget/server_failure_flare.dart';
import 'package:namaz_app/presentation/widget/video_item.dart';
import 'package:namaz_app/presentation/widget/videos_item.dart';

class VideosScreen extends StatefulWidget {
  @override
  _VideosScreenState createState() => _VideosScreenState();
}

class _VideosScreenState extends State<VideosScreen>
    with SingleTickerProviderStateMixin {
  bool lazyLoading = true;
  ScrollController _controller = ScrollController();
  VideoBloc _videoBloc;
  bool searchVisibility = true;
  Animation<double> animation;
  AnimationController animationController;
  bool isForward = false;
  bool _clickProtectorSearch =
      true; // clickProtectors prevent user from click multiple times and distrupt animation
  TextEditingController searchTextController = new TextEditingController();
  bool searchLoading = true;
  bool emptyList = false;
  @override
  void initState() {
    _videoBloc = BlocProvider.of<VideoBloc>(context);
    _videoBloc.add(GetVideoItems(search: ""));
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        print('end of page');
        _videoBloc.add(GetVideoItems(search: searchTextController.text));
      }
    });
    super.initState();
    searchFieldAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: IColors.lightBrown,
      body: SafeArea(
        child: BlocConsumer<InternetCubit, InternetState>(
          listener: (context, state) {
            // if
          },
          builder: (context, state) {
            if (state is InternetConnected) {
              return BlocBuilder<VideoBloc, VideoState>(
                builder: (context, state) {
                  if (state is VideoInitial) {
                    return Container();
                  } else if (state is VideoLoading) {
                    emptyList = false;
                    return LoadingBar();
                  } else if (state is VideoLazyLoading) {
                    lazyLoading = true;
                    return getVideoUI(state);
                  } else if (state is VideoListCompleted) {
                    lazyLoading = false;
                    return getVideoUI(state);
                  } else if (state is VideoSuccess) {
                    emptyList = false;

                    searchLoading = false;
                    // lazyLoading = false; // new added
                    return getVideoUI(state);
                  } else if (state is VideoSearchEmpty) {
                    lazyLoading = false;
                    searchLoading = false;
                    emptyList = true;
                    return getVideoUI(state);
                  } else if (state is VideoSearchLoading) {
                    searchLoading = true;
                    emptyList = false;
                    lazyLoading = false;
                    return getVideoUI(state);
                  } else if (state is VideoFailure) {
                    return ServerFailureFlare();
                  }
                },
              );
            } else if (state is InternetDisconnected) {
              return NoNetworkFlare();
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  Widget getVideoUI(var state) {
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
                  Center(
                    child: Text(
                      "${Strings.videos}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: IColors.black70,
                      ),
                    ),
                  ),
                  SearchButtonWidget(
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
                                    _videoBloc.add(SearchVideoItems(
                                        search: searchTextController.text));
                                  });
                                }
                              });
                            }),
                ],
              ),
            ),
            SizedBox(height: 8),
            SearchFieldWidget(
                isForward: isForward,
                animation: animation,
                searchTextController: searchTextController,
                onChanged: (text) {
                  print("searched text: ${text}");
                  _videoBloc.add(SearchVideoItems(search: text));
                }),
            SizedBox(height: 16),
            !emptyList
                ? searchLoading
                    ? Container(
                        height: MediaQuery.of(context).size.height - 180,
                        child: LoadingBar())
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: state.videoModel.video.length,
                          itemBuilder: (contet, index) {
                            return VideosItem(
                                video_id: state.videoModel.video[index].id,
                                searchedText: searchTextController.text,
                                blurhash:
                                    state.videoModel.video[index].blurhash,
                                onTap: () => Navigator.pushNamed(
                                        context, '/videos_details',
                                        arguments: <String, String>{
                                          "video_id":
                                              state.videoModel.video[index].id,
                                        }),
                                deleteSlidable: false,
                                isPinned:
                                    state.videoModel.video[index].isPinned,
                                title: state.videoModel.video[index].title,
                                thumbnail:
                                    state.videoModel.video[index].thumbnail);
                          },
                        ),
                      )
                : Container(
                    height: MediaQuery.of(context).size.height - 180,
                    child: Center(
                        child: Text(
                      Strings.noResultFound,
                      style: TextStyle(color: IColors.black45),
                    ))),
            SizedBox(
              height: 8,
            ),
            lazyLoading ? LoadingBar() : Container(),
            SizedBox(
              height: 16,
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
}
