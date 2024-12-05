import 'dart:convert';
import 'dart:developer';

import '../../../../core/api/core_models/base_result_model.dart';

class SalonModel {
  int? id;
  String? name;
  String? type;
  int? userId;
  int? hijabis;
  String? location;
  String? open;
  String? close;
  String? status;
  List<ServiceModel>? service;
  String? image;
  List<MenuItem>? menu;

  SalonModel({
    this.id,
    this.name,
    this.type,
    this.userId,
    this.hijabis,
    this.location,
    this.open,
    this.close,
    this.status,
    this.service,
    this.image,
    this.menu,
  });

  SalonModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    userId = json['user_id'];
    hijabis = json['hijabis'];
    location = json['location'];
    open = json['open'];
    close = json['close'];
    status = json['status'];
    image = json['image'];


    // Parse menu as a list of MenuItem
    if (json['menu'] != null) {
      menu = List<MenuItem>.from(json['menu'].map((item) => MenuItem.fromJson(item)));
    }

    List<ServiceModel> tempList = [];

    if(json['service'] != null) {
      json['service'].forEach((v) {
        tempList.add(ServiceModel.fromJson(v));
      });
      service = tempList;
    }

  }
}

class MenuItem {
  int id;
  int businessId;
  DateTime? createdAt;
  DateTime? updatedAt;

  MenuItem({
    required this.id,
    required this.businessId,
    this.createdAt,
    this.updatedAt,
  });

  factory MenuItem.fromJson(Map<String, dynamic> json) {
    return MenuItem(
      id: json['id'],
      businessId: json['business_id'],
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'business_id': businessId,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}

class Menu {
  List<MenuItem> menu;

  Menu({required this.menu});

  factory Menu.fromJson(Map<String, dynamic> json) {
    return Menu(
      menu: json['menu'] != null
          ? List<MenuItem>.from(json['menu'].map((item) => MenuItem.fromJson(item)))
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'menu': menu.map((item) => item.toJson()).toList(),
    };
  }
}


class ServiceModel {
  int? id;
  int? businessId;
  String? service;
  int? price; 
  String? duration;
  String? type;
  int? status;
  String? name;

  ServiceModel({
    this.id,
    this.service,
    this.businessId,
    this.price,
    this.duration,
    this.type,
    this.status,
    this.name,
  });

  ServiceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    service = json['service'];
    businessId = json['business_id'];
    price = json['price'];
    duration = json['duration'];
    type = json['type'];
    status = json['status'];
    name = json['name'];
  }
}

class SalonsResponseModel extends ListResultModel<SalonModel> {
  int? totalCount;
  late List<SalonModel> data;

  SalonsResponseModel({this.totalCount, required this.data});

  SalonsResponseModel.fromJson(Map<String, dynamic> json) {
    list = <SalonModel>[];

    json['data'].forEach((v) {
      list.add(SalonModel.fromJson(v));
    });

    if (json['data'] != null) {
      data = list;
      totalCount = list.length;
    }
  }
}
