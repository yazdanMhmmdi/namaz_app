import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:namaz_app/logic/bloc/ahkam_bloc.dart';
import 'package:namaz_app/logic/bloc/ahkam_details_bloc.dart';
import 'package:namaz_app/logic/bloc/marjae_bloc.dart';
import 'package:namaz_app/logic/bloc/narratives_bloc.dart';
import 'package:namaz_app/logic/bloc/narratives_details_bloc.dart';
import 'package:namaz_app/logic/bloc/shohada_bloc.dart';
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
import 'package:namaz_app/presentation/screen/videos_screen.dart';

class AppRouter {
  Route onGeneratedRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case '/sign_up':
        return MaterialPageRoute(builder: (_) => SignUpScreen());
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
            builder: (_) => BlocProvider(
                create: (context) => NarrativesDetailsBloc(),
                child: NarrativesShowScreen(args: args)));
      case '/shohada_details':
        final Map<String, String> args = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (context) => NarrativesDetailsBloc(),
                child: ShohadaShowScreen(args: args)));

      default:
        return MaterialPageRoute(builder: (_) => IntroScreen());
    }
  }
}
