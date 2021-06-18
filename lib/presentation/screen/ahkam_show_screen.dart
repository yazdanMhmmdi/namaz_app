import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:namaz_app/constants/assets.dart';
import 'package:namaz_app/constants/colors.dart';
import 'package:namaz_app/logic/bloc/ahkam_details_bloc.dart';
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
  @override
  void initState() {
    arguments = widget.args;
    _getArguments();
    borderRadius = maxBorderRadius;

    _ahkamDetailsBloc = BlocProvider.of<AhkamDetailsBloc>(context);
    _ahkamDetailsBloc.add(GetAhkamDetails(ahkam_id: ahkam_id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: IColors.purpleCrimson,
        body: SafeArea(
          child: BlocBuilder<AhkamDetailsBloc, AhkamDetailsState>(
            builder: (context, state) {
              if (state is AhkamDetailsInitial) {
                return Container();
              } else if (state is AhkamDetailsLoading) {
                return LoadingBar(color: IColors.lightBrown);
              } else if (state is AhkamDetailsSuccess) {
                return Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 22, vertical: 22),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () => Navigator.pop(context),
                            icon: Icon(Icons.favorite_border,
                                size: 30, color: IColors.white85),
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
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 30, bottom: 16),
                                  child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: ListView(
                                      controller: scroll,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16),
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
                                                            color:
                                                                IColors.brown,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700)),
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
                                        Text(
                                          "${state.ahkamDetailsModel.data.titleText}",
                                          maxLines: null,
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: IColors.black70),
                                        )
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
              } else if (state is AhkamDetailsFailure) {
                return ServerFailureFlare();
              }
            },
          ),
        ));
  }

  void _getArguments() {
    ahkam_id = arguments['ahkam_id'];
  }
}
