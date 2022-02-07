class HomeChangeFavoritesModel{
  bool? status;
  String? message;

  HomeChangeFavoritesModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    message = json['message'];
  }
}