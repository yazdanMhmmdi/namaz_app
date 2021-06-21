import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:namaz_app/data/model/favorite_model.dart';
import 'package:namaz_app/data/repository/favorite_repository.dart';
import 'package:namaz_app/presentation/widget/ahkam_item.dart';
import 'package:namaz_app/presentation/widget/favorite_video_widget.dart';
import 'package:namaz_app/presentation/widget/marjae_large_item.dart';
import 'package:namaz_app/presentation/widget/marjae_small_item.dart';
import 'package:namaz_app/presentation/widget/narratives_item.dart';
import 'package:namaz_app/presentation/widget/shohada_item.dart';
import 'package:namaz_app/presentation/widget/videos_item.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc() : super(FavoriteInitial());
  FavoriteRepository _repository = new FavoriteRepository();
  FavoriteModel _model;

  @override
  Stream<FavoriteState> mapEventToState(
    FavoriteEvent event,
  ) async* {
    if (event is GetFavoriteItems) {
      try {
        yield FavoriteLoading();
        _model = await _repository.getFavoriteItems(event.user_id);
        if (_model.error == "0") {
          yield FavoriteSuccess(tab: Container());
        } else {
          yield FavoriteFailure();
        }
      } catch (err) {
        yield FavoriteFailure();
      }
    } else if (event is GetVideosFavorite) {
      if (_model.video.length == 0) {
        yield FavoriteIsEmpty();
      } else {
        yield FavoriteLoading();
        yield FavoriteSuccess(
          tab: Container(
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: 16),
              itemCount: _model.video.length,
              itemBuilder: (context, index) {
                return VideosItem(
                  onTap: () {},
                  deleteSlidable: true,
                  title: _model.video[index].title,
                  thumbnail: _model.video[index].thumbnail,
                );
              },
            ),
          ),
          favoriteModel: _model,
        );
      }
    } else if (event is GetAhkamFavorite) {
      if (_model.ahkam.length == 0) {
        yield FavoriteIsEmpty();
      } else {
        yield FavoriteLoading();
        yield FavoriteSuccess(
          tab: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: 16),
            itemCount: _model.ahkam.length,
            itemBuilder: (context, index) {
              return AhkamItem(
                id: _model.ahkam[index].ahkamId,
                onTap: () => Navigator.pushNamed(context, '/ahkam_show',
                    arguments: <String, String>{
                      "ahkam_id": _model.ahkam[index].ahkamId,
                    }),
                title: _model.ahkam[index].title,
                deleteSlidable: true,
              );
            },
          ),
          favoriteModel: _model,
        );
      }
    } else if (event is GetNarrativesFavorite) {
      if (_model.ahkam.length == 0) {
        yield FavoriteIsEmpty();
      } else {
        yield FavoriteLoading();
        yield FavoriteSuccess(
          tab: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: 16),
            itemCount: _model.narratives.length,
            itemBuilder: (context, index) {
              {
                return NarrativesItem(
                  id: _model.narratives[index].narrativesId,
                  subTitle: _model.narratives[index].quoteTranslation,
                  title: _model.narratives[index].quoteeTranslation,
                  deleteSlidable: true,
                );
              }
            },
          ),
          favoriteModel: _model,
        );
      }
    } else if (event is GetShohadaFavorite) {
      if (_model.ahkam.length == 0) {
        yield FavoriteIsEmpty();
      } else {
        yield FavoriteLoading();
        List<Widget> list = new List<Widget>();
        for (int i = 0; i < _model.shohadaBozorgan.length; i++) {
          list.add(Builder(builder: (context) {
            return ShohadaItem(
              onTap: () => Navigator.pushNamed(context, '/shohada_details',
                  arguments: <String, String>{
                    "shohada_id": _model.shohadaBozorgan[i].shohadaBozorganId,
                  }),
              title: _model.shohadaBozorgan[i].name,
              largePicture: _model.shohadaBozorgan[i].pictureSizeLarge,
            );
          }));
        }
        yield FavoriteSuccess(
          tab: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.end,
              textDirection: TextDirection.rtl,
              children: list,
            ),
          ),
          favoriteModel: _model,
        );
      }
    }
  }
}
