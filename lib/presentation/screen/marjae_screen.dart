import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:namaz_app/constants/colors.dart';
import 'package:namaz_app/constants/strings.dart';
import 'package:namaz_app/data/model/marjae_model.dart';
import 'package:namaz_app/logic/bloc/marjae_bloc.dart';
import 'package:namaz_app/networking/api_provider.dart';
import 'package:namaz_app/presentation/widget/loading_bar.dart';
import 'package:namaz_app/presentation/widget/marjae_large_item.dart';
import 'package:namaz_app/presentation/widget/videos_item.dart';

class MarjaeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: IColors.lightBrown,
      body: SafeArea(
        child: BlocBuilder<MarjaeBloc, MarjaeState>(
          builder: (context, state) {
            if (state is MarjaeInitial) {
              return Container();
            } else if (state is MarjaeLoading) {
              return LoadingBar();
            } else if (state is MarjaeSuccess) {
              List<Widget> list = new List<Widget>();
              for (int i = 0; i < state.marjaeModel.data.length; i++) {
                list.add(MarjaeLargeItem(
                    title: state.marjaeModel.data[i].name,
                    largePicture: ApiProvider.IMAGE_PROVIDER +
                        state.marjaeModel.data[i].pictureSizeLarge));
              }
              return SingleChildScrollView(
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 16,
                      ),
                      Center(
                        child: Text(
                          "${Strings.marjae}",
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
                            child: Wrap(
                              crossAxisAlignment: WrapCrossAlignment.end,
                              textDirection: TextDirection.rtl,
                              children: list,
                            )),
                      )
                    ],
                  ),
                ),
              );
            } else if (state is MarjaeFailure) {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
// MarjaeLargeItem(
//                           largePicture: largePicture,
//                         ),
