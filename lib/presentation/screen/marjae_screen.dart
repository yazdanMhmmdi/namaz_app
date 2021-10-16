import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:namaz_app/constants/colors.dart';
import 'package:namaz_app/constants/strings.dart';
import 'package:namaz_app/data/model/marjae_model.dart';
import 'package:namaz_app/logic/bloc/theme_bloc.dart';
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
  ThemeBloc _themeBloc;
  bool _isDarkMode = false;
  double _fontSize = 0;
  @override
  void initState() {
    _themeBloc = BlocProvider.of<ThemeBloc>(context);
    _themeBloc.add(GetThemeStatus());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ThemeBloc, ThemeState>(
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
                          fontSize: _fontSize,
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
                                      fontSize: 18 + _fontSize,
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
                                  alignment: Alignment.topCenter,
                                  child: Wrap(
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    textDirection: TextDirection.rtl,
                                    children: list,
                                  )),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else if (state is MarjaeFailure) {
                    return ServerFailureFlare(
                      errrorMessage: state.errrorMessage,
                      isDarkMode: _isDarkMode,
                    );
                  }
                },
              );
            } else if (state is InternetDisconnected) {
              return NoNetworkFlare(
                isDarkMode: _isDarkMode,
              );
            } else {
              return Container();
            }
          },
        )),
      ),
    );
  }

  void darkModeStateFunction(ThemeState state) {
    if (state is ThemeInitial) {
      setState(() {
        _isDarkMode = state.isDark;
        _fontSize = state.fontSize;
      });
    }
    if (state is DarkModeEnable) {
      setState(() {
        _isDarkMode = state.isDark;
        _fontSize = state.fontSize;
      });
    } else if (state is DarkModeDisable) {
      setState(() {
        _isDarkMode = state.isDark;
        _fontSize = state.fontSize;
      });
    }
  }
}
// MarjaeLargeItem(
//                           largePicture: largePicture,
//                         ),
