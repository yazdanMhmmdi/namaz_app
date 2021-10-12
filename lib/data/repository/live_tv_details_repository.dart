import 'package:namaz_app/data/model/live_tv_details_model.dart';
import 'package:namaz_app/networking/api_provider.dart';

class LiveTvDetailsRepository {
  ApiProvider _apiProvider = new ApiProvider();

  Future<LiveTvDetailModel> getVideoDetails(
      String live_tv_id, String user_id) async {
    final response = await _apiProvider.get(
        'client_detail_live_tv.php?video_id=${live_tv_id}&user_id=${user_id}');
    return LiveTvDetailModel.fromJson(response);
  }
}
