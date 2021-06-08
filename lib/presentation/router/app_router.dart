import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:namaz_app/logic/bloc/marjae_bloc.dart';
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

      default:
        return MaterialPageRoute(builder: (_) => IntroScreen());
    }
  }
}
