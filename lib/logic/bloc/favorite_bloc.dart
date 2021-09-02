import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:namaz_app/data/model/delete_favorites_model.dart';
import 'package:namaz_app/data/model/favorite_model.dart';
import 'package:namaz_app/data/repository/favorite_repository.dart';
import 'package:namaz_app/presentation/tab/favorite_tab.dart';
import 'package:namaz_app/presentation/widget/ahkam_item.dart';
import 'package:namaz_app/presentation/widget/empty_widget.dart';
import 'package:namaz_app/presentation/widget/favorite_video_widget.dart';
import 'package:namaz_app/presentation/widget/global_widget.dart';
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
        yield FavoriteIsEmpty(
            tab: EmptyWidget(
          isDarkMode: event.isDarkMode,
        ));
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
                  video_id: _model.video[index].videoId,
                  favoriteBloc: this,
                  blurhash: _model.video[index].blurhash,
                  isPinned: false,
                  isDarkMode: event.isDarkMode,
                  onTap: () => Navigator.pushNamed(context, '/videos_details',
                      arguments: <String, String>{
                        "video_id": _model.video[index].videoId,
                      }).then((value) {
                    this.add(GetFavoriteItems(
                      user_id: GlobalWidget.user_id,
                    ));
                    GlobalWidget.tabNumber = 1;
                  }),
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
        yield FavoriteIsEmpty(tab: EmptyWidget(isDarkMode: event.isDarkMode));
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
                favoriteBloc: this,
                ahkamNumber: _model.ahkam[index].ahkamNumber,
                onTap: () => Navigator.pushNamed(context, '/ahkam_show',
                    arguments: <String, String>{
                      "ahkam_id": _model.ahkam[index].ahkamId,
                      "prevScreen": "favorite",
                    }).then((value) {
                  this.add(GetFavoriteItems(user_id: GlobalWidget.user_id));
                  GlobalWidget.tabNumber = 2;
                }),
                title: _model.ahkam[index].title,
                deleteSlidable: true,
                isDarkMode: event.isDarkMode,
              );
            },
          ),
          favoriteModel: _model,
        );
      }
    } else if (event is GetNarrativesFavorite) {
      if (_model.narratives.length == 0) {
        yield FavoriteIsEmpty(
            tab: EmptyWidget(
          isDarkMode: event.isDarkMode,
        ));
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
                  favoriteBloc: this,
                  isDarkMode: event.isDarkMode,
                  onTap: () {
                    Navigator.pushNamed(context, '/narratives_show',
                        arguments: <String, String>{
                          "narratives_id":
                              _model.narratives[index].narrativesId,
                        }).then((value) {
                      this.add(GetFavoriteItems(user_id: GlobalWidget.user_id));
                      GlobalWidget.tabNumber = 3;
                    });
                  },
                );
              }
            },
          ),
          favoriteModel: _model,
        );
      }
    } else if (event is GetShohadaFavorite) {
      if (_model.shohadaBozorgan.length == 0) {
        yield FavoriteIsEmpty(
            tab: EmptyWidget(
          isDarkMode: event.isDarkMode,
        ));
      } else {
        yield FavoriteLoading();
        List<Widget> list = new List<Widget>();
        for (int i = 0; i < _model.shohadaBozorgan.length; i++) {
          list.add(Builder(builder: (context) {
            return ShohadaItem(
              deleteSlidable: true,
              isDarkMode: event.isDarkMode,
              hash: _model.shohadaBozorgan[i].blurhash,
              shohada_id: _model.shohadaBozorgan[i].shohadaBozorganId,
              favoriteBloc: this,
              // hash: _model.shohadaBozorgan[i].blurHash,
              onTap: () => Navigator.pushNamed(context, '/shohada_details',
                  arguments: <String, String>{
                    "shohada_id": _model.shohadaBozorgan[i].shohadaBozorganId,
                  }).then((value) {
                this.add(GetFavoriteItems(user_id: GlobalWidget.user_id));
                GlobalWidget.tabNumber = 4;
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
    } else if (event is DeleteVideoItem) {
      try {
        yield FavoriteLoading();
        DeleteFavoritesModel _favoritesModel =
            await _repository.deleteVideoItems(event.user_id, event.video_id);

        if (_favoritesModel.error == "0") {
          yield FavoriteSuccess(tab: Container());
        } else {
          yield FavoriteFailure();
        }
      } catch (err) {
        yield FavoriteFailure();
      }
    } else if (event is DeleteAhkamItem) {
      try {
        yield FavoriteLoading();
        DeleteFavoritesModel _favoritesModel =
            await _repository.deleteAhkamItems(event.user_id, event.ahkam_id);

        if (_favoritesModel.error == "0") {
          yield FavoriteSuccess(tab: Container());
        } else {
          yield FavoriteFailure();
        }
      } catch (err) {
        yield FavoriteFailure();
      }
    } else if (event is DeleteNarrativesItem) {
      try {
        yield FavoriteLoading();
        DeleteFavoritesModel _favoritesModel = await _repository
            .deleteNarrativesItems(event.user_id, event.narratives_id);

        if (_favoritesModel.error == "0") {
          yield FavoriteSuccess(tab: Container());
        } else {
          yield FavoriteFailure();
        }
      } catch (err) {
        yield FavoriteFailure();
      }
    } else if (event is DeleteShohadaItem) {
      try {
        yield FavoriteLoading();
        DeleteFavoritesModel _favoritesModel = await _repository
            .deleteShohadaItems(event.user_id, event.shohada_id);

        if (_favoritesModel.error == "0") {
          yield FavoriteSuccess(tab: Container());
        } else {
          yield FavoriteFailure();
        }
      } catch (err) {
        yield FavoriteFailure();
      }
    }
  }
}
