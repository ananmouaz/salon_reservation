import 'package:salon_reservation/features/salon/data/model/salon_model.dart';

import '../../../../core/api/core_models/base_result_model.dart';

class Reservation {
  int? id;
  String? time;
  String? status;
  int? userId;
  int? businessId;
  int? serviceId;
  ServiceModel? service;
  SalonModel? business;

  Reservation({
    this.id,
    this.time,
    this.status,
    this.userId,
    this.businessId,
    this.serviceId,
    this.service,
    this.business,
  });

  Reservation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    time = json['time'];
    status = json['status'];
    userId = json['user_id'];
    businessId = json['business_id'];
    serviceId = json['service_id'];
    service = ServiceModel.fromJson(json['service']);
    business = SalonModel.fromJson(json['business']);
  }
}



class MyReservationsResponseModel extends ListResultModel<Reservation> {
  int? totalCount;
  late List<Reservation> data;

  MyReservationsResponseModel({this.totalCount, required this.data});

  MyReservationsResponseModel.fromJson(Map<String, dynamic> json) {
    list = <Reservation>[];

    json['data'].forEach((v) {
      list.add(Reservation.fromJson(v));
    });

    if (json['data'] != null) {
      data = list;
      totalCount = list.length;
    }
  }
}
