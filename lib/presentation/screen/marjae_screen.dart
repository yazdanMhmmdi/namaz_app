import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:namaz_app/constants/colors.dart';
import 'package:namaz_app/constants/strings.dart';
import 'package:namaz_app/data/model/marjae_model.dart';
import 'package:namaz_app/logic/bloc/dark_mode_bloc.dart';
import 'package:namaz_app/logic/bloc/marjae_bloc.dart';
import 'package:namaz_app/logic/cubit/internet_cubit.dart';
import 'package:namaz_app/networking/api_provider.dart';
import 'package:namaz_app/presentation/widget/back_button_widget.dart';
import 'package:namaz_app/presentation/widget/loading_bar.dart';
import 'package:namaz_app/presentation/widget/marjae_large_item.dart';
import 'package:namaz_app/presentation/widget/no_network_flare.dart';
import 'package:namaz_app/presentation/widget/server_failure_flare.dart';
import 'package:namaz_app/presentation/widget/videos_item.dart';

class MarjaeScreen extends StatefulWidget {
  @override
  _MarjaeScreenState createState() => _MarjaeScreenState();
}

class _MarjaeScreenState extends State<MarjaeScreen> {
  DarkModeBloc _darkModeBloc;
  bool _isDarkMode = false;
  @override
  void initState() {
    _darkModeBloc = BlocProvider.of<DarkModeBloc>(context);
    _darkModeBloc.add(GetDarkModeStatus());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DarkModeBloc, DarkModeState>(
      listener: (context, state) {
        darkModeStateFunction(state);
      },
      child: Scaffold(
        backgroundColor:
            _isDarkMode ? IColors.darkBackgroundColor : IColors.lightBrown,
        body: SafeArea(
            child: BlocConsumer<InternetCubit, InternetState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is InternetConnected) {
              return BlocBuilder<MarjaeBloc, MarjaeState>(
                builder: (context, state) {
                  if (state is MarjaeInitial) {
                    return Container();
                  } else if (state is MarjaeLoading) {
                    return LoadingBar(
                        color: _isDarkMode
                            ? IColors.darkLightPink
                            : IColors.purpleCrimson);
                  } else if (state is MarjaeSuccess) {
                    List<Widget> list = new List<Widget>();
                    for (int i = 0; i < state.marjaeModel.data.length; i++) {
                      list.add(MarjaeLargeItem(
                          isDarkMode: _isDarkMode,
                          marjae_id: state.marjaeModel.data[i].id,
                          title: state.marjaeModel.data[i].name,
                          hash: state.marjaeModel.data[i].blurhash,
                          largePicture:
                              state.marjaeModel.data[i].pictureSizeLarge));
                    }
                    return SingleChildScrollView(
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 16, right: 16, left: 16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  BackButtonWidget(
                                      onTap: () => Navigator.pop(context)),
                                  Text(
                                    "${Strings.marjae}",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      color: _isDarkMode
                                          ? IColors.darkWhite70
                                          : IColors.black70,
                                    ),
                                  ),
                                  Container(
                                    width: 25,
                                    height: 25,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 16),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Align(
                                  alignment: Alignment.topRight,
                                  child: Wrap(
                                    crossAxisAlignment: WrapCrossAlignment.end,
                                    textDirection: TextDirection.rtl,
                                    children: list,
                                  )),
                            )
                          ],
                        ),
                      ),
                    );
                  } else if (state is MarjaeFailure) {
                    return ServerFailureFlare(
                      errrorMessage: state.errrorMessage,
                    );
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

  void darkModeStateFunction(DarkModeState state) {
    if (state is DarkModeInitial) {
      setState(() {
        _isDarkMode = state.isDark;
      });
    }
    if (state is DarkModeEnable) {
      setState(() {
        _isDarkMode = state.isDark;
      });
    } else if (state is DarkModeDisable) {
      setState(() {
        _isDarkMode = state.isDark;
      });
    }
  }
}
// MarjaeLargeItem(
//                           largePicture: largePicture,
//                         ),
