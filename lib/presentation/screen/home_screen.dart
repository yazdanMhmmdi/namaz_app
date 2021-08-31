import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motion_tab_bar/MotionTabBarView.dart';
import 'package:motion_tab_bar/MotionTabController.dart';
import 'package:motion_tab_bar/motiontabbar.dart';
import 'package:namaz_app/constants/colors.dart';
import 'package:namaz_app/constants/strings.dart';
import 'package:namaz_app/logic/bloc/favorite_bloc.dart';
import 'package:namaz_app/logic/bloc/home_bloc.dart';
import 'package:namaz_app/logic/cubit/internet_cubit.dart';
import 'package:namaz_app/presentation/tab/favorite_tab.dart';
import 'package:namaz_app/presentation/tab/home_tab.dart';
import 'package:namaz_app/presentation/tab/settings_tab.dart';
import 'package:namaz_app/presentation/widget/no_network_flare.dart';
import 'package:namaz_app/presentation/widget/server_failure_flare.dart';

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
        new MotionTabController(initialIndex: 0, vsync: this, length: 3);
    _bottomNavController.index = 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),
        designSize: Size(360, 690),
        orientation: Orientation.portrait);
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is HomeFailure) {
          setState(() {
            bottomFailureStatus = false;
          });
        }
      },
      child: Scaffold(
        backgroundColor: IColors.lightBrown,
        body: BlocConsumer<InternetCubit, InternetState>(
          listener: (context, state) {
            if (state is InternetConnected) {
              setState(() {
                bottomInternetStatus = true;
              });
            } else if (state is InternetDisconnected) {
              setState(() {
                bottomInternetStatus = false;
              });
            }
          },
          builder: (context, state) {
            if (state is InternetConnected) {
              return getHomeScreenUI();
            } else if (state is InternetDisconnected) {
              return NoNetworkFlare();
            } else {
              bottomFailureStatus = false;
              return NoNetworkFlare();
            }
          },
        ),
        bottomNavigationBar: bottomInternetStatus && bottomFailureStatus
            ? MotionTabBar(
                labels: [Strings.homeFavorite, Strings.home, "تنظیمات"],
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
                  Icons.settings
                ],
                textStyle: TextStyle(
                    color: Colors.black87,
                    fontFamily: "IranSans",
                    fontSize: 16,
                    fontWeight: FontWeight.w700),
              )
            : null,
      ),
    );
  }

  Widget getHomeScreenUI() {
    return SafeArea(
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeFailure) {
            return ServerFailureFlare();
          } else {
            return Stack(
              children: [
                MotionTabBarView(
                    controller: _bottomNavController,
                    children: <Widget>[
                      // ChatListTab(),

                      // TitleTab(),
                      BlocProvider(
                          create: (context) => FavoriteBloc(),
                          child: FavoriteTab()),
                      BlocProvider.value(
                        value: BlocProvider.of<HomeBloc>(context),
                        child: HomeTab(),
                      ),

                      SettingsTab()
                    ]),
              ],
            );
          }
        },
      ),
    );
  }
}
