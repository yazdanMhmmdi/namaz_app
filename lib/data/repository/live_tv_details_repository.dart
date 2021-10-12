import 'package:namaz_app/data/model/live_tv_details_model.dart';
import 'package:namaz_app/networking/api_provider.dart';

class LiveTvDetailsRepository {
  ApiProvider _apiProvider = new ApiProvider();

  Future<LiveTvDetailModel> getLiveTvDetails(String live_tv_id) async {
    final response = await _apiProvider
        .get('client_detail_live_tv.php?live_tv_id=${live_tv_id}');
    return LiveTvDetailModel.fromJson(response);
  }
}
