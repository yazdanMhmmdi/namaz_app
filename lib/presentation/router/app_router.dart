import 'package:flutter/material.dart';
import 'package:namaz_app/presentation/screen/ahkam_screen.dart';
import 'package:namaz_app/presentation/screen/home_screen.dart';
import 'package:namaz_app/presentation/screen/intro_screen.dart';
import 'package:namaz_app/presentation/screen/marjae_screen.dart';
import 'package:namaz_app/presentation/screen/narratives_screen.dart';
import 'package:namaz_app/presentation/screen/shohada_screen.dart';
import 'package:namaz_app/presentation/screen/sign_up_screen.dart';
import 'package:namaz_app/presentation/screen/videos_screen.dart';

class AppRouter {
  Route onGeneratedRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => AhkamScreen());
      case '/sign_up':
        return MaterialPageRoute(builder: (_) => SignUpScreen());

      default:
        return MaterialPageRoute(builder: (_) => IntroScreen());
    }
  }
}
