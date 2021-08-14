import 'dart:convert';
import 'dart:typed_data';
import 'package:blurhash_dart/blurhash_dart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:namaz_app/networking/api_provider.dart';
import 'package:image/image.dart' as img;

class GlobalWidget {
  static String user_id = "1";
  static int tabNumber = 1;

  static Future<String> blurHashEncode(String imageAddress) async {
    try {
      http.Response response =
          await http.get(Uri.parse(ApiProvider.IMAGE_PROVIDER + imageAddress));
      final image = img.decodeImage(response.bodyBytes);

      BlurHash blurHash = BlurHash.encode(image, numCompX: 4, numCompY: 3);
      return blurHash.hash;
    } catch (err) {
      print(err.toString());
    }
  }
}
