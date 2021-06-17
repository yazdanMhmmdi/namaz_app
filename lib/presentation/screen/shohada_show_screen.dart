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

class _ShohadaShowScreenState extends State<ShohadaShowScreen> {
  Map<String, String> arguments;
  String shohada_id;
  ShohadaDetailsBloc _shohadaDetailsBloc;
  @override
  void initState() {
    arguments = widget.args;
    _getArguments();
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
                        children: [
                          Icon(Icons.favorite_border,
                              size: 30, color: Colors.white)
                        ],
                      ),
                    ),
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
                                padding: const EdgeInsets.only(
                                    top: 30, right: 16, left: 16, bottom: 16),
                                child: Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: ListView(
                                    controller: scroll,
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
                            ),
                          );
                        }),
                  ],
                );
              } else if (state is ShohadaDetailsFailure) {
                return ServerFailureFlare();
              }
            },
          ),
        ));
  }

  void _getArguments() {
    shohada_id = arguments['shohada_id'];
  }
}
