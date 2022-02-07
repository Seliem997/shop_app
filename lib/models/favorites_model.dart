class FavoritesModel{
  bool? status;
  FavoritesData? data;

  FavoritesModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    data = FavoritesData.fromJson(json['data']);
  }

}

class FavoritesData{
  int? currentPage;
  List<DataFavoritesModel> data=[];

  FavoritesData.fromJson(Map<String, dynamic> json){
    currentPage = json['current_page'];
    json['data'].forEach((element){
      data.add(DataFavoritesModel.fromJson(element),);
    });
  }

}

class DataFavoritesModel{
  int? id;
  ProductsData? productsData;

  DataFavoritesModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    productsData = ProductsData.fromJson(json['product']);
  }

}

class ProductsData{
  int? id;
  dynamic price;
  dynamic oldPrice;
  int? discount;
  String? image;
  String? name;
  String? description;

  ProductsData.fromJson(Map<String, dynamic> json){
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }
}