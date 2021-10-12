import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:feature_discovery/feature_discovery.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:namaz_app/logic/bloc/ahkam_bloc.dart';
import 'package:namaz_app/logic/bloc/ahkam_details_bloc.dart';
import 'package:namaz_app/logic/bloc/live_tv_details_bloc.dart';
import 'package:namaz_app/logic/bloc/showcase_bloc.dart';
import 'package:namaz_app/logic/bloc/theme_bloc.dart';
import 'package:namaz_app/logic/bloc/home_bloc.dart';
import 'package:namaz_app/logic/bloc/marjae_bloc.dart';
import 'package:namaz_app/logic/bloc/narratives_bloc.dart';
import 'package:namaz_app/logic/bloc/narratives_details_bloc.dart';
import 'package:namaz_app/logic/bloc/shohada_bloc.dart';
import 'package:namaz_app/logic/bloc/shohada_details_bloc.dart';
import 'package:namaz_app/logic/bloc/sign_up_bloc.dart';
import 'package:namaz_app/logic/bloc/video_bloc.dart';
import 'package:namaz_app/logic/bloc/video_details_bloc.dart';
import 'package:namaz_app/logic/cubit/internet_cubit.dart';
import 'package:namaz_app/networking/api_provider.dart';
import 'package:namaz_app/presentation/screen/ahkam_screen.dart';
import 'package:namaz_app/presentation/screen/ahkam_show_screen.dart';
import 'package:namaz_app/presentation/screen/home_screen.dart';
import 'package:namaz_app/presentation/screen/intro_screen.dart';
import 'package:namaz_app/presentation/screen/live_tv_details_screen.dart';
import 'package:namaz_app/presentation/screen/marjae_screen.dart';
import 'package:namaz_app/presentation/screen/narratives_screen.dart';
import 'package:namaz_app/presentation/screen/narratives_show_screen.dart';
import 'package:namaz_app/presentation/screen/shohada_screen.dart';
import 'package:namaz_app/presentation/screen/shohada_show_screen.dart';
import 'package:namaz_app/presentation/screen/sign_up_screen.dart';
import 'package:namaz_app/presentation/screen/video_details_screen.dart';
import 'package:namaz_app/presentation/screen/videos_screen.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:url_launcher/url_launcher.dart';

class AppRouter {
  final InternetCubit _internetCubit =
      new InternetCubit(connectivity: Connectivity());
  ThemeBloc _themeBloc = new ThemeBloc();

  final _url = ApiProvider.VIDEO_PLAYER_PROVIDER;

