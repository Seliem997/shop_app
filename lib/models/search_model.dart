class SearchModel{
  bool? status;
  SearchData? data;

  SearchModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    data = SearchData.fromJson(json['data']);

  }
}

class SearchData{
  int? currentPage;
  List<DataSearchData> data=[];

  SearchData.fromJson(Map<String, dynamic> json){
    currentPage = json['current_page'];
    json['data'].forEach((element){
      data.add(DataSearchData.fromJson(json['data']));
    });
  }
}
class DataSearchData{
  int? id;
  dynamic price;
  dynamic oldPrice;
  int? discount;
  String? image;
  String? name;
  String? description;
  bool? inFavorites;
  bool? inCart;

  DataSearchData.fromJson(Map<String, dynamic> json){
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}