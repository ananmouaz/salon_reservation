import 'package:salon_reservation/core/api/core_models/base_result_model.dart';

class UserModel {
  String? name;
  String? phoneNumber;
  String? password;

  UserModel({
    required this.name,
    required this.phoneNumber,
     this.password,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      phoneNumber: json['phone_number'],
      password: json['password'],
    );
  }

  static UserModel fromJsonCustom(Map<String, dynamic> json) {
    return UserModel(
    name: json['name'],
    phoneNumber: json['phone_number'],);
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phoneNumber': phoneNumber,
      'password': password,
    };
  }
}

class UserGetModel extends BaseResultModel{
  UserModel? user;
  Location? location;

  UserGetModel({
    required this.user,
    required this.location,
  });

  factory UserGetModel.fromJson(Map<String, dynamic> json) {
    return UserGetModel(
      user: UserModel.fromJsonCustom(json['user']),
      location: Location.fromJson(json['location']),
    );
  }
}

class Location {
  String area;
  String street;
  String building;
  double latitude;
  double longitude;

  Location({
    required this.area,
    required this.street,
    required this.building,
    required this.latitude,
    required this.longitude,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      area: json['area'],
      street: json['sreet'],
      building: json['building'],
      latitude: double.parse(json['latitude']),
      longitude: double.parse(json['longitude']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'area': area,
      'street': street,
      'building': building,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
