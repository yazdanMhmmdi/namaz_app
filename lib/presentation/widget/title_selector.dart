import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:namaz_app/constants/colors.dart';
import 'package:namaz_app/logic/bloc/favorite_bloc.dart';
import 'package:namaz_app/presentation/tab/favorite_tab.dart';
import 'package:namaz_app/presentation/widget/favorite_video_widget.dart';
import 'package:namaz_app/presentation/widget/global_widget.dart';

class TitleSelector extends StatefulWidget {
  List<String> titles = new List<String>();
  int firstTab = 2;
  bool isDarkMode = false;
  double fontSize = 0;
  TitleSelector(
      {@required this.titles,
      @required this.firstTab,
      @required this.fontSize,
      @required this.isDarkMode});
  @override
  _TitleSelectorState createState() => _TitleSelectorState();
}

/*
Container(
              height: 8,
              width: 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black87,
              ),
*/
class _TitleSelectorState extends State<TitleSelector> {
  int _currentIndex = 0;
  bool _isSelected;
  double _rightPadding = 30; //initial right padding
  int temp = 0;
  bool sience = true, medicine = true;
  FavoriteBloc _favoriteBloc;
  bool _isDarkMode;
  double _fontSize;
  final List<GlobalObjectKey<FormState>> formKeyList =
      List.generate(4, (index) => GlobalObjectKey<FormState>(index));
  List<double> titleSizes = List<double>();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(_afterLayout);

    _favoriteBloc = BlocProvider.of<FavoriteBloc>(context);
    _isDarkMode = widget.isDarkMode;
    _fontSize = widget.fontSize;
    widget.firstTab = widget.firstTab - 1;
    if (widget.firstTab == 0) {
      // widget.bloc.add(FetchBooks(widget.firstTab + 1)); TODO:
      _favoriteBloc
          .add(GetVideosFavorite(isDarkMode: _isDarkMode, fontSize: _fontSize));
    } else {
      onTapping(widget.firstTab);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        height: 43,
        child: ListView(scrollDirection: Axis.horizontal, children: <Widget>[
          Stack(
            children: [
              Row(
                children: _titleSelector(),
              ),
              AnimatedPositioned(
                  bottom: 2,
                  right: _rightPadding,
                  child: Container(
                    height: 8,
                    width: 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:
                          _isDarkMode ? IColors.darkLightPink : Colors.black87,
                    ),
                  ),
                  duration: Duration(milliseconds: 300))
            ],
          )
        ]),
      ),
    );
  }

  List<Widget> _titleSelector() {
    return widget.titles.map((e) {
      var index = widget.titles.indexOf(e);
      _isSelected = _currentIndex == index;
      return Padding(
        padding: EdgeInsets.only(left: 35),
        child: GestureDetector(
          onTap: () {
            if (temp != index) {
              onTapping(index);
            }

            // switch (blocIndex) {
            //   case 1:
            //     if (sience) {
            //       widget.bloc.add(FetchBooks(blocIndex));
            //       sience = false;
            //       print('bloc.add sience');
            //     }
            //     break;
            //   case 2:
            //     if (medicine) {
            //       widget.bloc.add(FetchBooks(blocIndex));
            //       medicine = false;
            //       print('bloc.add medicine');
            //     }
            //     break;
            // }
          },
          child: Container(
            color: Colors.transparent,
            key: formKeyList[index],
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AnimatedDefaultTextStyle(
                    duration: Duration(milliseconds: 300),
                    style: TextStyle(
                      color: _isSelected
                          ? _isDarkMode
                              ? IColors.darkLightPink
                              : Colors.black87
                          : Colors.grey,
                      fontSize: _isSelected
                          ? 22 + widget.fontSize
                          : 16 + widget.fontSize,
                      fontFamily: "IranSans",
                      fontWeight: FontWeight.w700,
                    ),
                    child: Text(
                      e,
                    ),
                  ),
                ]),
          ),
        ),
      );
    }).toList();
  }

  void onTapping(int index) {
    setState(() {
      GlobalWidget.tabNumber = index + 1;
      _currentIndex = index;
      print('cu : $_currentIndex and indx: $index temp = $temp');
      int c = index;
      print(c);

      switch (index) {
        case 0:
          _rightPadding = 30;
          break;
        case 1:
          _rightPadding = 130;
          break;
        case 2:
          _rightPadding = 240;
          break;
        case 3:
          _rightPadding = 350;
          break;
      }

      // if (temp > index) {
      //   c = temp - c;
      //   if (c <= 0) {
      //     _rightPadding -= 100; //increase and decrease right padding
      //   } else {
      //     _rightPadding =
      //         _rightPadding - (c * 100); //increase and decrease right padding
      //   }
      // } else {
      //   c = c - temp;
      //   print(c);
      //   if (c <= 0) {
      //     _rightPadding += 100; //increase and decrease right padding
      //   } else {
      //     _rightPadding =
      //         (c * 100) + _rightPadding; //increase and decrease right padding
      //   }
      // }
      temp = index;
      // TitleDetailsScreen.currentTab = _currentIndex.toString();
    });
    int blocIndex = _currentIndex + 1;

    print('index; ${blocIndex}');
    // widget.bloc.add(FetchBooks(blocIndex));TODO:
    if (blocIndex == 1) {
      _favoriteBloc
          .add(GetVideosFavorite(isDarkMode: _isDarkMode, fontSize: _fontSize));
    } else if (blocIndex == 2) {
      _favoriteBloc
          .add(GetAhkamFavorite(isDarkMode: _isDarkMode, fontSize: _fontSize));
    } else if (blocIndex == 3) {
      _favoriteBloc.add(
          GetNarrativesFavorite(isDarkMode: _isDarkMode, fontSize: _fontSize));
    } else if (blocIndex == 4) {
      _favoriteBloc.add(
          GetShohadaFavorite(isDarkMode: _isDarkMode, fontSize: _fontSize));
    }
  }

  Size _getSize(int index) {
    print("called index : ${index}");
    final RenderBox renderBoxRed =
        formKeyList[index].currentContext.findRenderObject();
    final sizeRed = renderBoxRed.size;
    print("SIZE of Red: $sizeRed");

    return sizeRed;
  }

  _afterLayout(_) {
    // _getSize(GlobalWidget.tabNumber - 1);
  }
}
