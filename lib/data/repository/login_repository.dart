import 'package:namaz_app/data/model/login_model.dart';
import 'package:namaz_app/networking/api_provider.dart';

class SignUpRepository {
  ApiProvider _apiProvider = new ApiProvider();

  Future<LoginModel> login(String username, String password) async {
    final response = await _apiProvider.get(
        'client_log_in_api.php?username=${username}&password=${password}');
    return LoginModel.fromJson(response);
  }
}
