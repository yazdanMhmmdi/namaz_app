import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:namaz_app/constants/colors.dart';
import 'package:namaz_app/constants/strings.dart';
import 'package:namaz_app/logic/bloc/narratives_bloc.dart';
import 'package:namaz_app/logic/cubit/internet_cubit.dart';
import 'package:namaz_app/presentation/widget/back_button_widget.dart';
import 'package:namaz_app/presentation/widget/loading_bar.dart';
import 'package:namaz_app/presentation/widget/narratives_item.dart';
import 'package:namaz_app/presentation/widget/no_network_flare.dart';
import 'package:namaz_app/presentation/widget/server_failure_flare.dart';

class NarrativesScreen extends StatefulWidget {
  @override
  _NarrativesScreenState createState() => _NarrativesScreenState();
}

class _NarrativesScreenState extends State<NarrativesScreen> {
  NarrativesBloc _narrativesBloc;
  ScrollController _controller = ScrollController();
  bool lazyLoading = true;
  @override
  void initState() {
    _narrativesBloc = BlocProvider.of<NarrativesBloc>(context);
    _narrativesBloc.add(GetNarrativesList());
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        print('end of page');
        _narrativesBloc.add(GetNarrativesList());
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NarrativesBloc, NarrativesState>(
      listener: (context, state) {
        if (state is NarrativesLazyLoading) {
          lazyLoading = true;
        } else if (state is NarrativesSuccess) {
          lazyLoading = false;
        }
      },
      child: Scaffold(
        backgroundColor: IColors.lightBrown,
        body: SafeArea(
            child: BlocConsumer<InternetCubit, InternetState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is InternetConnected) {
              return BlocBuilder<NarrativesBloc, NarrativesState>(
                builder: (context, state) {
                  if (state is NarrativesInitial) {
                    return Container();
                  } else if (state is NarrativesLoading) {
                    return LoadingBar();
                  } else if (state is NarrativesLazyLoading) {
                    return narrativesUI(state);
                  } else if (state is NarrativesSuccess) {
                    return narrativesUI(state);
                  } else if (state is NarrativesListCompleted) {
                    lazyLoading = false;
                    return narrativesUI(state);
                  } else if (state is NarrativesFailure) {
                    return ServerFailureFlare();
                  }
                },
              );
            } else if (state is InternetDisconnected) {
              return NoNetworkFlare();
            } else {
              return Container();
            }
          },
        )),
      ),
    );
  }

  Widget narrativesUI(var state) {
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
                    "${Strings.narratives}",
                    style: TextStyle(
                      fontSize: 18,
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
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: state.narrativesModel.narratives.length,
                itemBuilder: (context, index) {
                  return NarrativesItem(
                    id: state.narrativesModel.narratives[index].id,
                    onTap: () => Navigator.pushNamed(
                        context, '/narratives_show',
                        arguments: <String, String>{
                          "narratives_id":
                              state.narrativesModel.narratives[index].id,
                        }),
                    deleteSlidable: false,
                    title: state
                        .narrativesModel.narratives[index].quoteeTranslation,
                    subTitle: state
                        .narrativesModel.narratives[index].quoteTranslation,
                  );
                },
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
