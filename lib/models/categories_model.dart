/*
class CategoriesModel{
  late bool status;
  late CategoriesDataModel data;

  CategoriesModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    data = CategoriesDataModel.fromJson(json['data']);
  }

}

class CategoriesDataModel{
  late int currentPage;
  List<DataCategoriesDataModel> data=[];

  CategoriesDataModel.fromJson(Map<String, dynamic> json){
    currentPage = json['current_page'];
    json['data'].forEach((element){
      data.add(DataCategoriesDataModel.fromJson(json['data']));
    });

  }
}

class DataCategoriesDataModel{
  late int id;
  late String name;
  late String image;

  DataCategoriesDataModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }

}*/
class CategoriesModel{
  bool? status;
  CategoriesData? data;

  CategoriesModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    data = CategoriesData.fromJson(json['data']);
  }
}

class CategoriesData{
  int? currentPage;
  List<DataCategoriesData> data=[];

  CategoriesData.fromJson(Map<String, dynamic> json){
    currentPage = json['current_page'];
    json['data'].forEach((element){
      data.add(DataCategoriesData.fromJson(element),);
    });
  }
}

class DataCategoriesData{
  int? id;
  String? name;
  String? image;

  DataCategoriesData.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}