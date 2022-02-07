import 'package:shop_app/models/change_favorites_model.dart';
import 'package:shop_app/models/login_model.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopChangeBottomState extends ShopStates {}

class ShopLoadingHomeDataState extends ShopStates {}

class ShopSuccessHomeDataState extends ShopStates {}

class ShopErrorHomeDataState extends ShopStates {
  final String error;

  ShopErrorHomeDataState(this.error);
}

class CategoriesSuccessState extends ShopStates {}

class CategoriesErrorState extends ShopStates {}


class HomeChangeFavoritesState extends ShopStates {}


class HomeSuccessChangeFavoritesState extends ShopStates {
  final HomeChangeFavoritesModel model;
  HomeSuccessChangeFavoritesState(this.model);
}

class HomeErrorChangeFavoritesState extends ShopStates {}


class FavoritesLoadingState extends ShopStates {}

class FavoritesSuccessState extends ShopStates {}

class FavoritesErrorState extends ShopStates {}


class ProfileInfoLoadingState extends ShopStates {}

class ProfileInfoSuccessState extends ShopStates {

  final LoginModel loginModel;
  ProfileInfoSuccessState(this.loginModel);

}

class ProfileInfoErrorState extends ShopStates {}


class UpdateProfileLoadingState extends ShopStates {}

class UpdateProfileSuccessState extends ShopStates {

  final LoginModel loginModel;
  UpdateProfileSuccessState(this.loginModel);

}

class UpdateProfileErrorState extends ShopStates {}