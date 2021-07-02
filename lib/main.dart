import 'package:feature_discovery/feature_discovery.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:namaz_app/constants/assets.dart';
import 'package:namaz_app/constants/colors.dart';
import 'package:namaz_app/constants/strings.dart';
import 'package:namaz_app/presentation/router/app_router.dart';
import 'package:namaz_app/presentation/screen/intro_screen.dart';
import 'package:namaz_app/presentation/screen/sign_up_screen.dart';

void main() {
  WidgetsFlutterBinding
      .ensureInitialized(); //connectivity_plus package dependency on
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
          primarySwatch: createMaterialColor(IColors.purpleCrimson),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: Assets.basicFont,
          canvasColor: Colors.transparent,
        ),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: _appRouter.onGeneratedRoute,
      ),
    );
  }

  MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    final swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    strengths.forEach((strength) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    });
    return MaterialColor(color.value, swatch);
  }
}
