import 'package:salon_reservation/core/api/core_models/base_result_model.dart';

class RegisterResponseModel extends BaseResultModel {
  String? message;

  RegisterResponseModel({
    required this.message,
});

  RegisterResponseModel.fromJson(Map<String, dynamic> json) {
      message = json['message'];
  }
}