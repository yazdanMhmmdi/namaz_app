import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:namaz_app/constants/colors.dart';
import 'package:namaz_app/constants/strings.dart';
import 'package:namaz_app/logic/bloc/narratives_bloc.dart';
import 'package:namaz_app/logic/cubit/internet_cubit.dart';
import 'package:namaz_app/presentation/widget/back_button_widget.dart';
import 'package:namaz_app/presentation/widget/loading_bar.dart';
import 'package:namaz_app/presentation/widget/narratives_item.dart';
import 'package:namaz_app/presentation/widget/no_network_flare.dart';
import 'package:namaz_app/presentation/widget/search_button_widget.dart';
import 'package:namaz_app/presentation/widget/search_field_widget.dart';
import 'package:namaz_app/presentation/widget/server_failure_flare.dart';

class NarrativesScreen extends StatefulWidget {
  @override
  _NarrativesScreenState createState() => _NarrativesScreenState();
}

class _NarrativesScreenState extends State<NarrativesScreen>
    with SingleTickerProviderStateMixin {
  NarrativesBloc _narrativesBloc;
  ScrollController _controller = ScrollController();
  bool lazyLoading = true;
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
    _narrativesBloc = BlocProvider.of<NarrativesBloc>(context);
    _narrativesBloc.add(GetNarrativesList(search: ""));
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        print('end of page');
        _narrativesBloc
            .add(GetNarrativesList(search: searchTextController.text));
      }
    });
    super.initState();
    searchFieldAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NarrativesBloc, NarrativesState>(
      listener: (context, state) {
        if (state is NarrativesLazyLoading) {
          lazyLoading = true;
        } else if (state is NarrativesSuccess) {
          lazyLoading = false;
        }
      },
      child: Scaffold(
        backgroundColor: IColors.lightBrown,
        body: SafeArea(
            child: BlocConsumer<InternetCubit, InternetState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is InternetConnected) {
              return BlocBuilder<NarrativesBloc, NarrativesState>(
                builder: (context, state) {
                  if (state is NarrativesInitial) {
                    return Container();
                  } else if (state is NarrativesLoading) {
                    emptyList = false;
                    return LoadingBar();
                  } else if (state is NarrativesLazyLoading) {
                    return narrativesUI(state);
                  } else if (state is NarrativesSuccess) {
                    emptyList = false;
                    searchLoading = false;
                    return narrativesUI(state);
                  } else if (state is NarrativesListCompleted) {
                    lazyLoading = false;
                    return narrativesUI(state);
                  } else if (state is NarrativesSearchEmpty) {
                    lazyLoading = false;
                    searchLoading = false;
                    emptyList = true;
                    return narrativesUI(state);
                  } else if (state is NarrativesSearchLoading) {
                    searchLoading = true;
                    emptyList = false;
                    lazyLoading = false;
                    return narrativesUI(state);
                  } else if (state is NarrativesFailure) {
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
      ),
    );
  }

  Widget narrativesUI(var state) {
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
                  Text(
                    "${Strings.narratives}",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: IColors.black70,
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
                ],
              ),
            ),
            SizedBox(height: 8),
            SearchFieldWidget(
                isForward: isForward,
                animation: animation,
                searchTextController: searchTextController,
                onChanged: (text) {
                  print("searched text: ${text}");
                  _narrativesBloc.add(SearchNarrativesItems(search: text));
                }),
            SizedBox(height: 16),
            !emptyList
                ? searchLoading
                    ? Container(
                        height: MediaQuery.of(context).size.height - 180,
                        child: LoadingBar())
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: state.narrativesModel.narratives.length,
                          itemBuilder: (context, index) {
                            return NarrativesItem(
                              id: state.narrativesModel.narratives[index].id,
                              searchedText: searchTextController.text,
                              onTap: () => Navigator.pushNamed(
                                  context, '/narratives_show',
                                  arguments: <String, String>{
                                    "narratives_id": state
                                        .narrativesModel.narratives[index].id,
                                  }),
                              deleteSlidable: false,
                              title: state.narrativesModel.narratives[index]
                                  .quoteeTranslation,
                              subTitle: state.narrativesModel.narratives[index]
                                  .quoteTranslation,
                            );
                          },
                        ),
                      )
                : Container(
                    height: MediaQuery.of(context).size.height - 180,
                    child: Center(
                        child: Text(
                      "نتیجه ای یافت نشد",
                      style: TextStyle(color: IColors.black45),
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

  void searchFieldAnimation() {
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
}
