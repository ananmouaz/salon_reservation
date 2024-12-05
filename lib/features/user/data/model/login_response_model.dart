import 'package:salon_reservation/core/api/core_models/base_result_model.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';
import 'dart:io';

import 'package:salon_reservation/features/user/data/model/user_model.dart';




class TokenOriginal {
  String? token;
  UserModel? user;

  TokenOriginal({
    required this.token,
    required this.user,
  });

  factory TokenOriginal.fromJson(Map<String, dynamic> json) {
    return TokenOriginal(
      token: json['access_token'],
      user: UserModel.fromJsonCustom(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'access_token': token,
      'user': user,
    };
  }
}

class Token {
  TokenOriginal? original;

  Token({
    required this.original,
  });

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(
      original: TokenOriginal.fromJson(json['original']),
    );
  }
}

class LoginResponseModel extends BaseResultModel {
  UserModel? user;
  String? token;

  LoginResponseModel({
    this.user,
    this.token,
  });

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    return data;
  }


  LoginResponseModel.fromJson(Map<String, dynamic> json) {
      user = UserModel.fromJson(json['user']);
      token = json['token'];
  }

  static Future<String> getFilePath() async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/login.json').path;
  }

  static saveLoginToFile(LoginResponseModel loginResponseModel) async {
    final file = File(await getFilePath());
    final jsonFile = loginResponseModel.toJson();
    await file.writeAsString(json.encode(jsonFile));
  }

  static Future<LoginResponseModel> getLoginFromFile() async {
    try {
      final file = File(await getFilePath());
      final jsonData = json.decode(await file.readAsString());
      return LoginResponseModel(token: jsonData['token'],);
    } catch (e) {
      return LoginResponseModel();
    }
  }
}