  Route onGeneratedRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider.value(
                      value: _internetCubit,
                    ),
                    BlocProvider.value(
                      value: _themeBloc,
                    ),
                  ],
                  child: IntroScreen(),
                ));
      case '/home':
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: _themeBloc),
              BlocProvider.value(value: _internetCubit),
              BlocProvider(
                create: (context) => HomeBloc(),
              ),
              BlocProvider(
                create: (context) => ShowcaseBloc(),
              ),
            ],
            child: HomeScreen(),
          ),
        );
      case '/sign_up':
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider.value(
                      value: _internetCubit,
                    ),
                    BlocProvider.value(
                      value: _themeBloc,
                    ),
                    BlocProvider(create: (context) => SignUpBloc())
                  ],
                  child: SignUpScreen(),
                ));
      case '/marjae':
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (context) => MarjaeBloc()..add(GetMarjaeList()),
                    ),
                    BlocProvider.value(
                      value: _internetCubit,
                    ),
                    BlocProvider.value(
                      value: _themeBloc,
                    ),
                  ],
                  child: MarjaeScreen(),
                ));
      case '/shohada':
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider.value(
                      value: _internetCubit,
                    ),
                    BlocProvider.value(
                      value: _themeBloc,
                    ),
                    BlocProvider(
                      create: (context) => ShohadaBloc(),
                    )
                  ],
                  child: ShowCaseWidget(
                    autoPlay: false,
                    autoPlayDelay: Duration(seconds: 3),
                    autoPlayLockEnable: false,
                    builder: Builder(
                      builder: (context) => ShohadaScreen(),
                    ),
                  ),
                ));

      case '/narratives':
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider.value(
                      value: _internetCubit,
                    ),
                    BlocProvider.value(
                      value: _themeBloc,
                    ),
                    BlocProvider(
                      create: (context) => NarrativesBloc(),
                    )
                  ],
                  child: ShowCaseWidget(
                    autoPlay: false,
                    autoPlayDelay: Duration(seconds: 3),
                    autoPlayLockEnable: false,
                    builder: Builder(
                      builder: (context) => NarrativesScreen(),
                    ),
                  ),
                ));
      case '/ahkam':
        final Map<String, String> args = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider.value(
                      value: _internetCubit,
                    ),
                    BlocProvider.value(
                      value: _themeBloc,
                    ),
                    BlocProvider(
                      create: (context) => AhkamBloc(),
                    )
                  ],
                  child: ShowCaseWidget(
                    autoPlay: false,
                    autoPlayDelay: Duration(seconds: 3),
                    autoPlayLockEnable: false,
                    builder: Builder(
                      builder: (context) => AhkamScreen(args: args),
                    ),
                  ),
                ));
      case '/ahkam_show':
        final Map<String, String> args = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider.value(
                      value: _internetCubit,
                    ),
                    BlocProvider.value(
                      value: _themeBloc,
                    ),
                    BlocProvider(
                      create: (context) => AhkamDetailsBloc(),
                    ),
                  ],
                  child: ShowCaseWidget(
                    autoPlay: false,
                    autoPlayDelay: Duration(seconds: 3),
                    autoPlayLockEnable: false,
                    builder: Builder(
                      builder: (context) => AhkamShowScreen(args: args),
                    ),
                  ),
                ));

      case '/narratives_show':
        final Map<String, String> args = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => FeatureDiscovery.withProvider(
                  persistenceProvider: NoPersistenceProvider(),
                  child: MultiBlocProvider(
                    providers: [
                      BlocProvider.value(
                        value: _internetCubit,
                      ),
                      BlocProvider.value(
                        value: _themeBloc,
                      ),
                      BlocProvider(
                        create: (context) => NarrativesDetailsBloc(),
                      ),
                    ],
                    child: ShowCaseWidget(
                        autoPlay: false,
                        autoPlayDelay: Duration(seconds: 3),
                        autoPlayLockEnable: false,
                        builder: Builder(
                            builder: (context) =>
                                NarrativesShowScreen(args: args))),
                  ),
                ));
      case '/shohada_details':
        final Map<String, String> args = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider.value(
                      value: _internetCubit,
                    ),
                    BlocProvider.value(
                      value: _themeBloc,
                    ),
                    BlocProvider(
                      create: (context) => ShohadaDetailsBloc(),
                    )
                  ],
                  child: ShowCaseWidget(
                    autoPlay: false,
                    autoPlayDelay: Duration(seconds: 3),
                    autoPlayLockEnable: false,
                    builder: Builder(
                      builder: (context) => ShohadaShowScreen(args: args),
                    ),
                  ),
                ));
      case '/videos':
        final Map<String, String> args = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider.value(
                      value: _internetCubit,
                    ),
                    BlocProvider.value(
                      value: _themeBloc,
                    ),
                    BlocProvider(create: (cotnext) => VideoBloc())
                  ],
                  child: ShowCaseWidget(
                      autoPlay: false,
                      autoPlayDelay: Duration(seconds: 3),
                      autoPlayLockEnable: false,
                      builder: Builder(builder: (context) => VideosScreen())),
                ));
      case '/videos_details':
        final Map<String, String> args = settings.arguments;
        if (Platform.isWindows) _launchURL(args["video_id"]);
        return (Platform.isWindows)
            ? Container()
            : MaterialPageRoute(
                builder: (_) => MultiBlocProvider(
                      providers: [
                        BlocProvider(
                          create: (context) => VideoDetailsBloc(),
                        ),
                        BlocProvider.value(
                          value: _themeBloc,
                        )
                      ],
                      child: VideoDetailsScreen(
                        args: args,
                      ),
                    ));

      case '/live_tv_details':
        final Map<String, String> args = settings.arguments;
        // if (Platform.isWindows) _launchURL(args["video_id"]);
        return (Platform.isWindows)
            ? Container()
            : MaterialPageRoute(
                builder: (_) => MultiBlocProvider(
                      providers: [
                        BlocProvider(
                          create: (context) => LiveTvDetailsBloc(),
                        ),
                        BlocProvider.value(
                          value: _themeBloc,
                        )
                      ],
                      child: LiveTvDetailsScreen(
                        args: args,
                      ),
                    ));
      default:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                value: _internetCubit, child: IntroScreen()));
    }
  }

  void dispose() {
    _internetCubit.close();
  }

  void _launchURL(String video_id) async => await canLaunch(_url + video_id)
      ? await launch(_url + video_id)
      : throw 'Could not launch $_url';
}
