import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:namaz_app/data/model/video_model.dart';
import 'package:namaz_app/data/repository/video_repository.dart';

part 'video_event.dart';
part 'video_state.dart';

class VideoBloc extends Bloc<VideoEvent, VideoState> {
  VideoBloc() : super(VideoInitial());
  VideoRepository _repository = new VideoRepository();
  VideoModel _model;
  int page = 1;
  int totalPage;
  @override
  Stream<VideoState> mapEventToState(
    VideoEvent event,
  ) async* {
    if (event is GetVideoItems) {
      try {
        if (page == 1) {
          yield VideoLoading();

          _model = await _repository.getVideoItems(page.toString(), event.search);
          if (_model.video.length == 0) {
          } else {
            totalPage = int.parse(_model.data.totalPages.toString());
            page++;
            yield VideoSuccess(videoModel: _model);
          }
        } else if (page <= totalPage) {
          yield VideoLazyLoading(videoModel: _model);
          VideoModel _tempModel =
              await _repository.getVideoItems(page.toString(), event.search);
          _tempModel.video.forEach((element) {
            _model.video.add(element);
          });
          page++;
          yield VideoSuccess(videoModel: _model);
        } else if (page > totalPage) {
          yield VideoListCompleted(videoModel: _model);
        }
      } catch (err) {
        yield VideoFailure();
      }
    } else if (event is SearchVideoItems) {
      try {
        page = 1;
        _model = new VideoModel();
        if (page == 1) {
          yield VideoSearchLoading();

          _model =
              await _repository.getVideoItems(page.toString(), event.search);
          if (_model.video.length == 0) {
            yield VideoSearchEmpty(videoModel: _model);
          } else {
            totalPage = int.parse(_model.data.totalPages.toString());
            page++;
            yield VideoSuccess(videoModel: _model);
          }
        } else if (page <= totalPage) {
          yield VideoSearchLoading();
          VideoModel _tempModel =
              await _repository.getVideoItems(page.toString(), event.search);
          _tempModel.video.forEach((element) {
            _model.video.add(element);
          });
          page++;
          yield VideoSuccess(videoModel: _model);
        } else if (page > totalPage) {
          yield VideoListCompleted(videoModel: _model);
        }
      } catch (err) {
        yield VideoFailure();
      }
    }
  }
}
