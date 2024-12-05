import '../errors/base_error.dart';
import 'base_result_model.dart';

class BaseResponseModel<Result extends BaseResultModel> {
  Result? result;
  bool? success;
  BaseError? error;
  ServerError? serverError;

  BaseResponseModel(
      {
        this.result,
        this.success,
        this.serverError,
        this.error,
        });

  BaseResponseModel.fromJson(
      {Map<String, dynamic>? json,
        Result Function(Map<String, dynamic>)? fromJson,
        BaseError? error}) {
    if(json?['error'] != null || error != null) {
      success = false;
      this.error = error;
      this.serverError = ServerError(error: json?['error']);
    }

    else {
      if( fromJson != null) {
        success = true;
        if(json?['result'] != null) {
          result = fromJson(json?['result']);
        }
        else {
          success = true;
          result = fromJson({});
        }
      }
    }
  }

}

class ServerError extends BaseResultModel {
  String? error;

  ServerError({this.error});

  ServerError.fromJson(Map<String, dynamic> json) {
    error = json['error'];
  }
}

