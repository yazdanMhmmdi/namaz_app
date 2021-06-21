import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:namaz_app/constants/colors.dart';
import 'package:namaz_app/constants/strings.dart';
import 'package:namaz_app/logic/bloc/shohada_bloc.dart';
import 'package:namaz_app/networking/api_provider.dart';
import 'package:namaz_app/presentation/widget/back_button_widget.dart';
import 'package:namaz_app/presentation/widget/loading_bar.dart';
import 'package:namaz_app/presentation/widget/marjae_large_item.dart';
import 'package:namaz_app/presentation/widget/my_tool_bar_text.dart';
import 'package:namaz_app/presentation/widget/server_failure_flare.dart';
import 'package:namaz_app/presentation/widget/shohada_item.dart';
import 'package:namaz_app/presentation/widget/videos_item.dart';

class ShohadaScreen extends StatefulWidget {
  @override
  _ShohadaScreenState createState() => _ShohadaScreenState();
}

class _ShohadaScreenState extends State<ShohadaScreen> {
  ShohadaBloc _shohadaBloc;
  ScrollController _controller = ScrollController();
  bool lazyLoading = true;
  @override
  void initState() {
    _shohadaBloc = BlocProvider.of<ShohadaBloc>(context);
    _shohadaBloc.add(GetShohadaList());
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        print('end of page');
        _shohadaBloc.add(GetShohadaList());
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ShohadaBloc, ShohadaState>(
      listener: (context, state) {
        if (state is ShohadaLazyLoading) {
          lazyLoading = true;
        } else if (state is ShohadaSuccess) {
          lazyLoading = false;
        }
      },
      child: Scaffold(
        backgroundColor: IColors.lightBrown,
        body: SafeArea(
          child: BlocBuilder<ShohadaBloc, ShohadaState>(
            builder: (context, state) {
              if (state is ShohadaLoading) {
                return LoadingBar();
              } else if (state is ShohadaSuccess) {
                return shohadaUI(state);
              } else if (state is ShohadaLazyLoading) {
                return shohadaUI(state);
              } else if (state is ShohadaFailure) {
                return ServerFailureFlare();
              } else if (state is ShohadaInitial) {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget shohadaUI(var state) {
    List<Widget> list = new List<Widget>();
    for (int i = 0; i < state.shohadaModel.shohadaBozorgan.length; i++) {
      list.add(ShohadaItem(
        onTap: () => Navigator.pushNamed(context, '/shohada_details',
            arguments: <String, String>{
              "shohada_id": state.shohadaModel.shohadaBozorgan[i].id,
            }),
        title: state.shohadaModel.shohadaBozorgan[i].name,
        largePicture: 
            state.shohadaModel.shohadaBozorgan[i].pictureSizeLarge,
      ));
    }
    return SingleChildScrollView(
      controller: _controller,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16, right: 16, left: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BackButtonWidget(onTap: () => Navigator.pop(context)),
                  Text(
                    "${Strings.shohadaBozorgan}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: IColors.black70,
                    ),
                  ),
                  Container(
                    width: 25,
                    height: 25,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.topRight,
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.end,
                  textDirection: TextDirection.rtl,
                  children: list,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: lazyLoading ? LoadingBar() : Container(),
            ),
          ],
        ),
      ),
    );
  }
}
