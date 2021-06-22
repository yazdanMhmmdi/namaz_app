import 'package:namaz_app/data/model/shohada_details_model.dart';
import 'package:namaz_app/networking/api_provider.dart';

class ShohadaDetailsRepository {
  ApiProvider _apiProvider = new ApiProvider();

  Future<ShohadaDetailsModel> getShohadaDetails(
      String shohada_id, String user_id) async {
    final response = await _apiProvider.get(
        'client_detail_shohadaBozorgan_api.php?shohadaBozorgan_id=${shohada_id}&user_id=${user_id}');
    return ShohadaDetailsModel.fromJson(response);
  }

  Future<ShohadaDetailsModel> likeShohada(
      String shohada_id, String user_id) async {
    final response = await _apiProvider.get(
        'client_like_shohadaBozorgan_api.php?user_id=${user_id}&shohadaBozorgan_id=${shohada_id}');
    return ShohadaDetailsModel.fromJson(response);
  }

  Future<ShohadaDetailsModel> disLikeShohada(
      String shohada_id, String user_id) async {
    final response = await _apiProvider.get(
        'client_disLike_shohadaBozorgan_api.php?shohada_bozorgan_id=${shohada_id}&user_id=${user_id}');
    return ShohadaDetailsModel.fromJson(response);
  }
}
