import 'dart:async';
import 'dart:ui';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:namaz_app/constants/assets.dart';
import 'package:namaz_app/constants/colors.dart';
import 'package:namaz_app/logic/bloc/ahkam_details_bloc.dart';
import 'package:namaz_app/networking/api_provider.dart';
import 'package:namaz_app/presentation/widget/global_widget.dart';
import 'package:namaz_app/presentation/widget/loading_bar.dart';
import 'package:namaz_app/presentation/widget/server_failure_flare.dart';

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
  final maxBorderRadius = 50.0;
  var borderRadius;
  AnimationController _animationController;
  String prevScreen;
  Color backgroundColor = IColors.purpleCrimson;
  Icon iconState =
      Icon(Icons.favorite_border, size: 30, color: IColors.white85);
  @override
  void initState() {
    arguments = widget.args;
    _getArguments();
    borderRadius = maxBorderRadius;

    _ahkamDetailsBloc = BlocProvider.of<AhkamDetailsBloc>(context);
    _ahkamDetailsBloc.add(
        GetAhkamDetails(ahkam_id: ahkam_id, user_id: GlobalWidget.user_id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AhkamDetailsBloc, AhkamDetailsState>(
      listener: (context, state) {
        if (state is AhkamDetailsFailure) {
          setState(() {
            backgroundColor = Colors.white;
          });
        }
      },
      child: Scaffold(
          backgroundColor: backgroundColor,
          body: SafeArea(
            child: BlocBuilder<AhkamDetailsBloc, AhkamDetailsState>(
              builder: (context, state) {
                if (state is AhkamDetailsInitial) {
                  return Container();
                } else if (state is AhkamDetailsLoading) {
                  return LoadingBar(color: IColors.lightBrown);
                } else if (state is AhkamDetailsSuccess) {
                  return getAhkamShowUI(state);
                } else if (state is LikeAhkamSuccess) {
                  return getAhkamShowUI(state);
                } else if (state is AhkamDetailsFailure) {
                  return ServerFailureFlare();
                }
              },
            ),
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
          child: new BackdropFilter(
            filter: new ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
            child: new Container(
              decoration:
                  new BoxDecoration(color: Colors.white.withOpacity(0.05)),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 22),
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
                child: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    _animationController.reset();
                    _animationController.forward();
                    likeIconState();
                  },
                  icon: state.liked == "true"
                      ? iconState =
                          Icon(Icons.favorite, size: 30, color: IColors.white85)
                      : iconState = Icon(Icons.favorite_border,
                          size: 30, color: IColors.white85),
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
                    color: Colors.white,
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
                                            '${state.ahkamDetailsModel.data.id}',
                                            style: TextStyle(
                                                fontSize: 14,
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
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: IColors.black70),
                                  ),
                                )
                              ],
                            ),
                            Html(
                              data:
                                  '${state.ahkamDetailsModel.data.titleText}',
                              style: {
                                "*": Style(
                                  lineHeight: LineHeight.number(1),
                                  direction: TextDirection.rtl,
                                ),
                                "h3": Style(
                                  fontSize: FontSize(18),
                                  color: IColors.black70,
                                ),
                                "h4": Style(
                                  fontSize: FontSize(16),
                                  color: IColors.black70,
                                ),
                                "h5": Style(
                                  fontSize: FontSize(16),
                                  color: IColors.black70,
                                  fontWeight: FontWeight.bold,
                                ),
                                "div": Style(
                                  fontSize: FontSize(14),
                                  padding: EdgeInsets.only(right: 20),
                                ),
                                "div p": Style(
                                  color: IColors.black45,
                                  fontSize: FontSize(14),
                                ),
                                "p": Style(
                                  color: IColors.black45,
                                  fontSize: FontSize(14),
                                ),
                                "h4 strong span": Style(
                                  color: IColors.black70,
                                ),
                                "br": Style(
                                  display: Display.INLINE_BLOCK,
                                  markerContent: "",
                                  margin: EdgeInsets.symmetric(vertical: 1),
                                )
                              },
                            ),
                           
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
}
