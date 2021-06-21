import 'package:namaz_app/data/model/ahkam_details_model.dart';
import 'package:namaz_app/data/model/ahkam_model.dart';
import 'package:namaz_app/data/model/like_ahkam_model.dart';
import 'package:namaz_app/data/model/narratives_model.dart';
import 'package:namaz_app/data/model/shohada_model.dart';
import 'package:namaz_app/networking/api_provider.dart';

class AhkamDetailsRepository {
  ApiProvider _apiProvider = new ApiProvider();

  Future<AhkamDetailsModel> getAhkamDetails(String ahkam_id, String user_id) async {
    final response = await _apiProvider
        .get('client_detail_ahkam_api.php?ahkam_id=${ahkam_id}&user_id=${user_id}');
    return AhkamDetailsModel.fromJson(response);
  }

  Future<LikeAhkamModel> likeAhkam(String ahkam_id, String user_id) async {
    final response = await _apiProvider.get(
        'client_like_ahkam_api.php?ahkam_id=${ahkam_id}&user_id=${user_id}');
    return LikeAhkamModel.fromJson(response);
  }

    Future<LikeAhkamModel> disLikeAhkam(String ahkam_id, String user_id) async {
    final response = await _apiProvider.get(
        'client_disLike_ahkam_api.php?ahkam_id=${ahkam_id}&user_id=${user_id}');
    return LikeAhkamModel.fromJson(response);
  }
}
