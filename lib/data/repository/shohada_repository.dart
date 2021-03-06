import 'package:namaz_app/data/model/home_model.dart';
import 'package:namaz_app/data/model/shohada_model.dart';
import 'package:namaz_app/networking/api_provider.dart';

class ShohadaRepository {
  ApiProvider _apiProvider = new ApiProvider();

  Future<ShohadaModel> getShohadaItems(String page, String search) async {
    final response = await _apiProvider
        .get('client_get_shohadaBozorgan_api.php?page=${page}&search=${search}');
    return ShohadaModel.fromJson(response);
  }
}
