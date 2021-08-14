import 'package:bloc/bloc.dart';
import 'package:blurhash_dart/blurhash_dart.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:namaz_app/networking/api_provider.dart';
import 'package:image/image.dart' as img;

part 'blur_hash_state.dart';

class BlurHashCubit extends Cubit<BlurHashState> {
  String imageAddress;
  BlurHashCubit(this.imageAddress) : super(BlurHashInitial()) {
    try {
      emit(BlurHashLoading());
      http
          .get(Uri.parse(ApiProvider.IMAGE_PROVIDER + imageAddress))
          .then((value) {
        http.Response response = value;
        final image = img.decodeImage(response.bodyBytes);

        BlurHash blurHash = BlurHash.encode(image, numCompX: 4, numCompY: 3);
        emit(BlurHashSuccess(hash: blurHash.hash));
      });
    } catch (err) {
      print(err.toString());
      emit(BlurHashFailure());
    }
  }
}
