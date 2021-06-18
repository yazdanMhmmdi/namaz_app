import 'package:namaz_app/data/model/video_model.dart';
import 'package:namaz_app/networking/api_provider.dart';

class NarrativesRepository {
  ApiProvider _apiProvider = new ApiProvider();

  Future<VideoModel> getVideoItems(String page) async {
    final response = await _apiProvider
        .get('client_get_video_api.php?page=${page}');
    return VideoModel.fromJson(response);
  }
}
