import 'package:feature_discovery/feature_discovery.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:namaz_app/constants/assets.dart';
import 'package:namaz_app/constants/strings.dart';
import 'package:namaz_app/presentation/router/app_router.dart';
import 'package:namaz_app/presentation/screen/intro_screen.dart';
import 'package:namaz_app/presentation/screen/sign_up_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AppRouter _appRouter = new AppRouter();

  @override
  Widget build(BuildContext context) {
    return FeatureDiscovery(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: Assets.basicFont,
          canvasColor: Colors.transparent,
        ),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: _appRouter.onGeneratedRoute,
      ),
    );
  }
}
