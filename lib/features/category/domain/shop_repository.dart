import 'package:salon_reservation/core/api/core_models/empty_model.dart';
import 'package:salon_reservation/features/category/data/model/category_model.dart';

import '../../../core/api/core_models/base_result_model.dart';
import '../../../core/api/data_source/remote_data_source.dart';
import '../../../core/api/http/api_urls.dart';
import '../../../core/api/http/http_method.dart';
import '../../salon/data/model/salon_model.dart';

class SalonRepository {
  static Future<BaseResultModel?> getSalons(dynamic requestData, String service, String latitude, String
  longitude, String query) async {
    final res = await RemoteDataSource.request<SalonsResponseModel>(
        converter: (json) => SalonsResponseModel.fromJson(json),
        method: HttpMethod.get,
        queryParameters: requestData.toJson(),
        withAuthentication: true,
        url: '${ApiURLs.getSalons}?service=$service&longitude=$longitude&latitude=$latitude&name=$query');
    return res;
  }

  static Future<BaseResultModel?> getRestaurants(dynamic requestData, String latitude, String
  longitude, String query) async {
    final res = await RemoteDataSource.request<SalonsResponseModel>(
        converter: (json) => SalonsResponseModel.fromJson(json),
        method: HttpMethod.get,
        queryParameters: requestData.toJson(),
        withAuthentication: true,
        url: '${ApiURLs.getRestaurants}?longitude=$longitude&latitude=$latitude&name=$query');
    return res;
  }
}
