import 'package:namaz_app/data/model/favorite_model.dart';
import 'package:namaz_app/networking/api_provider.dart';

class FavoriteRepository {
  ApiProvider _apiProvider = new ApiProvider();

  Future<FavoriteModel> getFavoriteItems(String user_id) async {
    final response = await _apiProvider
        .get('client_get_favorite_api.php?user_id=${user_id}');
    return FavoriteModel.fromJson(response);
  }
}
