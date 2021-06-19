import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flare_loading/flare_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:namaz_app/constants/assets.dart';
import 'package:namaz_app/constants/colors.dart';
import 'package:namaz_app/logic/bloc/shohada_details_bloc.dart';
import 'package:namaz_app/presentation/widget/loading_bar.dart';
import 'package:namaz_app/presentation/widget/server_failure_flare.dart';

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
    return Scaffold(
        backgroundColor: IColors.purpleCrimson,
        body: SafeArea(
          child: BlocBuilder<ShohadaDetailsBloc, ShohadaDetailsState>(
            builder: (context, state) {
              if (state is ShohadaDetailsInitial) {
                return Container();
              } else if (state is ShohadaDetailsLoading) {
                return LoadingBar();
              } else if (state is ShohadaDetailsSuccess) {
                return Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 22, vertical: 22),
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
                              icon: iconState,
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
                        borderRadius = notification.maxExtent <=
                                (notification.extent + 0.08)
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
                                        top: 30,
                                        right: 16,
                                        left: 16,
                                        bottom: 16),
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
                                                          fontWeight:
                                                              FontWeight.w700)),
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
                                                  fontSize: 14,
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
                                            fontSize: 14,
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
              } else if (state is ShohadaDetailsFailure) {
                return ServerFailureFlare();
              }
            },
          ),
        ));
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
      setState(() {
        iconState = Icon(Icons.favorite, size: 30, color: IColors.white85);
      });
    } else {
      setState(() {
        iconState =
            Icon(Icons.favorite_border, size: 30, color: IColors.white85);
      });
    }
  }
}
