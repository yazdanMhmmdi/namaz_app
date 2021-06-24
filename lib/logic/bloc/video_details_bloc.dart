import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chewie/chewie.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:namaz_app/data/model/video_details_model.dart';
import 'package:namaz_app/data/repository/video_details_repository.dart';
import 'package:namaz_app/networking/api_provider.dart';
import 'package:namaz_app/presentation/widget/global_widget.dart';
import 'package:video_player/video_player.dart';

part 'video_details_event.dart';
part 'video_details_state.dart';

class VideoDetailsBloc extends Bloc<VideoDetailsEvent, VideoDetailsState> {
  VideoDetailsBloc() : super(VideoDetailsInitial());
  VideoDetailsRepository _repository = new VideoDetailsRepository();
  String liked = "false";
  VideoDetailsModel _model;
  VideoPlayerController videoPlayerController;
  ChewieController chewieController;
  @override
  Stream<VideoDetailsState> mapEventToState(
    VideoDetailsEvent event,
  ) async* {
    if (event is GetVideoDetails) {
      try {
        yield VideoDetailsLoading();
        _model = await _repository.getVideoDetails(
            event.video_id, GlobalWidget.user_id);
        if (_model.error == "0") {
          liked = _model.data.liked.toString();
          videoPlayerController = VideoPlayerController.network(
            ApiProvider.VIDEO_PROVIDER + _model.data.video,
          );
          yield VideoDetailsLoading();

          chewieController = ChewieController(
            videoPlayerController: videoPlayerController,
            autoPlay: true,
            looping: true,
            showOptions: false,
            allowFullScreen:
                false, // in 20 june there is no fix for it so this should be false.
                
          );
          await videoPlayerController.initialize();
          // await videoPlayerController.
          await videoPlayerController.play();

          yield VideoDetailsSuccess(
              videoDetailsModel: _model,
              liked: liked,
              chewieController: chewieController);
        } else {
          yield VideoDetailsFailure();
        }
      } catch (err) {
        yield VideoDetailsFailure();
      }
    } else if (event is LikeVideo) {
      try {
        await _repository.likeVideo(event.video_id, event.user_id);
        if (_model.error == "0") {
          liked = "true";
          yield LikeSuccess(
              videoDetailsModel: _model,
              liked: liked,
              chewieController: chewieController);
        } else {
          // yield LikeAhkamFailure();
        }
      } catch (err) {
        // yield LikeAhkamFailure();
      }
    } else if (event is DisLikeVideo) {
      try {
        var res = await _repository.disLikeVideo(event.video_id, event.user_id);
        if (_model.error == "0") {
          liked = "false";
          yield LikeSuccess(
            videoDetailsModel: _model,
            liked: liked,
            chewieController: chewieController,
          );
        } else {
          // yield LikeAhkamFailure();
        }
      } catch (err) {
        // yield LikeAhkamFailure();
      }
    }
  }

  void intilize() async {}
}
