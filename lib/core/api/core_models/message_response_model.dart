import 'package:salon_reservation/core/api/core_models/base_result_model.dart';

class MessageResponseModel extends BaseResultModel {
  String? message;

  MessageResponseModel({
    this.message,
  });

  MessageResponseModel.fromJson(Map<String, dynamic> json) {
    message= json['message'];
  }
}