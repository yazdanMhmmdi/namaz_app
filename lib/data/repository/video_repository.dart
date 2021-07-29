import 'package:namaz_app/data/model/video_model.dart';
import 'package:namaz_app/networking/api_provider.dart';

class VideoRepository {
  ApiProvider _apiProvider = new ApiProvider();

  Future<VideoModel> getVideoItems(String page, String search) async {
    final response = await _apiProvider
        .get('client_get_video_api.php?page=${page}&search=${search}');
    return VideoModel.fromJson(response);
  }
}
