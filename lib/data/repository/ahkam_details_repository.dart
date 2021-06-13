import 'package:namaz_app/data/model/ahkam_details_model.dart';
import 'package:namaz_app/data/model/ahkam_model.dart';
import 'package:namaz_app/data/model/narratives_model.dart';
import 'package:namaz_app/data/model/shohada_model.dart';
import 'package:namaz_app/networking/api_provider.dart';

class AhkamDetailsRepository {
  ApiProvider _apiProvider = new ApiProvider();

  Future<AhkamDetailsModel> getAhkamDetails(String ahkam_id) async {
    final response = await _apiProvider
        .get('client_detail_ahkam_api.php?ahkam_id=${ahkam_id}');
    return AhkamDetailsModel.fromJson(response);
  }
}
