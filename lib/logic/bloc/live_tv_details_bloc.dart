import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chewie/chewie.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:namaz_app/data/model/live_tv_details_model.dart';
import 'package:namaz_app/data/repository/live_tv_details_repository.dart';
import 'package:namaz_app/networking/api_provider.dart';
import 'package:namaz_app/presentation/widget/global_widget.dart';
import 'package:video_player/video_player.dart';

part 'live_tv_details_event.dart';
part 'live_tv_details_state.dart';

class LiveTvDetailsBloc extends Bloc<LiveTvDetailsEvent, LiveTvDetailsState> {
  LiveTvDetailsBloc() : super(LiveTvDetailsInitial());

  LiveTvDetailsRepository _repository = new LiveTvDetailsRepository();
  LiveTvDetailModel _model;
  VideoPlayerController videoPlayerController;
  ChewieController chewieController;

  @override
  Stream<LiveTvDetailsState> mapEventToState(
    LiveTvDetailsEvent event,
  ) async* {
    if (event is GetLiveTvDetails) {
      try {
        yield LiveTvDetailsLoading();
        _model = await _repository.getLiveTvDetails(event.liveTvId);
        if (_model.error == "0") {
          videoPlayerController = VideoPlayerController.network(
            _model.data.stream,
          );
          yield LiveTvDetailsLoading();

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

          yield LiveTvDetailsSuccess(
              liveTvDetailModel: _model, chewieController: chewieController);
        } else {
          yield LiveTvDetailsFailure();
        }
      } catch (err) {
        yield LiveTvDetailsFailure();
      }
    }
  }
}
