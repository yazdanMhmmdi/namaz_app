import 'package:namaz_app/data/model/home_model.dart';
import 'package:namaz_app/networking/api_provider.dart';

class HomeRepository {
  ApiProvider _apiProvider = new ApiProvider();

  Future<HomeModel> getHomeItems() async {
    final response = await _apiProvider
        .get('client_get_home_api.php?username=xsx');
    return HomeModel.fromJson(response);
  }
}
