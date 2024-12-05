import 'package:salon_reservation/features/user/data/model/user_model.dart';

class RegisterRequestModel {
  UserModel user;

  RegisterRequestModel({required this.user});

  Map<String, dynamic> toJson() {
    return {
      'phone_number': user.phoneNumber,
      'password': user.password,
      'name': user.name,
    };
  }
}