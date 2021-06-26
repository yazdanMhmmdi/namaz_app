import 'package:namaz_app/data/model/delete_favorites_model.dart';
import 'package:namaz_app/data/model/favorite_model.dart';
import 'package:namaz_app/networking/api_provider.dart';

class FavoriteRepository {
  ApiProvider _apiProvider = new ApiProvider();

  Future<FavoriteModel> getFavoriteItems(String user_id) async {
    final response = await _apiProvider
        .get('client_get_favorite_api.php?user_id=${user_id}');
    return FavoriteModel.fromJson(response);
  }

  Future<DeleteFavoritesModel> deleteVideoItems(
      String user_id, String video_id) async {
    final response = await _apiProvider.get(
        'client_disLike_video_api.php?user_id=${user_id}&video_id=${video_id}');
    return DeleteFavoritesModel.fromJson(response);
  }

  Future<DeleteFavoritesModel> deleteAhkamItems(
      String user_id, String ahkam_id) async {
    final response = await _apiProvider.get(
        'client_disLike_ahkam_api.php?ahkam_id=${ahkam_id}&user_id=${user_id}');
    return DeleteFavoritesModel.fromJson(response);
  }

  Future<DeleteFavoritesModel> deleteNarrativesItems(
      String user_id, String narratives_id) async {
    final response = await _apiProvider.get(
        'client_disLike_narratives_api.php?narratives_id=${narratives_id}&user_id=${user_id}');
    return DeleteFavoritesModel.fromJson(response);
  }

  Future<DeleteFavoritesModel> deleteShohadaItems(
      String user_id, String shohada_bozorgan_id) async {
    final response = await _apiProvider.get(
        'client_disLike_shohadaBozorgan_api.php?shohada_bozorgan_id=${shohada_bozorgan_id}&user_id=${user_id}');
    return DeleteFavoritesModel.fromJson(response);
  }
}
