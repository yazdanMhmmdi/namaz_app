import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:namaz_app/constants/assets.dart';
import 'package:namaz_app/constants/colors.dart';
import 'package:namaz_app/logic/bloc/narratives_details_bloc.dart';
import 'package:namaz_app/presentation/widget/back_button_widget.dart';
import 'package:namaz_app/presentation/widget/loading_bar.dart';
import 'package:namaz_app/presentation/widget/server_failure_flare.dart';

class NarrativesShowScreen extends StatelessWidget {
  Map<String, String> args;
  Map<String, String> arguments;
  String narratives_id;
  NarrativesDetailsBloc _narrativesDetailsBloc;
  final maxBorderRadius = 50.0;
  var borderRadius;
  NarrativesShowScreen({this.args});
  @override
  Widget build(BuildContext context) {
    arguments = args;
    _getArguments();
    borderRadius = maxBorderRadius;

    _narrativesDetailsBloc = BlocProvider.of<NarrativesDetailsBloc>(context);
    _narrativesDetailsBloc
        .add(GetNarrativesDetails(narratives_id: narratives_id));

    print(narratives_id);
    return Scaffold(
        backgroundColor: IColors.purpleCrimson,
        body: SafeArea(
          child: BlocBuilder<NarrativesDetailsBloc, NarrativesDetailsState>(
            builder: (context, state) {
              if (state is NarrativesDetailsInitial) {
                return Container();
              } else if (state is NarrativesDetailsLoading) {
                return LoadingBar(
                  color: IColors.lightBrown,
                );
              } else if (state is NarrativesDetailsSuccess) {
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
                                                width: 50,
                                                height: 50,
                                                child: Center(
                                                  child: Text(
                                                      '${state.narrativesDetailsModel.data.id}',
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: IColors.brown,
                                                          fontWeight:
                                                              FontWeight.w700)),
                                                ),
                                              ),
                                              Image.asset(
                                                Assets.largeShamse,
                                                width: 50,
                                                height: 50,
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Flexible(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Flexible(
                                                  child: Text(
                                                    "${state.narrativesDetailsModel.data.quotee}",
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: IColors.black70),
                                                  ),
                                                ),
                                                Flexible(
                                                  child: Text(
                                                    "${state.narrativesDetailsModel.data.quoteeTranslation}",
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: IColors.black70),
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        "${state.narrativesDetailsModel.data.quote}",
                                        // overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                            color: IColors.black45),
                                      ),
                                      SizedBox(
                                        height: 16,
                                      ),
                                      Text(
                                        "${state.narrativesDetailsModel.data.quoteTranslation}",
                                        // overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                            color: IColors.black45),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Row(
                                        children: [
                                          Flexible(
                                            child: Text(
                                              "منبع: ",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w700,
                                                  color: IColors.black70),
                                            ),
                                          ),
                                          Flexible(
                                            child: Text(
                                              "${state.narrativesDetailsModel.data.source}",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w700,
                                                  color: IColors.black70),
                                            ),
                                          ),
                                        ],
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
              } else if (state is NarrativesDetailsFailure) {
                return ServerFailureFlare();
              }
            },
          ),
        ));
  }

  void _getArguments() {
    narratives_id = arguments['narratives_id'];
  }
}
