import 'package:animate_do/animate_do.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:namaz_app/constants/colors.dart';
import 'package:namaz_app/logic/bloc/live_tv_details_bloc.dart';
import 'package:namaz_app/logic/bloc/theme_bloc.dart';
import 'package:namaz_app/logic/bloc/video_details_bloc.dart';
import 'package:namaz_app/presentation/widget/global_widget.dart';
import 'package:namaz_app/presentation/widget/live_tv_widget.dart';
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

  LiveTvDetailsBloc _liveTvDetailsBloc;
  ThemeBloc _themeBloc;
  String liveTvId;
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
    _liveTvDetailsBloc = BlocProvider.of<LiveTvDetailsBloc>(context);
    _themeBloc = BlocProvider.of<ThemeBloc>(context);
    _liveTvDetailsBloc.add(GetLiveTvDetails(liveTvId: liveTvId));
    _themeBloc.add(GetThemeStatus());
  }

  final _url = 'https://flutter.dev';
  @override
  Widget build(BuildContext context) {
    print(liveTvId);
    return MultiBlocListener(
      listeners: [
        BlocListener<LiveTvDetailsBloc, LiveTvDetailsState>(
          listener: (context, state) {
            if (state is LiveTvDetailsFailure) {
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
          body: BlocBuilder<LiveTvDetailsBloc, LiveTvDetailsState>(
            builder: (context, state) {
              if (state is LiveTvDetailsInitial) {
                return Container();
              } else if (state is LiveTvDetailsLoading) {
                return LoadingBar(
                  color: Colors.white70,
                );
              } else if (state is LiveTvDetailsSuccess) {
                return getVideoDetailsUI(state);
              } else if (state is LiveTvDetailsFailure) {
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
    liveTvId = arguments['live_tv_id'];
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
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Flexible(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: Icon(
                                Icons.arrow_back,
                                textDirection: TextDirection.rtl,
                                color: IColors.white85,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Flexible(
                            child: Container(
                              child: Text(
                                "${state.liveTvDetailModel.data.name}",
                                style: TextStyle(
                                  fontSize: 16 + _fontSize,
                                  color: IColors.white85,
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          Container(
                              child: LiveTvWidget(isDarkMode: _isDarkMode)),
                        ],
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
    _liveTvDetailsBloc.close();
    _liveTvDetailsBloc.chewieController.dispose();
    _liveTvDetailsBloc.videoPlayerController.dispose();
    super.dispose();
  }
}
