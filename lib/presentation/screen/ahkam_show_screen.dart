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
  @override
  void initState() {
    arguments = widget.args;
    _getArguments();
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
                    DraggableScrollableSheet(
                        initialChildSize: 0.7,
                        minChildSize: 0.7,
                        builder: (context, scroll) {
                          return ClipRRect(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(40),
                                topRight: Radius.circular(40)),
                            child: Container(
                              color: Colors.white,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 30, bottom: 16),
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
