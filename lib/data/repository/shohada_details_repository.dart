import 'package:namaz_app/data/model/shohada_details_model.dart';
import 'package:namaz_app/networking/api_provider.dart';

class ShohadaDetailsRepository {
  ApiProvider _apiProvider = new ApiProvider();

  Future<ShohadaDetailsModel> getShohadaDetails(String shohada_id) async {
    final response = await _apiProvider.get(
        'client_detail_shohadaBozorgan_api.php?shahadaBozorgan_id=${shohada_id}');
    return ShohadaDetailsModel.fromJson(response);
  }
}
