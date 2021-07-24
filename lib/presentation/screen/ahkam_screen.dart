import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:namaz_app/constants/assets.dart';
import 'package:namaz_app/constants/colors.dart';
import 'package:namaz_app/constants/strings.dart';
import 'package:namaz_app/logic/bloc/ahkam_bloc.dart';
import 'package:namaz_app/logic/cubit/internet_cubit.dart';
import 'package:namaz_app/presentation/widget/ahkam_item.dart';
import 'package:namaz_app/presentation/widget/back_button_widget.dart';
import 'package:namaz_app/presentation/widget/loading_bar.dart';
import 'package:namaz_app/presentation/widget/marjae_large_item.dart';
import 'package:namaz_app/presentation/widget/no_network_flare.dart';
import 'package:namaz_app/presentation/widget/search_button_widget.dart';
import 'package:namaz_app/presentation/widget/server_failure_flare.dart';
import 'package:namaz_app/presentation/widget/shohada_item.dart';
import 'package:namaz_app/presentation/widget/videos_item.dart';

class AhkamScreen extends StatefulWidget {
  Map<String, String> args;
  AhkamScreen({this.args});

  @override
  _AhkamScreenState createState() => _AhkamScreenState();
}

class _AhkamScreenState extends State<AhkamScreen>
    with SingleTickerProviderStateMixin {
  ScrollController _controller = ScrollController();

  Map<String, String> arguments;
  String marjae_id;
  AhkamBloc _ahkamBloc;
  bool lazyLoading = true;
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
    arguments = widget.args;
    _getArguments();
    _ahkamBloc = BlocProvider.of<AhkamBloc>(context);
    _ahkamBloc.add(GetAhkamItems(marjae_id: marjae_id, search: ""));
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        print('end of page ${searchTextController.text}');
        _ahkamBloc.add(GetAhkamItems(
            marjae_id: marjae_id, search: searchTextController.text));
      }
    });
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    print(marjae_id);
    return Scaffold(
      backgroundColor: IColors.lightBrown,
      body: SafeArea(
          child: BlocConsumer<InternetCubit, InternetState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is InternetConnected) {
            return BlocBuilder<AhkamBloc, AhkamState>(
              builder: (context, state) {
                if (state is AhkamInitial) {
                  return Container();
                } else if (state is AhkamLoading) {
                  emptyList = false;
                  return LoadingBar();
                } else if (state is AhkamSuccess) {
                  emptyList = false;
                  searchLoading = false;
                  return getAhkamUI(state);
                } else if (state is AhkamLazyLoading) {
                  return getAhkamUI(state);
                } else if (state is AhkamListCompleted) {
                  lazyLoading = false;
                  return getAhkamUI(state);
                } else if (state is AhkamSearchEmpty) {
                  lazyLoading = false;
                  searchLoading = false;
                  emptyList = true;
                  return getAhkamUI(state);
                } else if (state is AhkamSearchLoading) {
                  searchLoading = true;
                  emptyList = false;
                  return getAhkamUI(state);
                } else if (state is AhkamFailure) {
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

  void _getArguments() {
    marjae_id = arguments['marjae_id'];
  }

  Widget getAhkamUI(var state) {
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
                      "${Strings.ahkam}",
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
                                  });
                                }
                              });
                            }),

                  // Container(
                  //   width: 25,
                  //   height: 25,
                  // ),
                ],
              ),
            ),
            SizedBox(height: 8),
            Visibility(
              visible: isForward,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  width: animation.value,
                  height: 45,
                  decoration: BoxDecoration(
                    color: IColors.black15,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextField(
                      keyboardType: TextInputType.text,
                      controller: searchTextController,
                      onChanged: (text) {
                        print("searched text: ${text}");
                        _ahkamBloc.add(SearchAhkamItems(
                            marjae_id: marjae_id, search: text));
                      },
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: Assets.basicFont,
                      ),
                      textDirection: TextDirection.rtl,
                      maxLines: 1,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: '${Strings.searchHint}',
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            !emptyList
                ? searchLoading
                    ? Container(
                        height: MediaQuery.of(context).size.height - 180,
                        child: LoadingBar())
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: state.ahkamModel.ahkam.length,
                            itemBuilder: (context, index) {
                              return AhkamItem(
                                title: state.ahkamModel.ahkam[index].title,
                                id: state.ahkamModel.ahkam[index].id,
                                deleteSlidable: false,
                                searchedText: "${searchTextController.text}",
                                onTap: () => Navigator.pushNamed(
                                    context, '/ahkam_show',
                                    arguments: <String, String>{
                                      'ahkam_id':
                                          state.ahkamModel.ahkam[index].id,
                                    }),
                              );
                            },
                          ),
                        ),
                      )
                : Container(
                    height: MediaQuery.of(context).size.height - 180,
                    child: Center(child: Text("نتیجه ای یافت نشد",
                    style: TextStyle(
                      color: IColors.black45
                    ),
                    ))),
            SizedBox(
              height: 8,
            ),
            lazyLoading ? LoadingBar() : Container(),
            SizedBox(
              height: 8,
            ),
          ],
        ),
      ),
    );
  }
}
