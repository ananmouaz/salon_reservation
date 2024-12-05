import '../../../../core/api/core_models/base_result_model.dart';

class CategoryModel {
  int? id;
  String? name;
  String? image;

  CategoryModel({
    this.id,
    this.name,
    this.image,
  });

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    return data;
  }
}

class CategoriesResponseModel extends ListResultModel<CategoryModel> {
  int? totalCount;
  late List<CategoryModel> data;

  CategoriesResponseModel({this.totalCount, required this.data});

  CategoriesResponseModel.fromJson(Map<String, dynamic> json) {
    list = <CategoryModel>[];

    json['data'].forEach((v) {
      list.add(CategoryModel.fromJson(v));
    });

    if (json['data'] != null) {
      data = list;
      totalCount = list.length;
    }
  }
}
