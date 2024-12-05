import 'package:salon_reservation/core/api/core_models/message_response_model.dart';
import 'package:salon_reservation/features/user/data/model/register_request_model.dart';
import 'package:salon_reservation/features/user/data/model/register_response_model.dart';
import 'package:salon_reservation/features/user/data/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/api/core_models/base_result_model.dart';
import '../../../../core/api/data_source/remote_data_source.dart';
import '../../../../core/api/http/api_urls.dart';
import '../../../../core/api/http/http_method.dart';
import '../../../../core/utils/di.dart';
import '../../../../core/utils/shared_perefrences/shared_perefrences_helper.dart';
import '../../../core/notification/notification_messaging.dart';
import '../../../core/utils/navigation.dart';
import '../data/model/login_request_model.dart';
import '../data/model/login_response_model.dart';
import '../presentation/pages/login_page.dart';

class UserRepository {
  static final AppPreferences _appPreferences = instance<AppPreferences>();

  static Future<BaseResultModel?> register(
      RegisterRequestModel registerRequestModel) async {
    final res = await RemoteDataSource.request<MessageResponseModel>(
        converter: (json) => MessageResponseModel.fromJson(json),
        method: HttpMethod.post,
        data: registerRequestModel.toJson(),
        withAuthentication: false,
        passAuthentication: true,
        url: ApiURLs.register);
    return res;
  }

  /// Login using username
  static Future<BaseResultModel?> login(
      LoginRequestModel loginRequestModel) async {
    try {
      final res = await RemoteDataSource.request<LoginResponseModel>(
          converter: (json) => LoginResponseModel.fromJson(json),
          method: HttpMethod.post,
          data: loginRequestModel.toJson(),
          withAuthentication: false,
          passAuthentication: true,
          url: ApiURLs.login);
      await afterLogin(res);
      return res;

    } catch(e) {
      print(e);
    }
  }

  /// Gets user info
  static Future<BaseResultModel?> getUserInfo() async {
    try {
      final res = await RemoteDataSource.request<UserGetModel>(
          converter: (json) => UserGetModel.fromJson(json),
          method: HttpMethod.get,
          withAuthentication: true,
          url: ApiURLs.getUserInfo);
      return res;
    } catch(e) {
      print(e);
    }
  }


static Future<void> afterLogin(LoginResponseModel loginResponse) async {
    _appPreferences.setAccessToken(loginResponse.token ?? '');
    _appPreferences.setName(loginResponse.user?.name ?? '');
    _appPreferences.setPhone(loginResponse.user?.phoneNumber ?? '');
  }

  /// Remove FCM token
  static Future<void> removeFCMToken() async {
    if(Messaging.token != null) {
      Messaging.deleteToken();
    }
  }


  /// Logout
  static Future<void> logout(BuildContext context) async {
    await removeFCMToken();
    _appPreferences.clearForLogOut();
    Future.delayed(const Duration(milliseconds: 0), () {
      Navigation.pushReplacement(context, const LoginPage());
    },);
  }
}
