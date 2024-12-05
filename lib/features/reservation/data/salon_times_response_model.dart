import '../../../core/api/core_models/base_result_model.dart';

class SalonTimeModel {
  String? time;

  SalonTimeModel({
    this.time,
  });

  SalonTimeModel.fromJson(Map<String, dynamic> json) {
    time = json['time'];
  }
}


class SalonTimesResponseModel extends BaseResultModel{
  List<SalonTimeModel>? items;

  SalonTimesResponseModel({
    required this.items,
  });

  SalonTimesResponseModel.fromJson(Map<String, dynamic> json) {
    List<SalonTimeModel> list = <SalonTimeModel>[];

    json['Available Slots'].forEach((v) {
      list.add(SalonTimeModel.fromJson(v));
    });
    items = list;
  }
}

