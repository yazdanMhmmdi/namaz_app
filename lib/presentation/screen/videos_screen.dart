import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:namaz_app/constants/colors.dart';
import 'package:namaz_app/constants/strings.dart';
import 'package:namaz_app/logic/bloc/video_bloc.dart';
import 'package:namaz_app/presentation/widget/loading_bar.dart';
import 'package:namaz_app/presentation/widget/narratives_item.dart';
import 'package:namaz_app/presentation/widget/server_failure_flare.dart';
import 'package:namaz_app/presentation/widget/video_item.dart';
import 'package:namaz_app/presentation/widget/videos_item.dart';

class VideosScreen extends StatefulWidget {
  @override
  _VideosScreenState createState() => _VideosScreenState();
}

class _VideosScreenState extends State<VideosScreen> {
  bool lazyLoading = true;
  ScrollController _controller = ScrollController();

  VideoBloc _videoBloc;

  @override
  void initState() {
    _videoBloc = BlocProvider.of<VideoBloc>(context);
    _videoBloc.add(GetVideoItems());
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        print('end of page');
        _videoBloc.add(GetVideoItems());
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: IColors.lightBrown,
      body: SafeArea(
        child: BlocBuilder<VideoBloc, VideoState>(
          builder: (context, state) {
            if (state is VideoInitial) {
              return Container();
            } else if (state is VideoLoading) {
              return LoadingBar();
            } else if (state is VideoLazyLoading) {
              return getVideoUI(state);
            } else if (state is VideoListCompleted) {
              lazyLoading = false;
              return getVideoUI(state);
            } else if (state is VideoSuccess) {
              return getVideoUI(state);
            } else if (state is VideoFailure) {
              return ServerFailureFlare();
            }
          },
        ),
      ),
    );
  }

  Widget getVideoUI(var state) {
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
                "${Strings.narratives}",
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
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: state.videoModel.video.length,
                itemBuilder: (contet, index) {
                  return VideosItem(
                      deleteSlidable: false,
                      title: state.videoModel.video[index].title,
                      thumbnail: state.videoModel.video[index].thumbnail);
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
