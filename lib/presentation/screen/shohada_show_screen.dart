import 'dart:async';
import 'dart:ui';

import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:feature_discovery/feature_discovery.dart';
import 'package:flare_loading/flare_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:namaz_app/constants/assets.dart';
import 'package:namaz_app/constants/colors.dart';
import 'package:namaz_app/constants/strings.dart';
import 'package:namaz_app/logic/bloc/shohada_details_bloc.dart';
import 'package:namaz_app/logic/cubit/internet_cubit.dart';
import 'package:namaz_app/networking/api_provider.dart';
import 'package:namaz_app/presentation/widget/global_widget.dart';
import 'package:namaz_app/presentation/widget/loading_bar.dart';
import 'package:namaz_app/presentation/widget/no_network_flare.dart';
import 'package:namaz_app/presentation/widget/server_failure_flare.dart';
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
  final maxBorderRadius = 50.0;
  var borderRadius;
  bool elc = false;
  AnimationController _animationController;
  Icon iconState =
      Icon(Icons.favorite_border, size: 30, color: IColors.white85);
  Color backgroundColor = IColors.purpleCrimson;

  @override
  void initState() {
    arguments = widget.args;
    _getArguments();
    borderRadius = maxBorderRadius;

    print("Shohada_id=${shohada_id}");
    _shohadaDetailsBloc = BlocProvider.of<ShohadaDetailsBloc>(context);
    _shohadaDetailsBloc.add(GetShohadaDetails(shohada_id: shohada_id));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ShohadaDetailsBloc, ShohadaDetailsState>(
      listener: (context, state) {
        if (state is ShohadaDetailsFailure) {
          setState(() {
            backgroundColor = Colors.white;
          });
        } else if (state is ShohadaDetailsSuccess) {
          if (state.featureDiscovery) {
            Timer(Duration(seconds: 2), () {
              FeatureDiscovery.discoverFeatures(
                context,
                <String>{
                  // Feature ids for every feature that you want to showcase in order.
                  Strings.discoverFeatureShohada,
                },
              );
            });
          }
        }
      },
      child: Scaffold(
          backgroundColor: backgroundColor,
          body: BlocConsumer<InternetCubit, InternetState>(
            listener: (context, state) {
              if (state is InternetConnected) {
                setState(() {
                  backgroundColor = IColors.purpleCrimson;
                });
              } else if (state is InternetDisconnected) {
                setState(() {
                  backgroundColor = Colors.white;
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
                      return LoadingBar();
                    } else if (state is ShohadaDetailsSuccess) {
                      return getShohadaUI(state);
                    } else if (state is LikeShohadaSuccess) {
                      return getShohadaUI(state);
                    } else if (state is ShohadaDetailsFailure) {
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
                  state.blurHash,
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
                      '${Strings.discoverFeatureShohada}', // Unique id that identifies this overlay.
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
                      'برای اضافه کردن این موضوع به عنوان مورد علاقه از این دکمه استفاده کنید.',
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
                    color: Colors.white,
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
                                  "${state.shohadaDetailsModel.data.name}",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: IColors.black70),
                                ),
                              )
                            ],
                          ),
                          Text(
                            "${state.shohadaDetailsModel.data.titleText}",
                            // overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: IColors.black45),
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

    super.dispose();
  }

  void _getArguments() {
    shohada_id = arguments['shohada_id'];
  }

  void likeIconState() {
    if (iconState.icon == Icons.favorite_border) {
      _shohadaDetailsBloc.add(
          LikeShohada(user_id: GlobalWidget.user_id, shohada_id: shohada_id));
      setState(() {
        iconState = Icon(Icons.favorite, size: 30, color: IColors.white85);
      });
    } else {
      _shohadaDetailsBloc.add(DisLikeShohada(
          user_id: GlobalWidget.user_id, shohada_id: shohada_id));
      setState(() {
        iconState =
            Icon(Icons.favorite_border, size: 30, color: IColors.white85);
      });
    }
  }
}
