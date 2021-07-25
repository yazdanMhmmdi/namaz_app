import 'package:namaz_app/data/model/narratives_model.dart';
import 'package:namaz_app/data/model/shohada_model.dart';
import 'package:namaz_app/networking/api_provider.dart';

class NarrativesRepository {
  ApiProvider _apiProvider = new ApiProvider();

  Future<NarrativesModel> getShohadaItems(String page,String search) async {
    final response = await _apiProvider
        .get('client_get_narratives_api?page=${page}&search=${search}');
    return NarrativesModel.fromJson(response);
  }
}
