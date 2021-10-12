import 'package:animate_do/animate_do.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:namaz_app/constants/colors.dart';
import 'package:namaz_app/logic/bloc/theme_bloc.dart';
import 'package:namaz_app/logic/bloc/video_details_bloc.dart';
import 'package:namaz_app/presentation/widget/global_widget.dart';
import 'package:namaz_app/presentation/widget/loading_bar.dart';
import 'package:namaz_app/presentation/widget/server_failure_flare.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

class LiveTvDetailsScreen extends StatefulWidget {
  Map<String, String> args;
  LiveTvDetailsScreen({this.args});
  @override
  _LiveTvDetailsScreenState createState() => _LiveTvDetailsScreenState();
}

class _LiveTvDetailsScreenState extends State<LiveTvDetailsScreen> {
  Map<String, String> arguments;

  VideoDetailsBloc _videoDetailsBloc;
  ThemeBloc _themeBloc;
  String video_id;
  AnimationController _animationController;
  Icon iconState =
      Icon(Icons.favorite_border, size: 30, color: IColors.white85);
  var chewieController;
  Color backgroundColor = Colors.grey[600];
  bool _isDarkMode = false;
  double _fontSize = 0;
  @override
  void initState() {
    super.initState();
    arguments = widget.args;
    _getArguments();
    _videoDetailsBloc = BlocProvider.of<VideoDetailsBloc>(context);
    _themeBloc = BlocProvider.of<ThemeBloc>(context);
    _videoDetailsBloc.add(GetVideoDetails(video_id: video_id));
    _themeBloc.add(GetThemeStatus());
  }

  final _url = 'https://flutter.dev';
  @override
  Widget build(BuildContext context) {
    print(video_id);
    return MultiBlocListener(
      listeners: [
        BlocListener<VideoDetailsBloc, VideoDetailsState>(
          listener: (context, state) {
            if (state is VideoDetailsFailure) {
              setState(() {
                backgroundColor = Colors.white;
              });
            }
          },
        ),
        BlocListener<ThemeBloc, ThemeState>(listener: (context, state) {
          darkModeStateFunction(state);
        }),
      ],
      child: Scaffold(
          backgroundColor:
              _isDarkMode ? IColors.darkBackgroundColor : backgroundColor,
          body: BlocBuilder<VideoDetailsBloc, VideoDetailsState>(
            builder: (context, state) {
              if (state is VideoDetailsInitial) {
                return Container();
              } else if (state is VideoDetailsLoading) {
                return LoadingBar(
                  color: Colors.white70,
                );
              } else if (state is VideoDetailsSuccess) {
                return getVideoDetailsUI(state);
              } else if (state is LikeSuccess) {
                return getVideoDetailsUI(state);
              } else if (state is VideoDetailsFailure) {
                return ServerFailureFlare(isDarkMode: _isDarkMode);
              }
            },
          )),
    );
  }

  void _launchURL() async {
    await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
  }

  void _getArguments() {
    video_id = arguments['live_tv_id'];
  }

  Widget getVideoDetailsUI(var state) {
    {
      return SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Stack(
            children: [
              Chewie(
                controller: state.chewieController,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: Icon(
                            Icons.arrow_back,
                            textDirection: TextDirection.rtl,
                            color: IColors.white85,
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width - 144,
                          child: Text(
                            "${state.videoDetailsModel.data.title}",
                            style: TextStyle(
                              fontSize: 16 + _fontSize,
                              color: IColors.white85,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    ElasticIn(
                      manualTrigger: true,
                      animate: true,
                      controller: (controller) {
                        _animationController = controller;
                      },
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
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  void likeIconState() {
    if (iconState.icon == Icons.favorite_border) {
      _videoDetailsBloc
          .add(LikeVideo(user_id: GlobalWidget.user_id, video_id: video_id));
      setState(() {
        iconState = Icon(Icons.favorite, size: 30, color: IColors.white85);
      });
    } else {
      _videoDetailsBloc
          .add(DisLikeVideo(user_id: GlobalWidget.user_id, video_id: video_id));
      setState(() {
        iconState =
            Icon(Icons.favorite_border, size: 30, color: IColors.white85);
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

  @override
  void dispose() {
    _videoDetailsBloc.close();
    _videoDetailsBloc.chewieController.dispose();
    _videoDetailsBloc.videoPlayerController.dispose();
    super.dispose();
  }
}
