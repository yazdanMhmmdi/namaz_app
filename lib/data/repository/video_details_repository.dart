import 'package:namaz_app/data/model/ahkam_details_model.dart';
import 'package:namaz_app/data/model/ahkam_model.dart';
import 'package:namaz_app/data/model/like_ahkam_model.dart';
import 'package:namaz_app/data/model/narratives_model.dart';
import 'package:namaz_app/data/model/shohada_model.dart';
import 'package:namaz_app/data/model/video_details_model.dart';
import 'package:namaz_app/networking/api_provider.dart';

class VideoDetailsRepository {
  ApiProvider _apiProvider = new ApiProvider();

  Future<VideoDetailsModel> getVideoDetails(String video_id, String user_id) async {
    final response = await _apiProvider
        .get('client_detail_video_api.php?video_id=${video_id}&user_id=${user_id}');
    return VideoDetailsModel.fromJson(response);
  }

  Future<VideoDetailsModel> likeVideo(String video_id, String user_id) async {
    final response = await _apiProvider.get(
        'client_disLike_video_api.php?user_id=${user_id}&video_id=${video_id}');
    return VideoDetailsModel.fromJson(response);
  }

    Future<VideoDetailsModel> disLikeVideo(String video_id, String user_id) async {
    final response = await _apiProvider.get(
        'client_disLike_video_api.php?user_id=${user_id}&video_id=${video_id}');
    return VideoDetailsModel.fromJson(response);
  }
}
