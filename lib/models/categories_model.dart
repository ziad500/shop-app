class CategoriesModel {
  bool? status;
  CategoriesDataModel? data;
  CategoriesModel.fromjson(Map<String, dynamic> json) {
    status = json['status'];
    data = CategoriesDataModel.fromjson(json['data']);
  }
}

class CategoriesDataModel {
  List<DataModel> data = [];
  CategoriesDataModel.fromjson(Map<String, dynamic> json) {
    json['data'].forEach((element) {
      data.add(DataModel.fromjson(element));
    });
  }
}

class DataModel {
  String? name;
  String? image;
  DataModel.fromjson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
  }
}
