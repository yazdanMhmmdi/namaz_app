import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:namaz_app/constants/assets.dart';
import 'package:namaz_app/constants/colors.dart';
import 'package:namaz_app/constants/strings.dart';
import 'package:namaz_app/logic/bloc/ahkam_bloc.dart';
import 'package:namaz_app/presentation/widget/ahkam_item.dart';
import 'package:namaz_app/presentation/widget/loading_bar.dart';
import 'package:namaz_app/presentation/widget/marjae_large_item.dart';
import 'package:namaz_app/presentation/widget/server_failure_flare.dart';
import 'package:namaz_app/presentation/widget/shohada_item.dart';
import 'package:namaz_app/presentation/widget/videos_item.dart';

class AhkamScreen extends StatefulWidget {
  Map<String, String> args;

  AhkamScreen({this.args});

  @override
  _AhkamScreenState createState() => _AhkamScreenState();
}

class _AhkamScreenState extends State<AhkamScreen> {
  ScrollController _controller = ScrollController();

  Map<String, String> arguments;
  String marjae_id;
  AhkamBloc _ahkamBloc;
  bool lazyLoading = true;
  @override
  void initState() {
    arguments = widget.args;
    _getArguments();
    _ahkamBloc = BlocProvider.of<AhkamBloc>(context);
    _ahkamBloc.add(GetAhkamItems(marjae_id: marjae_id));
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        print('end of page');
        _ahkamBloc.add(GetAhkamItems(marjae_id: marjae_id));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(marjae_id);
    return Scaffold(
      backgroundColor: IColors.lightBrown,
      body: SafeArea(
        child: BlocBuilder<AhkamBloc, AhkamState>(
          builder: (context, state) {
            if (state is AhkamInitial) {
              return Container();
            } else if (state is AhkamLoading) {
              return LoadingBar();
            } else if (state is AhkamSuccess) {
              return getAhkamUI(state);
            } else if (state is AhkamLazyLoading) {
              return getAhkamUI(state);
            } else if (state is AhkamListCompleted) {
              lazyLoading = false;
              return getAhkamUI(state);
            } else if (state is AhkamFailure) {
              return ServerFailureFlare();
            }
          },
        ),
      ),
    );
  }

  void _getArguments() {
    marjae_id = arguments['marjae_id'];
  }

  Widget getAhkamUI(var state) {
    return SingleChildScrollView(
      controller: _controller,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          children: [
            SizedBox(
              height: 16,
            ),
            Center(
              child: Text(
                "این یک متن موقتی است",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: IColors.black70,
                ),
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.topRight,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: state.ahkamModel.ahkam.length,
                  itemBuilder: (context, index) {
                    return AhkamItem(
                      title: state.ahkamModel.ahkam[index].title,
                      id: state.ahkamModel.ahkam[index].id,
                      deleteSlidable: false,
                    );
                  },
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            lazyLoading ? LoadingBar() : Container(),
            SizedBox(
              height: 8,
            ),
          ],
        ),
      ),
    );
  }
}
