import 'package:namaz_app/data/model/marjae_model.dart';
import 'package:namaz_app/networking/api_provider.dart';

class MarjaeRepository {
  ApiProvider _apiProvider = new ApiProvider();

  Future<MarjaeModel> getMarjaeItems() async {
    final response = await _apiProvider
        .get('client_get_marjae_api.php?username=xsx');
    return MarjaeModel.fromJson(response);
  }
}
