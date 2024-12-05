import 'package:easy_localization/easy_localization.dart';
import 'package:salon_reservation/core/api/core_models/base_response_model.dart';
import 'package:salon_reservation/features/category/data/model/category_model.dart';

import '../../../core/api/core_models/base_result_model.dart';
import '../../../core/api/core_models/message_response_model.dart';
import '../../../core/api/data_source/remote_data_source.dart';
import '../../../core/api/http/api_urls.dart';
import '../../../core/api/http/http_method.dart';
import '../data/booking_request_model.dart';
import '../data/reservation_model.dart';
import '../data/review_request_model.dart';
import '../data/salon_times_response_model.dart';

class ReservationRepository {
  static Future<BaseResultModel?> getReservations(dynamic requestData) async {
    final res = await RemoteDataSource.request<MyReservationsResponseModel>(
        converter: (json) => MyReservationsResponseModel.fromJson(json),
        method: HttpMethod.get,
        queryParameters: requestData.toJson(),
        withAuthentication: true,
        url: ApiURLs.myBooking);
    return res;
  }

  static Future<BaseResultModel?> getTimesOfDay(String id, String date) async {
    final res = await RemoteDataSource.request<SalonTimesResponseModel>(
        converter: (json) => SalonTimesResponseModel.fromJson(json),
        method: HttpMethod.get,
        withAuthentication: true,
        url: '${ApiURLs.timesOfDay}/$id/$date');
    return res;
  }

  /// Add review
  static Future<BaseResultModel?> addReview(
      ReviewRequestModel reviewRequestModel) async {
    try {
      final res = await RemoteDataSource.request<MessageResponseModel>(
          converter: (json) => MessageResponseModel.fromJson(json),
          method: HttpMethod.post,
          data: reviewRequestModel.toJson(),
          url: ApiURLs.review);
      if(res is MessageResponseModel) {

      }
      return res;

    } catch(e) {
      print(e);
    }
  }

  /// Create a booking
  static Future<BaseResultModel?> addBooking(
      BookingRequestModel bookingRequestModel) async {
    try {
      final res = await RemoteDataSource.request<MessageResponseModel>(
          converter: (json) => MessageResponseModel.fromJson(json),
          method: HttpMethod.post,
          withAuthentication: true,
          data: bookingRequestModel.toJson(),
          url: ApiURLs.booking);
      if(res is MessageResponseModel) {

      }
      return res;

    } catch(e) {
      print(e);
    }
  }
}
