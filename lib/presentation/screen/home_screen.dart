import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motion_tab_bar/MotionTabBarView.dart';
import 'package:motion_tab_bar/MotionTabController.dart';
import 'package:motion_tab_bar/motiontabbar.dart';
import 'package:namaz_app/constants/colors.dart';
import 'package:namaz_app/constants/strings.dart';
import 'package:namaz_app/logic/bloc/home_bloc.dart';
import 'package:namaz_app/presentation/tab/favorite_tab.dart';
import 'package:namaz_app/presentation/tab/home_tab.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  MotionTabController _bottomNavController;
  bool bottomInternetStatus = true, bottomFailureStatus = true;

  @override
  void initState() {
    _bottomNavController =
        new MotionTabController(initialIndex: 0, vsync: this, length: 2);
    _bottomNavController.index = 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: IColors.lightBrown,
      body: Stack(
        children: [
          MotionTabBarView(controller: _bottomNavController, children: <Widget>[
            // ChatListTab(),

            // TitleTab(),
            FavoriteTab(),
            BlocProvider(
              create: (context) => HomeBloc(),
              child: HomeTab(),
            ),
          ]),
        ],
      ),
      bottomNavigationBar: bottomInternetStatus && bottomFailureStatus
          ? MotionTabBar(
              labels: [
                Strings.homeFavorite,
                Strings.home,
              ],
              initialSelectedTab: Strings.home,

              tabIconColor: Color(0xffA3A2A8),
              tabSelectedColor: IColors.brown, //TODO: needs to be replace
              onTabItemSelected: (int value) {
                print(value);
                setState(() {
                  _bottomNavController.index = value;
                });
              },
              icons: [
                // Icons.chat,
                Icons.favorite,

                Icons.home,
              ],
              textStyle: TextStyle(
                  color: Colors.black87,
                  fontFamily: "IranSans",
                  fontSize: 16,
                  fontWeight: FontWeight.w700),
            )
          : null,
    );
  }
}
