import 'package:namaz_app/data/model/sign_up_model.dart';
import 'package:namaz_app/networking/api_provider.dart';

class SignUpRepository {
  ApiProvider _apiProvider = new ApiProvider();

  Future<SignUpModel> signUp(String username, String password) async {
    final response = await _apiProvider
        .get('client_sign_up_api.php?username=${username}&password=${password}');
    return SignUpModel.fromJson(response);
  }
}
