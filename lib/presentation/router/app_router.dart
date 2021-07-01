import 'package:feature_discovery/feature_discovery.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:namaz_app/logic/bloc/ahkam_bloc.dart';
import 'package:namaz_app/logic/bloc/ahkam_details_bloc.dart';
import 'package:namaz_app/logic/bloc/home_bloc.dart';
import 'package:namaz_app/logic/bloc/marjae_bloc.dart';
import 'package:namaz_app/logic/bloc/narratives_bloc.dart';
import 'package:namaz_app/logic/bloc/narratives_details_bloc.dart';
import 'package:namaz_app/logic/bloc/shohada_bloc.dart';
import 'package:namaz_app/logic/bloc/shohada_details_bloc.dart';
import 'package:namaz_app/logic/bloc/sign_up_bloc.dart';
import 'package:namaz_app/logic/bloc/video_bloc.dart';
import 'package:namaz_app/logic/bloc/video_details_bloc.dart';
import 'package:namaz_app/presentation/screen/ahkam_screen.dart';
import 'package:namaz_app/presentation/screen/ahkam_show_screen.dart';
import 'package:namaz_app/presentation/screen/favorite_screen.dart';
import 'package:namaz_app/presentation/screen/home_screen.dart';
import 'package:namaz_app/presentation/screen/intro_screen.dart';
import 'package:namaz_app/presentation/screen/marjae_screen.dart';
import 'package:namaz_app/presentation/screen/narratives_screen.dart';
import 'package:namaz_app/presentation/screen/narratives_show_screen.dart';
import 'package:namaz_app/presentation/screen/shohada_screen.dart';
import 'package:namaz_app/presentation/screen/shohada_show_screen.dart';
import 'package:namaz_app/presentation/screen/sign_up_screen.dart';
import 'package:namaz_app/presentation/screen/video_details_screen.dart';
import 'package:namaz_app/presentation/screen/videos_screen.dart';

class AppRouter {
  Route onGeneratedRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => IntroScreen());
      case '/home':
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (context) => HomeBloc(), child: HomeScreen()));
      case '/sign_up':
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (context) => SignUpBloc(), child: SignUpScreen()));
      case '/marjae':
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (context) => MarjaeBloc()..add(GetMarjaeList()),
                child: MarjaeScreen()));
      case '/shohada':
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (context) => ShohadaBloc()..add(GetShohadaList()),
                child: ShohadaScreen()));

      case '/narratives':
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (context) => NarrativesBloc(),
                child: NarrativesScreen()));
      case '/ahkam':
        final Map<String, String> args = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (context) => AhkamBloc(),
                child: AhkamScreen(args: args)));
      case '/ahkam_show':
        final Map<String, String> args = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (context) => AhkamDetailsBloc(),
                child: AhkamShowScreen(args: args)));

      case '/narratives_show':
        final Map<String, String> args = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => FeatureDiscovery.withProvider(
                  persistenceProvider: NoPersistenceProvider(),
                  child: BlocProvider(
                      create: (context) => NarrativesDetailsBloc(),
                      child: NarrativesShowScreen(args: args)),
                ));
      case '/shohada_details':
        final Map<String, String> args = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (context) => ShohadaDetailsBloc(),
                child: ShohadaShowScreen(args: args)));
      case '/videos':
        final Map<String, String> args = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (cotnext) => VideoBloc(), child: VideosScreen()));
      case '/videos_details':
        final Map<String, String> args = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (context) => VideoDetailsBloc(),
                child: VideoDetailsScreen(
                  args: args,
                )));
      default:
        return MaterialPageRoute(builder: (_) => IntroScreen());
    }
  }
}
