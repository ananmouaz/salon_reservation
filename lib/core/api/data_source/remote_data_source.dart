import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../../features/user/domain/user_reposirory.dart';
import '../../constants/app_keys.dart';
import '../../utils/di.dart';
import '../../utils/shared_perefrences/shared_perefrences_helper.dart';
import '../core_models/base_result_model.dart';
import '../errors/net_error.dart';
import '../errors/unauthorized_error.dart';
import '../http/api_provider.dart';

class RemoteDataSource {
  static final AppPreferences _appPreferences = instance<AppPreferences>();

  static Future request<Response extends BaseResultModel>({
    required Response Function(Map<String, dynamic> json) converter,
    required String method,
    required String url,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
    Map<String, String>? files,
    bool withAuthentication = true,
    bool passAuthentication = false,
    CancelToken? cancelToken,
    bool isLongTime = false,
    int retries = 0,
  }) async {

    Map<String, String> headers = {
      HEADER_CONTENT_TYPE: "application/json",
      HEADER_ACCEPT: "application/json",
    };


    if (withAuthentication) {
      if (_appPreferences.hasAccessToken()) {
        headers.putIfAbsent(
            HEADER_AUTH, () => ('Bearer ${_appPreferences.getAccessToken()}'));
      } else {
        //UserRepository.logout(AppKeys.navigatorKey.currentContext!);
        return UnauthorizedError();
      }
    }

    // Send the request.
    final response = await ApiProvider.sendObjectRequest<Response>(
        method: method,
        url: url,
        converter: converter,
        headers: headers,
        queryParameters: queryParameters ?? {},
        data: data ?? {},
        files: files,
        isLongTime: isLongTime,
        cancelToken: cancelToken,
        retries: retries);

    // if success, return result
    if (response.success!) {
      return response.result;
    }

    // if there is a server error check for it
    if (response.serverError != null) {

      // if network error
      if (response.error is NetError) {
        return NetError();
      }

      return response.serverError;
    }

    else {
      return response.error;
    }
  }
}
