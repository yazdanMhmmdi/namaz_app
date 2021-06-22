import 'package:namaz_app/data/model/like_narratives_model.dart';
import 'package:namaz_app/data/model/narratives_details_screen.dart';
import 'package:namaz_app/networking/api_provider.dart';

class NarrativesDetailsRepository {
  ApiProvider _apiProvider = new ApiProvider();

  Future<NarrativesDetailsModel> getNarrativesDetails(
      String narratives_id, String user_id) async {
    final response = await _apiProvider.get(
        'client_detail_narratives_api.php?narratives_id=${narratives_id}&user_id=${user_id}');
    return NarrativesDetailsModel.fromJson(response);
  }

  Future<LikeNarrativesModel> likeAhkam(
      String narratives_id, String user_id) async {
    final response = await _apiProvider.get(
        'client_like_narratives_api.php?narratives_id=${narratives_id}&user_id=${user_id}');
    return LikeNarrativesModel.fromJson(response);
  }

  Future<LikeNarrativesModel> disLikeAhkam(
      String narratives_id, String user_id) async {
    final response = await _apiProvider.get(
        'client_disLike_narratives_api.php?narratives_id=${narratives_id}&user_id=${user_id}');
    return LikeNarrativesModel.fromJson(response);
  }
}
