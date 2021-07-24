import 'package:namaz_app/data/model/ahkam_model.dart';
import 'package:namaz_app/data/model/narratives_model.dart';
import 'package:namaz_app/data/model/shohada_model.dart';
import 'package:namaz_app/networking/api_provider.dart';

class AhkamRepository {
  ApiProvider _apiProvider = new ApiProvider();

  Future<AhkamModel> getAhkamItems(
      String marjae_id, String page, String search) async {
    final response = await _apiProvider.get(
        'client_get_ahkam_api.php?marjae_id=${marjae_id}&page=${page}&search=${search}');
    return AhkamModel.fromJson(response);
  }
}
