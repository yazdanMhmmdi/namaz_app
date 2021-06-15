import 'package:namaz_app/data/model/narratives_details_screen.dart';
import 'package:namaz_app/networking/api_provider.dart';

class NarrativesDetailsRepository {
  ApiProvider _apiProvider = new ApiProvider();

  Future<NarrativesDetailsModel> getNarrativesDetails(
      String narratives_id) async {
    final response = await _apiProvider
        .get('client_detail_narratives_api.php?narratives_id=${narratives_id}');
    return NarrativesDetailsModel.fromJson(response);
  }
}
