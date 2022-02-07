import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/change_favorites_model.dart';
import 'package:shop_app/models/favorites_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/categories/categories_screen.dart';
import 'package:shop_app/modules/favorites/favorites_screen.dart';
import 'package:shop_app/modules/products/products_screen.dart';
import 'package:shop_app/modules/settings/settings_screen.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates>{
  ShopCubit() : super (ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreens=[
    const ProductScreen(),
    const CategoriesScreen(),
    const FavoritesScreen(),
    /*const*/ SettingsScreen(),
  ];

  void changeBottom(int index){

    currentIndex = index;

    emit(ShopChangeBottomState());
  }

  HomeModel? homeModel;
  Map<int?, bool?> favorites = {};

  void getHomeData(){
    emit(ShopLoadingHomeDataState());

    DioHelper.getData(
        url: HOME,
        token: token,
    ).then(
            (value) {
              homeModel= HomeModel.fromJson(value.data);
              // print(homeModel.toString());
              // print(homeModel!.data!.banners[0].image);
              // print(homeModel!.status);

              homeModel!.data!.products.forEach(
                  (element) {
                    favorites.addAll({
                      element.id : element.inFavorite,
                      });
                    }
                  );
              print(favorites.toString());

              emit(ShopSuccessHomeDataState());

            }).catchError(
            (error){

              print('Error in get home dataaaaaaa');
              print(error.toString());
              emit(ShopErrorHomeDataState(error.toString()));

            });
  }


  CategoriesModel? categoriesModel;

  void getCategories(){

    DioHelper.getData(
        url: GET_CATEGORIES,
    ).then(
            (value) {

              categoriesModel= CategoriesModel.fromJson(value.data);
              print(categoriesModel.toString());
              print(categoriesModel!.data!.data[0].name);
              print(categoriesModel!.data!.currentPage);
              emit(CategoriesSuccessState());

            }).catchError(
            (error){

              print('Error in get categories dataaaaaaa');
              print(error.toString());
              emit(CategoriesErrorState());

            });
  }


  HomeChangeFavoritesModel? homeChangeFavoritesModel;

  void changeFavoritesItems(int? productId){
    favorites[productId] = ! favorites[productId]!;
    emit(HomeChangeFavoritesState());

    DioHelper.postData(
        url: FAVORITES,
        data: {
          'product_id' : productId ,
        },
      token: token,
    ).then((value) {

      homeChangeFavoritesModel = HomeChangeFavoritesModel.fromJson(value.data);
      print(value.data);
      if(!homeChangeFavoritesModel!.status!){
        favorites[productId] = ! favorites[productId]!;
      }else{
        getFavorites();
      }

      emit(HomeSuccessChangeFavoritesState(homeChangeFavoritesModel!));

    }).catchError((error){
      favorites[productId] = ! favorites[productId]!;

      emit(HomeErrorChangeFavoritesState());

    });
  }


  FavoritesModel? favoritesModel;

  void getFavorites(){

    emit(FavoritesLoadingState());

    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {

      favoritesModel = FavoritesModel.fromJson(value.data);
      print(favoritesModel.toString());
      print(value.data.toString());
      print(favoritesModel!.status);
      emit(FavoritesSuccessState());

    }).catchError((error){

      print('Error in get favorites dataaaaaaa');
      print(error.toString());
      emit(FavoritesErrorState());

    });
  }



  LoginModel? loginModel;

  void getProfileInfo(){

    emit(ProfileInfoLoadingState());

    DioHelper.getData(
      url: PROFILE_INFO,
      token: token,
    ).then((value) {

      loginModel = LoginModel.fromJason(value.data);
      print(loginModel.toString());
      print(loginModel!.data!.name);
      print(loginModel!.data!.token);
      print(loginModel!.data!.phone);

      emit(ProfileInfoSuccessState(loginModel!));

    }).catchError((error){

      print('Error in get Profile Info');
      print(error.toString());

      emit(ProfileInfoErrorState());

    });
  }


  void updateProfileInfo({
    required String name,
    required String email,
    required String phone,
  }){

    emit(UpdateProfileLoadingState());

    DioHelper.putData(
      url: UPDATE_PROFILE,
      token: token,
      data: {
        'name' : name,
        'phone' : phone,
        'email' : email,
      },
    ).then((value) {

      loginModel = LoginModel.fromJason(value.data);
      print(loginModel.toString());
      print(loginModel!.data!.name);
      print(loginModel!.data!.token);
      print(loginModel!.data!.phone);

      emit(UpdateProfileSuccessState(loginModel!));

    }).catchError((error){

      print('Error in Update Profile Info');
      print(error.toString());

      emit(UpdateProfileErrorState());

    });
  }

}